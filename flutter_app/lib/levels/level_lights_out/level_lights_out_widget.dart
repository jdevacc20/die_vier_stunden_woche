import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/levels/level_wrapper.dart';
import 'package:flutter_app/models/settings_model.dart';
import 'package:provider/provider.dart';

class LevelLightsOutWidget extends StatefulWidget {
  const LevelLightsOutWidget({super.key});

  @override
  State<StatefulWidget> createState() => _LevelLightsOutWidget();
}

class _LevelLightsOutWidget extends State<LevelLightsOutWidget> {
  bool _done = false;
  bool? darkMode;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      builder: ((context, settingsModel, child) {
        double size = min(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height) *
            0.8;

        //current dark mode on (provider or system)
        bool curDarkMode =
            settingsModel.getThemeMode(context) == ThemeMode.dark;

        if (darkMode == null) {
          darkMode = curDarkMode;
        } else if (darkMode != curDarkMode) {
          darkMode = curDarkMode;
          _done = true;
        }
        return LevelWrapper(
          title: "Logical Thinking",
          description: _done
              ? "Solved!"
              : context.isDarkMode
                  ? "Switch the light on!"
                  : "Switch the light out!",
          done: _done,
          hint: "denk nach pisser",
          levelChild: Center(
            child: SizedBox(
              height: size,
              width: size,
              child: _LightsOutWidget(
                cols: 3,
                done: _done,
                darkMode: darkMode ?? false,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _LightsOutWidget extends StatefulWidget {
  final int cols;
  final bool done;
  final bool darkMode;

  const _LightsOutWidget({
    required this.done,
    required this.darkMode,
    this.cols = 3,
  });

  @override
  State<StatefulWidget> createState() => _LightsOutState();
}

class _LightsOutState extends State<_LightsOutWidget> {
  List<List<int>> _state = [];

  @override
  void initState() {
    _state = List<List<int>>.generate(
      widget.cols,
      (index) => List<int>.generate(
        widget.cols,
        (_) => 0,
      ),
    );
    if (!widget.done) {
      _state[Random().nextInt(widget.cols)][Random().nextInt(widget.cols)] =
          1; //one light on
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.done) {
      _state = List<List<int>>.generate(
        widget.cols,
        (index) => List<int>.generate(
          widget.cols,
          (_) => widget.darkMode ? 0 : 1,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 1,
      child: GridView.count(
        crossAxisCount: widget.cols,
        children: List.generate(
          widget.cols * widget.cols,
          (index) {
            int row = index ~/ widget.cols;
            int col = index % widget.cols;
            int value = _state[row][col];
            return Card(
              child: InkWell(
                onTap: () {
                  if (widget.done) {
                    return;
                  }
                  List<List<int>> newState = List.from(_state);
                  newState[row][col] = 1 - value; // change actual value
                  if (col > 0) {
                    newState[row][col - 1] = 1 - newState[row][col - 1]; //left
                  }
                  if (col < widget.cols - 1) {
                    newState[row][col + 1] = 1 - newState[row][col + 1]; //right
                  }
                  if (row > 0) {
                    newState[row - 1][col] = 1 - newState[row - 1][col]; //above
                  }
                  if (row < widget.cols - 1) {
                    newState[row + 1][col] = 1 - newState[row + 1][col]; //below
                  }

                  bool all_zero = true;
                  bool all_one = true;
                  for (List<int> row in newState) {
                    if (row.contains(0)) {
                      all_one = false;
                    }
                    if (row.contains(1)) {
                      all_zero = false;
                    }
                  }

                  if (all_zero) {
                    newState[Random().nextInt(widget.cols)]
                        [Random().nextInt(widget.cols)] = 1;
                  }
                  if (all_one) {
                    newState[Random().nextInt(widget.cols)]
                        [Random().nextInt(widget.cols)] = 0;
                  }

                  setState(() {
                    _state = newState;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 5),
                      color: value == 1 ? Colors.white : Colors.black),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

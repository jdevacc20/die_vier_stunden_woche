import 'package:flutter/material.dart';
import 'package:flutter_app/levels/home/levels.dart';
import 'package:flutter_app/models/settings_model.dart';
import 'package:provider/provider.dart';

import '../models/level_model.dart';

class LevelWrapper extends StatefulWidget {
  final String title;
  final String description;
  final bool done;
  final Widget levelChild;

  const LevelWrapper(
      {super.key,
      required this.title,
      required this.description,
      required this.done,
      required this.levelChild});

  @override
  State<LevelWrapper> createState() => _LevelWrapperState();
}

class _LevelWrapperState extends State<LevelWrapper> {
  bool _menuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<LevelModel>(builder: (context, levelModel, child) {
      return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: FittedBox(
                              child: AnimatedRotation(
                            turns: _menuOpen ? (6 / 45) : 0,
                            duration: const Duration(milliseconds: 200),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _menuOpen = true;
                                  });
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    builder: ((context) {
                                      return _BottomSheetDialogWidget();
                                    }),
                                  ).whenComplete(() {
                                    setState(() {
                                      _menuOpen = false;
                                    });
                                  });
                                },
                                child: const Icon(Icons.settings)),
                          ))),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FutureBuilder(
                        future: levelModel.getCurrentLevel(),
                        builder: (context, snapshot) {
                          return LinearProgressIndicator(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                            value: (snapshot.data ?? 0) / levels.length,
                          );
                        }),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Expanded(
                child: widget.levelChild,
              ),
              if (widget.done)
                GestureDetector(
                  onTap: () async {
                    await levelModel.increaseLevel();
                  },
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: const Center(
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

class _BottomSheetDialogWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomSheetDialogState();
}

class _BottomSheetDialogState extends State<_BottomSheetDialogWidget> {
  bool _sound = false;
  bool _darkMode = false;
  int _simpleMode = 0;
  double _volume = 1;
  double _contrast = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<SettingsModel>(
          builder: (context, settingsProvider, child) {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Dark Mode"),
                      )),
                      Switch(
                        value: settingsProvider.getThemeMode(context) ==
                            ThemeMode.dark,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (p0) {
                          setState(() {
                            _darkMode = p0;
                          });
                          settingsProvider.setDarkMode(p0);
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Syncing"),
                      )),
                      Switch(
                        value: false,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (_) {},
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Sound"),
                      )),
                      Switch(
                        value: _sound,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (p0) {
                          setState(() {
                            _sound = p0;
                          });
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Volume"),
                      )),
                      Slider(
                        min: 1,
                        max: 10,
                        activeColor: Theme.of(context).shadowColor,
                        thumbColor: Theme.of(context).primaryColor,
                        divisions: 9,
                        label: "$_volume",
                        onChanged: (double value) {
                          setState(() {
                            _volume = value;
                          });
                        },
                        value: _volume,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Contrast"),
                      )),
                      Slider(
                        min: 1,
                        max: 10,
                        divisions: 9,
                        label: "$_contrast",
                        activeColor: Theme.of(context).shadowColor,
                        thumbColor: Theme.of(context).primaryColor,
                        onChanged: (double value) {
                          setState(() {
                            _contrast = value;
                          });
                        },
                        value: _contrast,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Difficulty"),
                      )),
                      DropdownButton(
                        value: _simpleMode,
                        items: const [
                          DropdownMenuItem(value: 0, child: Text("Simple")),
                          DropdownMenuItem(
                              value: 1, child: Text("Very Simple")),
                          DropdownMenuItem(
                              value: 2,
                              child: Text("Extremely Simple (Come on)")),
                        ],
                        onChanged: ((value) {
                          setState(() {
                            _simpleMode = value ?? 0;
                          });
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: const [
                      Expanded(
                          child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Expected Time"),
                      )),
                      Text("You will propably never finish this game")
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

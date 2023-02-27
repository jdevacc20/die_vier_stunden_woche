import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/levels/level_wrapper.dart';
import 'package:flutter_app/models/level_model.dart';
import 'package:provider/provider.dart';

class LevelShapesWidget extends StatefulWidget {
  const LevelShapesWidget({super.key});

  @override
  State<StatefulWidget> createState() => _LevelShapesWidget();
}

class _LevelShapesWidget extends State<LevelShapesWidget> {
  bool done = false;
  Timer _timer = Timer(const Duration(seconds: 0), () {});
  int _level = 1;
  final int _levelCount = 3;
  List<double> _heightFactors = [0.5, 0.3, 0.8, 0.3];
  List<double> _widthFactors = [0.4, 0.6, 0.3, 0.6];
  List<Color> _colors = [Colors.red, Colors.green, Colors.yellow, Colors.black];
  int _timeLeft = 0;

  final List<Color> _availableColors = [
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.brown,
    Colors.purple,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_timeLeft > 0) {
        _timeLeft -= 1;
      } else if (_level == _levelCount) {
        setState(() {
          done = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return LevelWrapper(
      title: "Eyesight Test",
      description: "Click on the red shape!",
      done: done,
      levelChild: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _LevelShapesSingleShapeWidget(
                  color: _colors[0],
                  heightFactor: _heightFactors[0],
                  widthFactor: _widthFactors[0],
                  onTap: onShapeTap,
                ),
                _LevelShapesSingleShapeWidget(
                  color: _colors[1],
                  heightFactor: _heightFactors[1],
                  widthFactor: _widthFactors[1],
                  onTap: onShapeTap,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _LevelShapesSingleShapeWidget(
                  color: _colors[2],
                  heightFactor: _heightFactors[2],
                  widthFactor: _widthFactors[2],
                  onTap: onShapeTap,
                ),
                _LevelShapesSingleShapeWidget(
                  color: _colors[3],
                  heightFactor: _heightFactors[3],
                  widthFactor: _widthFactors[3],
                  onTap: onShapeTap,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void onShapeTap(Color color) {
    if (color == Colors.red) {
      startNewRound();
    } else {
      _level = 0; //next level will be 1
      startNewRound();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Leider falsch, probier es nochmal!"),
        ),
      );
    }
  }

  void startNewRound() {
    setState(() {
      _level = _level + 1;
      updateSizeConstraints();

      //get new colors
      int index = Random().nextInt(4);
      if (_level == _levelCount) {
        //last round, color is not selectable
        index = 4; //red color not reachable
        _timeLeft = 20; //20 seconds to wait
      }
      List<Color> colorsCopy = List.from(_availableColors);
      colorsCopy.shuffle();
      colorsCopy[index] = Colors.red;
      _colors = colorsCopy.sublist(0, 4);
    });
  }

  void updateSizeConstraints() {
    List<double> newHeightFactors = [];
    List<double> newWidthFactors = [];
    for (int i = 0; i < 4; i++) {
      newHeightFactors.add(Random().nextDouble() * 0.8 + 0.2);
      newWidthFactors.add(Random().nextDouble() * 0.8 + 0.2);
    }
    _heightFactors = newHeightFactors;
    _widthFactors = newWidthFactors;
  }
}

class _LevelShapesSingleShapeWidget extends StatelessWidget {
  final Color color;
  final double heightFactor;
  final double widthFactor;
  final Function(Color) onTap;

  const _LevelShapesSingleShapeWidget({
    required this.color,
    required this.heightFactor,
    required this.widthFactor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(color);
      },
      child: AnimatedContainer(
        height: (MediaQuery.of(context).size.height / 2 - 100) * heightFactor,
        width: (MediaQuery.of(context).size.width / 2 - 100) * widthFactor,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(Random().nextDouble() * 100),
        ),
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      ),
    );
  }
}

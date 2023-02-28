import 'package:flutter/material.dart';
import 'dart:math' as math;

class TileWidget extends StatelessWidget {
  // alle int variablen nehmen werte 0 - 2 an
  final int shape;
  final int size;

  final bool bar;
  final int barOrientation;
  final int barColor;

  final List<IconData> icons = [
    Icons.star,
    Icons.circle,
    Icons.square,
    Icons.question_mark,
    Icons.horizontal_rule,
  ];

  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.grey,
  ];

  TileWidget({
    super.key,
    required this.shape,
    required this.size,
    required this.bar,
    this.barOrientation = 0,
    this.barColor = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Stack(
            children: [
              Visibility(
                visible: bar,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Transform.rotate(
                  angle: (math.pi / 4) * barOrientation,
                  child: Icon(
                    icons[4],
                    size: 100.0,
                    //color: Colors.grey,
                    color: colors[barColor],
                  ),
                ),
              ),
              Positioned(
                top: (70 - 15 * size) / 2,
                left: (70 - 15 * size) / 2,
                child: Icon(
                  icons[shape],
                  size: 30.0 + 15 * size,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// ignore_for_file: prefer_const_constructors
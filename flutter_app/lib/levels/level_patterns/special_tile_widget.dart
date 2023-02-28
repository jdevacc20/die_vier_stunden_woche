import 'package:flutter/material.dart';
import 'dart:math' as math;

class SpecialTileWidget extends StatefulWidget {
  // alle int variablen nehmen werte 0 - 2 an
  final int shape;
  final int size;

  final bool bar;
  final int barOrientation;
  final int barColor;

  SpecialTileWidget({
    super.key,
    required this.shape,
    required this.size,
    required this.bar,
    this.barOrientation = 0,
    this.barColor = 0,
  });

  @override
  State<SpecialTileWidget> createState() => _SpecialTileWidgetState();
}

class _SpecialTileWidgetState extends State<SpecialTileWidget> {
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
  ];

  bool wasDragged = false;

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
                visible: !wasDragged,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Transform.rotate(
                  angle: (math.pi / 4) * widget.barOrientation,
                  child: Draggable<int>(
                    data: 1,
                    feedback: Icon(
                      icons[4],
                      size: 100.0,
                      //color: Colors.grey,
                      color: colors[widget.barColor],
                    ),
                    onDragCompleted: () {
                      setState(() {
                        wasDragged = true;
                      });
                    },
                    childWhenDragging: Visibility(
                      visible: false,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Icon(
                        icons[4],
                        size: 100.0,
                        //color: Colors.grey,
                        color: colors[widget.barColor],
                      ),
                    ),
                    child: Icon(
                      icons[4],
                      size: 100.0,
                      //color: Colors.grey,
                      color: colors[widget.barColor],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: (70 - 15 * widget.size) / 2,
                left: (70 - 15 * widget.size) / 2,
                child: Column(
                  children: [
                    Icon(
                      icons[widget.shape],
                      size: 30.0 + 15 * widget.size,
                    ),
                  ],
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
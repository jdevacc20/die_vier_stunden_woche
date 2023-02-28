import 'package:flutter/material.dart';
import 'package:flutter_app/levels/level_patterns/tile_widget.dart';
import 'package:flutter_app/levels/level_patterns/special_tile_widget.dart';
import 'dart:math' as math;

class Stage3Widget extends StatefulWidget {
  final Function() nextLevel;
  const Stage3Widget({
    super.key,
    required this.nextLevel,
  });

  @override
  State<Stage3Widget> createState() => _Stage3WidgetState();
}

class _Stage3WidgetState extends State<Stage3Widget> {
  final _formKey = GlobalKey<FormState>();
  String? _selection = "";
  bool dragged = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Problem
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TileWidget(
              shape: 0,
              size: 2,
              bar: true,
              barOrientation: 2,
              barColor: 2,
            ),
            TileWidget(
              shape: 2,
              size: 1,
              bar: true,
              barOrientation: 0,
              barColor: 1,
            ),
            TileWidget(
              shape: 1,
              size: 0,
              bar: true,
              barOrientation: 1,
              barColor: 0,
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TileWidget(
              shape: 1,
              size: 1,
              bar: true,
              barOrientation: 0,
              barColor: 2,
            ),
            TileWidget(
              shape: 0,
              size: 1,
              bar: true,
              barOrientation: 1,
              barColor: 0,
            ),
            TileWidget(
              shape: 2,
              size: 2,
              bar: true,
              barOrientation: 2,
              barColor: 1,
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TileWidget(
              shape: 2,
              size: 0,
              bar: true,
              barOrientation: 1,
              barColor: 1,
            ),
            TileWidget(
              shape: 1,
              size: 2,
              bar: true,
              barOrientation: 2,
              barColor: 2,
            ),
            TileWidget(
              shape: 3,
              size: 2,
              bar: false,
            ),
          ]),

          // Divider
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 20),

          // Solutions
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(children: [
              DragTarget<int>(
                builder: (context, candidateData, rejectedData) {
                  return dragged
                      ? TileWidget(
                          shape: 0,
                          size: 0,
                          bar: true,
                          barColor: 0,
                        )
                      : TileWidget(
                          shape: 0,
                          size: 0,
                          bar: false,
                        );
                },
                onAccept: (data) {
                  setState(() {
                    dragged = true;
                  });
                },
              ),

              // fence

              Radio(
                activeColor: Theme.of(context).shadowColor,
                value: "a",
                groupValue: _selection,
                onChanged: (value) {
                  setState(() {
                    _selection = value;
                  });
                },
              ),
            ]),
            Column(children: [
              SpecialTileWidget(
                shape: 1,
                size: 0,
                bar: true,
                barOrientation: 0,
                barColor: 0,
              ),
              Radio(
                activeColor: Theme.of(context).shadowColor,
                value: "b",
                groupValue: _selection,
                onChanged: (value) {
                  setState(() {
                    _selection = value;
                  });
                },
              ),
            ]),
            Column(children: [
              TileWidget(
                shape: 2,
                size: 1,
                bar: true,
                barOrientation: 1,
                barColor: 1,
              ),
              Radio(
                activeColor: Theme.of(context).shadowColor,
                value: "c",
                groupValue: _selection,
                onChanged: (value) {
                  setState(() {
                    _selection = value;
                  });
                },
              ),
            ]),
          ]),

          SizedBox(height: 50),

          // Submit
          MaterialButton(
            onPressed: () {
              if (_selection == "a" && dragged) {
                //value.increaseLevel();
                widget.nextLevel();
              }
            },
            color: Theme.of(context).primaryColor,
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}



// ignore_for_file: prefer_const_constructors


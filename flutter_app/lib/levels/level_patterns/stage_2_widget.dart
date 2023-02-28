import 'package:flutter/material.dart';
import 'package:flutter_app/levels/level_patterns/tile_widget.dart';

class Stage2Widget extends StatefulWidget {
  final Function() nextLevel;
  const Stage2Widget({
    super.key,
    required this.nextLevel,
  });

  @override
  State<Stage2Widget> createState() => _Stage2WidgetState();
}

class _Stage2WidgetState extends State<Stage2Widget> {
  final _formKey = GlobalKey<FormState>();
  String? _selection = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Problem
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TileWidget(
              shape: 2,
              size: 2,
              bar: true,
              barOrientation: 2,
            ),
            TileWidget(
              shape: 1,
              size: 0,
              bar: true,
              barOrientation: 1,
            ),
            TileWidget(
              shape: 0,
              size: 0,
              bar: true,
              barOrientation: 0,
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TileWidget(
              shape: 1,
              size: 1,
              bar: true,
              barOrientation: 0,
            ),
            TileWidget(
              shape: 0,
              size: 2,
              bar: true,
              barOrientation: 2,
            ),
            TileWidget(
              shape: 2,
              size: 0,
              bar: true,
              barOrientation: 1,
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TileWidget(
              shape: 1,
              size: 2,
              bar: true,
              barOrientation: 1,
            ),
            TileWidget(
              shape: 2,
              size: 1,
              bar: true,
              barOrientation: 0,
            ),
            TileWidget(
              shape: 3,
              size: 2,
              bar: false,
              barOrientation: 0,
            ),
          ]),

          // Divider
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 20),

          // Solutions
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(children: [
              TileWidget(
                shape: 2,
                size: 1,
                bar: true,
                barOrientation: 1,
              ),
              Radio(
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
              TileWidget(
                shape: 0,
                size: 1,
                bar: true,
                barOrientation: 2,
              ),
              Radio(
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
                shape: 0,
                size: 1,
                bar: true,
                barOrientation: 1,
              ),
              Radio(
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
          ElevatedButton(
            onPressed: () {
              if (_selection == "b") {
                widget.nextLevel();
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}



// ignore_for_file: prefer_const_constructors
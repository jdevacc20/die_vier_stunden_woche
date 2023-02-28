import 'package:flutter/material.dart';
import 'package:flutter_app/levels/level_patterns/tile_widget.dart';

class Stage1Widget extends StatefulWidget {
  final Function() nextLevel;
  const Stage1Widget({
    super.key,
    required this.nextLevel,
  });

  @override
  State<Stage1Widget> createState() => _Stage1WidgetState();
}

class _Stage1WidgetState extends State<Stage1Widget> {
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
              shape: 0,
              size: 0,
              bar: false,
            ),
            TileWidget(
              shape: 1,
              size: 0,
              bar: false,
            ),
            TileWidget(
              shape: 2,
              size: 0,
              bar: false,
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TileWidget(
              shape: 1,
              size: 1,
              bar: false,
            ),
            TileWidget(
              shape: 2,
              size: 1,
              bar: false,
            ),
            TileWidget(
              shape: 0,
              size: 1,
              bar: false,
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TileWidget(
              shape: 2,
              size: 2,
              bar: false,
            ),
            TileWidget(
              shape: 0,
              size: 2,
              bar: false,
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
              TileWidget(shape: 2, size: 2, bar: false),
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
              TileWidget(shape: 0, size: 1, bar: false),
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
              TileWidget(shape: 1, size: 2, bar: false),
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
              if (_selection == "c") {
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
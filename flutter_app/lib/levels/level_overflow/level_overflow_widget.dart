import 'package:flutter/material.dart';
import 'package:flutter_app/levels/level_wrapper.dart';
import 'package:flutter_app/levels/level_overflow/level_overflow_input_widget.dart';

class LevelOverflowWidget extends StatefulWidget {
  const LevelOverflowWidget({super.key});

  @override
  State<LevelOverflowWidget> createState() => _LevelOverflowWidgetState();
}

class _LevelOverflowWidgetState extends State<LevelOverflowWidget> {
  bool done = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LevelWrapper(
      title: "Your Credentials",
      description: "Please fill out the form",
      done: done,
      hint: "denk nach pisser",
      levelChild: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              LevelOverflowInputWidget(
                labelLeft: "name:",
                labelRight: "gender:",
              ),
              LevelOverflowInputWidget(
                labelLeft: "age:",
                labelRight: "birth month:",
              ),
              LevelOverflowInputWidget(
                labelLeft: "username:",
                labelRight: "favourite color:",
                overflowInput: true,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        done = true;
                      });
                    }
                  },
                  child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_app/models/level_model.dart';
import 'package:flutter_app/levels/level_overflow/level_overflow_input_widget.dart';
import 'package:provider/provider.dart';

class LevelOverflowWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LevelOverflowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LevelModel>(
          builder: (context, value, child) => Center(
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
                                value.increaseLevel();
                              }
                            },
                            child: const Text("Submit"))
                      ],
                    )),
              )),
    );
  }
}

// ignore_for_file: prefer_const_constructors
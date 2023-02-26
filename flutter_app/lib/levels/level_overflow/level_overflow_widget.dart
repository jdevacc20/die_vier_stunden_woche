import 'package:flutter/material.dart';
import 'package:flutter_app/models/level_model.dart';
import 'package:flutter_app/levels/level_overflow/level_overflow_input_widget.dart';
import 'package:provider/provider.dart';

class LevelOverflowWidget extends StatelessWidget {
  const LevelOverflowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LevelModel>(
        builder: (context, value, child) => Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
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
          ],
        )),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors
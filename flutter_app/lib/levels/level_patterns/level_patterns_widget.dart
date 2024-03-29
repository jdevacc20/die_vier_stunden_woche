import 'package:flutter/material.dart';
import 'package:flutter_app/levels/level_patterns/stage_1_widget.dart';
import 'package:flutter_app/levels/level_patterns/stage_2_widget.dart';
import 'package:flutter_app/levels/level_patterns/stage_3_widget.dart';
import 'package:flutter_app/levels/level_patterns/tile_widget.dart';
import 'package:flutter_app/levels/level_wrapper.dart';
import 'package:flutter_app/models/level_model.dart';
import 'package:provider/provider.dart';

class LevelPatternsWidget extends StatefulWidget {
  const LevelPatternsWidget({super.key});

  @override
  State<LevelPatternsWidget> createState() => _LevelPatternsWidgetState();
}

class _LevelPatternsWidgetState extends State<LevelPatternsWidget> {
  int level = 0;
  bool _done = false;

  @override
  Widget build(BuildContext context) {
    return LevelWrapper(
      title: "Pattern Recognition",
      description: "Finde the matching tile",
      done: _done,
      levelChild: Consumer<LevelModel>(
        builder: (context, value, child) => SingleChildScrollView(
          child: Center(
            child: [
              Stage1Widget(nextLevel: () {
                setState(() {
                  level += 1;
                });
              }),
              Stage2Widget(nextLevel: () {
                setState(() {
                  level += 1;
                });
              }),
              Stage3Widget(nextLevel: () {
                setState(() {
                  _done = true;
                });
              }),
            ][level],
          ),
        ),
      ),
    );
  }
}

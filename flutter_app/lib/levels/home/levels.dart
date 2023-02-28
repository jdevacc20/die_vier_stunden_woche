import 'package:flutter/material.dart';
import 'package:flutter_app/levels/are_you_dumb_button_level/are_you_dumb_button_level.dart';
import 'package:flutter_app/levels/level_countdown/level_countdown_widget.dart';
import 'package:flutter_app/levels/level_lights_out/level_lights_out_widget.dart';
import 'package:flutter_app/levels/level_overflow/level_overflow_widget.dart';
import 'package:flutter_app/levels/level_memory/level_memory_widget.dart';
import 'package:flutter_app/levels/level_patterns/level_patterns_widget.dart';
import 'package:flutter_app/levels/level_sequence/level_sequence_widget.dart';
import 'package:flutter_app/levels/level_shapes/level_shapes_widget.dart';
import 'package:flutter_app/levels/rating_level/rating_level.dart';
import 'package:flutter_app/levels/tic_tac_toe_level/tic_tac_toe_level.dart';

///Insert your Levels in here!!
List<Widget> levels = [
  //const AreYouDumbButtonLevel(),
  //const LevelOverflowWidget(),
  //const LevelMemoryWidget(),
  //const TicTacToeLevel(),
  const LevelCountdownWidget(),
  const RatingLevel(),
  const LevelShapesWidget(),
  const LevelLightsOutWidget(),
  const LevelPatternsWidget(),
  const LevelSequenceWidget(),
];

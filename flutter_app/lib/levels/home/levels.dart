import 'package:flutter/material.dart';
import 'package:flutter_app/levels/are_you_dumb_button_level/are_you_dumb_button_level.dart';
import 'package:flutter_app/levels/level_memory/level_memory_widget.dart';
import 'package:flutter_app/levels/level_shapes/level_shapes_widget.dart';
import 'package:flutter_app/levels/test_level/test_level.dart';

///Insert your Levels in here!!
List<Widget> levels = [
  const AreYouDumbButtonLevel(),
  const LevelMemoryWidget(),
  const LevelShapesWidget(),
  const TestLevel(),
];

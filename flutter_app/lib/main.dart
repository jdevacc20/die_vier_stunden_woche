import 'package:flutter/material.dart';
import 'package:flutter_app/models/level_model.dart';
import 'package:flutter_app/models/settings_model.dart';
import 'package:provider/provider.dart';

import 'levels/home/theme_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => LevelModel()),
        ),
        ChangeNotifierProvider(
          create: ((context) => SettingsModel()),
        ),
      ],
      child: const ThemeApp(),
    ),
  );
}

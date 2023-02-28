import 'package:flutter/material.dart';

import 'home_page.dart';

///widget with the theme,
///access colors with Theme.of(context).#color#
class ThemeApp extends StatelessWidget {
  const ThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Escape this shit',

      ///Update this theme for changes in light mode
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green,
      ),

      ///Update this theme for changes in dark mode
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple,
      ),
      home: const HomePage(),
    );
  }
}

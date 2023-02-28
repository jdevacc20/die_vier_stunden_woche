import 'package:flutter/material.dart';
import 'package:flutter_app/models/settings_model.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

///widget with the theme,
///access colors with Theme.of(context).#color#
class ThemeApp extends StatefulWidget {
  const ThemeApp({super.key});

  @override
  State<ThemeApp> createState() => _ThemeAppState();
}

class _ThemeAppState extends State<ThemeApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      builder: ((context, settingsModel, child) => MaterialApp(
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
            themeMode: settingsModel.getThemeMode(null),
          )),
    );
  }
}

extension DarkMode on BuildContext {
  /// is dark mode currently enabled?
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

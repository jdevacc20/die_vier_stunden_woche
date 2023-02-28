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
              primaryColor: const Color(0xFFee6002),
              shadowColor: const Color(0xFFfa8100),
              errorColor: const Color(0xFFD50000),
              disabledColor: const Color(0xFFBDBDBD),
              backgroundColor: const Color(0xFFE0E0E0),
            ),

            ///Update this theme for changes in dark mode
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: const Color(0xFF311B92),
              shadowColor: const Color(0xFF512DA8),
              errorColor: const Color(0xFFD50000),
              disabledColor: const Color(0xFFBDBDBD),
              backgroundColor: const Color(0xFF424242),
            ),
            themeMode: settingsModel.getThemeMode(null),
            home: const HomePage(),
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

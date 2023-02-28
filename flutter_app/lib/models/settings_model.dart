import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier {
  bool? _darkMode;

  ThemeMode getThemeMode(BuildContext? context) {
    if (context == null) {
      return _darkMode == null
          ? ThemeMode.system
          : (_darkMode ?? false)
              ? ThemeMode.dark
              : ThemeMode.light;
    }

    if (_darkMode == null) {
      return context.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    }
    return (_darkMode ?? false) ? ThemeMode.dark : ThemeMode.light;
  }

  void setDarkMode(bool on) {
    _darkMode = on;
    notifyListeners();
  }
}

extension DarkMode on BuildContext {
  /// is dark mode currently enabled?
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

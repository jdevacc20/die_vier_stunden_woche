import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Change Notifier to save the players current level and make it accessible to level widgets
class LevelModel extends ChangeNotifier {
  final prefsLevel = "cur_level";

  ///get the players current level
  Future<int> getCurrentLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(prefsLevel) ?? 0;
  }

  ///increase the players current level
  Future<void> increaseLevel() async {
    print("Increase Level!");
    int level = await getCurrentLevel();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(prefsLevel, level + 1);
    notifyListeners();
  }

  ///reset the players current level to 0
  Future<void> resetLevel() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(prefsLevel, 0);
    notifyListeners();
  }
}

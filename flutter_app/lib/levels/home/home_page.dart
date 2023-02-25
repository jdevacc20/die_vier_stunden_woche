import 'package:flutter/material.dart';
import 'package:flutter_app/levels/finish/finish_widget.dart';
import 'package:flutter_app/levels/home/levels.dart';
import 'package:flutter_app/models/level_model.dart';
import 'package:provider/provider.dart';

///Returns the widget of the current level
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LevelModel>(
      builder: ((context, value, child) {
        return FutureBuilder<int>(
          future: value.getCurrentLevel(),
          builder: ((context, snapshot) {
            print("New Widget! ${snapshot.data}");
            int level = snapshot.data ?? 0;
            if (level < levels.length) {
              return levels[snapshot.data ?? 0];
            }
            return const FinishWidget();
          }),
        );
      }),
    );
  }
}

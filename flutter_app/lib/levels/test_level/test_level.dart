import 'package:flutter/material.dart';
import 'package:flutter_app/models/level_model.dart';
import 'package:provider/provider.dart';

class TestLevel extends StatelessWidget {
  const TestLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LevelModel>(
        builder: (context, value, child) => Center(
          child: MaterialButton(
            onPressed: () {
              value.increaseLevel();
            },
            child: const Text("Fertig!"),
          ),
        ),
      ),
    );
  }
}

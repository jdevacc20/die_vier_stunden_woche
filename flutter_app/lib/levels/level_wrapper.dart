import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/level_model.dart';

class LevelWrapper extends StatelessWidget {
  final String title;
  final String description;
  final bool done;
  final Widget levelChild;

  const LevelWrapper(
      {super.key,
      required this.title,
      required this.description,
      required this.done,
      required this.levelChild});

  @override
  Widget build(BuildContext context) {
    return Consumer<LevelModel>(builder: (context, value, child) {
      return SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const LinearProgressIndicator(
                      backgroundColor: Colors.amber,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                      //TODO: levelModel.getProgress()
                      value: 0.7,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: Text(
                    description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Expanded(
                child: levelChild,
              ),
              if (done)
                GestureDetector(
                  onTap: () {
                    value.increaseLevel();
                  },
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: const Center(
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

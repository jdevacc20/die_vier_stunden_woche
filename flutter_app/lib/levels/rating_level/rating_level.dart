import 'package:flutter/material.dart';
import 'package:flutter_app/levels/level_wrapper.dart';

class RatingLevel extends StatefulWidget {
  const RatingLevel({super.key});

  @override
  State<StatefulWidget> createState() => _RatingLevelState();
}

class _RatingLevelState extends State<RatingLevel> {
  bool done = false;
  List<bool> starStates = List.filled(5, false);
  List<int> starOrder = [0, 1, 2, 3, 4];

  @override
  void initState() {
    super.initState();
    starOrder.shuffle();
  }

  void onStarTap(int index) {
    if (starStates[index] == true) {
      return;
    }
    int i = starStates.where((item) => item == true).length;
    if (index == starOrder[i]) {
      setState(() {
        starStates[index] = true;
      });
    } else {
      setState(() {
        starStates = List.filled(5, false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LevelWrapper(
      title: "Please rate our App!",
      description:
          "We would pretty much appreciate it if you give us honest feedback about our App.\n Thank you!",
      done: done,
      hint: "denk nach pisser",
      levelChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Card(
              elevation: 8.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                      child: Text(
                        "With how many stars you would rate this app?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: starStates
                        .asMap()
                        .entries
                        .map((entry) => Expanded(
                              child: AspectRatio(
                                aspectRatio: 1.0,
                                child: FittedBox(
                                  child: GestureDetector(
                                    onTap: () {
                                      onStarTap(entry.key);
                                    },
                                    child: Icon(
                                        entry.value
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.yellow),
                                  ),
                                ),
                              ),
                            ))
                        .cast<Widget>()
                        .toList(),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: MaterialButton(
                      height: MediaQuery.of(context).size.height * 0.06,
                      minWidth: MediaQuery.of(context).size.width * 0.5,
                      color: Theme.of(context).primaryColor,
                      disabledColor: Theme.of(context).disabledColor,
                      onPressed:
                          starStates.where((item) => item == true).length == 5
                              ? () {
                                  setState(() {
                                    done = true;
                                  });
                                }
                              : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Spacer(),
                          FittedBox(
                            child: Text(
                              "Send",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.send),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

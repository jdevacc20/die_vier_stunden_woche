import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/level_model.dart';

class TicTacToeLevel extends StatefulWidget {
  const TicTacToeLevel({super.key});

  @override
  State<TicTacToeLevel> createState() => _TicTacToeLevelState();
}

enum FieldState { empty, player, computer }

enum GameState { starting, running, lost, won }

class TicTacToe {
  List<FieldState> fieldStates;

  TicTacToe({required this.fieldStates});

  bool isFull() {
    if (!fieldStates.contains(FieldState.empty)) {
      return true;
    } else {
      return false;
    }
  }

  FieldState checkWin() {
    List<List<int>> winningPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    for (List<int> winningPosition in winningPositions) {
      if (fieldStates[winningPosition[0]] == fieldStates[winningPosition[1]] &&
          fieldStates[winningPosition[1]] == fieldStates[winningPosition[2]]) {
        if (fieldStates[winningPosition[0]] != FieldState.empty) {
          return (fieldStates[winningPosition[0]]);
        }
      }
    }
    return FieldState.empty;
  }

  void reset() {
    fieldStates = List.filled(9, FieldState.empty);
  }

  factory TicTacToe.copy(TicTacToe other) {
    return TicTacToe(fieldStates: List.from(other.fieldStates));
  }
}

class _TicTacToeLevelState extends State<TicTacToeLevel> {
  bool computerTurn = false;
  GameState gameState = GameState.starting;
  TicTacToe game = TicTacToe(fieldStates: List.filled(9, FieldState.empty));

  @override
  void initState() {
    reset();
    super.initState();
  }

  void reset() {
    game.reset();
    // ignore: unused_local_variable
    final startingGameTimer = Timer(
      const Duration(milliseconds: 300),
      () => {startGame()},
    );
  }

  void startGame() {
    setState(() {
      game.fieldStates[4] = FieldState.computer;
      gameState = GameState.running;
    });
  }

  void fieldClicked(int index) {
    if (game.fieldStates[index] == FieldState.empty &&
        gameState == GameState.running) {
      setState(() {
        game.fieldStates[index] = FieldState.player;
      });
      check();

      if (!computerTurn) {
        setState(() {
          computerTurn = true;
        });
        // ignore: unused_local_variable
        final computerTurnTimer = Timer(
          const Duration(milliseconds: 300),
          () => {computer()},
        );
      }
    }
  }

  void computer() {
    if (gameState != GameState.running) {
      return;
    }

    for (var i = 0; i < 9; i++) {
      if (game.fieldStates[i] == FieldState.empty) {
        TicTacToe gameCopy = TicTacToe.copy(game);
        gameCopy.fieldStates[i] = FieldState.computer;
        if (gameCopy.checkWin() == FieldState.computer) {
          setState(() {
            game.fieldStates[i] = FieldState.computer;
            computerTurn = false;
          });
          check();
          return;
        }
      }
    }

    for (var i = 0; i < 9; i++) {
      if (game.fieldStates[i] == FieldState.empty) {
        TicTacToe gameCopy = TicTacToe.copy(game);
        gameCopy.fieldStates[i] = FieldState.player;
        if (gameCopy.checkWin() == FieldState.player) {
          setState(() {
            game.fieldStates[i] = FieldState.computer;
            computerTurn = false;
          });
          check();
          return;
        }
      }
    }

    for (var i = 0; i < 9; i++) {
      if (game.fieldStates[i] == FieldState.empty) {
        setState(() {
          game.fieldStates[i] = FieldState.computer;
          computerTurn = false;
        });
        check();
        return;
      }
    }
  }

  void check() {
    if (game.checkWin() == FieldState.player) {
      setState(() {
        gameState = GameState.won;
      });
      print("Win");
      return;
    }
    if (game.checkWin() == FieldState.computer) {
      setState(() {
        gameState = GameState.lost;
      });
      return;
    }
    if (game.isFull()) {
      setState(() {
        gameState = GameState.lost;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<LevelModel>(
          builder: (context, value, child) => SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      const double bordersize = 5;
                      const borderSide =
                          BorderSide(color: Colors.black, width: bordersize);
                      List<BoxBorder> borders = [
                        const Border(right: borderSide, bottom: borderSide),
                        const Border(
                            right: borderSide,
                            bottom: borderSide,
                            left: borderSide),
                        const Border(left: borderSide, bottom: borderSide),
                        const Border(
                            top: borderSide,
                            bottom: borderSide,
                            right: borderSide),
                        const Border(
                            right: borderSide,
                            bottom: borderSide,
                            top: borderSide,
                            left: borderSide),
                        const Border(
                            left: borderSide,
                            bottom: borderSide,
                            top: borderSide),
                        const Border(right: borderSide, top: borderSide),
                        const Border(
                            right: borderSide,
                            left: borderSide,
                            top: borderSide),
                        const Border(left: borderSide, top: borderSide),
                      ];
                      return GestureDetector(
                        onTapDown: (details) {
                          fieldClicked(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: borders[index],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.02),
                            child: FittedBox(
                              child: game.fieldStates[index] != FieldState.empty
                                  ? Icon(
                                      game.fieldStates[index] ==
                                              FieldState.player
                                          ? Icons.radio_button_unchecked
                                          : Icons.close,
                                      color: Colors.black,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: gameState == GameState.lost
                        ? [
                            const Text(
                              "You failed!",
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                reset();
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(0, 0),
                                        blurStyle: BlurStyle.normal,
                                        blurRadius: 10,
                                      )
                                    ]),
                                child:
                                    const FittedBox(child: Icon(Icons.refresh)),
                              ),
                            ),
                          ]
                        : [],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

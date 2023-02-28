import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_app/levels/level_wrapper.dart';
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
  bool _done = false;
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
        _done = true;
      });
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
    double size = min(MediaQuery.of(context).size.height,
            MediaQuery.of(context).size.height) *
        0.6;
    return LevelWrapper(
      title: "Tic Tac Toe",
      description: "Win the game!",
      done: _done,
      levelChild: Column(
        children: [
          SizedBox(
            width: size,
            height: size,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                const double bordersize = 5;
                BorderSide borderSide = BorderSide(
                    color: Theme.of(context).dividerColor, width: bordersize);
                List<BoxBorder> borders = [
                  Border(right: borderSide, bottom: borderSide),
                  Border(
                      right: borderSide, bottom: borderSide, left: borderSide),
                  Border(left: borderSide, bottom: borderSide),
                  Border(
                      top: borderSide, bottom: borderSide, right: borderSide),
                  Border(
                      right: borderSide,
                      bottom: borderSide,
                      top: borderSide,
                      left: borderSide),
                  Border(left: borderSide, bottom: borderSide, top: borderSide),
                  Border(right: borderSide, top: borderSide),
                  Border(right: borderSide, left: borderSide, top: borderSide),
                  Border(left: borderSide, top: borderSide),
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
                                game.fieldStates[index] == FieldState.player
                                    ? Icons.radio_button_unchecked
                                    : Icons.close,
                                color: Theme.of(context).dividerColor,
                              )
                            : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          AnimatedOpacity(
            opacity: gameState == GameState.lost ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    "You failed!",
                    style: TextStyle(fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Ink(
                      decoration: ShapeDecoration(
                        shape: const CircleBorder(),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: IconButton(
                        onPressed: gameState == GameState.lost
                            ? (() {
                                reset();
                              })
                            : null,
                        icon: const Icon(Icons.refresh),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

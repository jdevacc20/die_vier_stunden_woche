import 'dart:async';

import 'package:flutter/material.dart';

class LevelCountdownWidget extends StatefulWidget {
  const LevelCountdownWidget({super.key});

  @override
  State<StatefulWidget> createState() => _LevelCountdownWidget();
}

class _LevelCountdownWidget extends State<LevelCountdownWidget> {
  bool _restart = false;
  bool _leftToRight = true;
  bool _isPressed = false;
  double _timeTillRestart = 0;
  bool _gameFinished = false;

  bool _showPrankText = false;

  Timer timer = Timer(const Duration(days: 0), (() {}));

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_gameFinished) {
        timer.cancel();
        return;
      }
      if (!_restart) {
        return;
      }
      if (_isPressed) {
        return;
      }
      if (_timeTillRestart > 0) {
        _timeTillRestart -= 0.1;
      } else {
        setState(() {
          _restart = false;
          _leftToRight = !_leftToRight;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text(
              "Erreiche das Ziel!",
              style: TextStyle(fontSize: 30),
            ),
          ),
          AnimatedOpacity(
            opacity: _restart ? 1 : 0,
            duration: const Duration(seconds: 2),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Das hat nicht gereicht, Du musst",
                    style: TextStyle(fontSize: 30),
                  ),
                  GestureDetector(
                    onLongPress: () {
                      setState(() {
                        _showPrankText = true;
                      });
                      Timer(
                        const Duration(seconds: 2),
                        (() {
                          setState(() {
                            _showPrankText = false;
                          });
                        }),
                      );
                    },
                    child: const Text(
                      " durchhalten!",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _SliderWidget(
                duration: const Duration(seconds: 20),
                icon: const Icon(Icons.adb),
                onEnd: () {
                  setState(() {
                    _gameFinished = true;
                  });
                  print("Finished");
                },
                leftToRight: _leftToRight,
                tapDown: () {},
                tapUp: () {},
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _SliderWidget(
                duration: const Duration(seconds: 10),
                icon: const Icon(
                  Icons.tag_faces_outlined,
                ),
                leftToRight: _leftToRight,
                onEnd: () {
                  setState(() {
                    _restart = true;
                    _timeTillRestart = 2;
                  });
                },
                tapDown: () {
                  _isPressed = true;
                },
                tapUp: () {
                  _isPressed = false;
                },
              ),
            ),
          ),
          Center(
            child: AnimatedOpacity(
              opacity: _showPrankText ? 1 : 0,
              duration: const Duration(seconds: 2),
              child: const Text(
                "Dachtest du echt, dass es so leicht ist?",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliderWidget extends StatefulWidget {
  final Duration duration;
  final Icon icon;
  final bool leftToRight;
  final Function() onEnd;
  final Function() tapDown;
  final Function() tapUp;

  const _SliderWidget({
    required this.duration,
    required this.icon,
    required this.onEnd,
    required this.leftToRight,
    required this.tapDown,
    required this.tapUp,
  });

  @override
  State<StatefulWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<_SliderWidget> {
  bool _moving = false;

  @override
  void initState() {
    super.initState();
    Timer _ = Timer(const Duration(seconds: 1), () {
      setState(() {
        _moving = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Positioned(
        right: widget.leftToRight ? 0 : null,
        left: widget.leftToRight ? null : 0,
        bottom: 0,
        child: const Icon(Icons.flag),
      ),
      AnimatedAlign(
        alignment: widget.leftToRight
            ? (_moving ? Alignment.bottomRight : Alignment.bottomLeft)
            : (_moving ? Alignment.bottomLeft : Alignment.bottomRight),
        duration: widget.duration,
        onEnd: (() {
          widget.onEnd();
        }),
        child: GestureDetector(
          child: widget.icon,
          onTapDown: (details) {
            widget.tapDown();
          },
          onTapUp: (details) {
            widget.tapUp();
          },
          onTapCancel: () {
            widget.tapUp();
          },
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 2,
          color: Colors.black,
        ),
      ),
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/models/level_model.dart';
import 'package:provider/provider.dart';

class AreYouDumbButtonLevel extends StatefulWidget {
  const AreYouDumbButtonLevel({super.key});

  @override
  State<AreYouDumbButtonLevel> createState() => _AreYouDumbButtonLevelState();
}

class _AreYouDumbButtonLevelState extends State<AreYouDumbButtonLevel> {
  final double _size = 80;
  final double _additionalOffset = 20;
  double _paddingTop = 100.0;
  double _paddingLeft = 100.0;

  void onClick(TapDownDetails details, LevelModel value) {
    double xOffset = details.localPosition.dx - _size / 2;
    double xMove = xOffset > 0
        ? -(_size / 2 - xOffset) - _additionalOffset
        : (_size / 2 - xOffset.abs() + _additionalOffset);

    double yOffset = details.localPosition.dy - _size / 2;
    double yMove = yOffset > 0
        ? -(_size / 2 - yOffset) - _additionalOffset
        : (_size / 2 - yOffset.abs() + _additionalOffset);

    double newLeftPadding = _paddingLeft + xMove;
    if (newLeftPadding < 0) {
      newLeftPadding = 0;
    }
    if (newLeftPadding > MediaQuery.of(context).size.width - _size) {
      newLeftPadding = MediaQuery.of(context).size.width - _size;
    }

    double newTopPadding = _paddingTop + yMove;
    if (newTopPadding < 0) {
      newTopPadding = 0;
    }
    if (newTopPadding >
        (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom) -
            _size) {
      newTopPadding = (MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom) -
          _size;
    }

    bool xblocked = false;
    bool yblocked = false;

    if (newLeftPadding == _paddingLeft) {
      xblocked = true;
    }
    if (newTopPadding == _paddingTop) {
      yblocked = true;
    }

    if (xblocked & yblocked) {
      value.increaseLevel();
    } else {
      setState(() {
        _paddingLeft = newLeftPadding;
        _paddingTop = newTopPadding;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<LevelModel>(
          builder: (context, value, child) => Stack(
            children: [
              Positioned(
                top: _paddingTop,
                left: _paddingLeft,
                child: GestureDetector(
                  onTapDown: (details) {
                    onClick(details, value);
                  },
                  child: Container(
                    height: _size,
                    width: _size,
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                      boxShadow: const [BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 0),
                        blurStyle: BlurStyle.normal,
                        blurRadius: 10,
                      )]
                    ),
                    child: const Center(
                      child: Text(
                        "Start",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

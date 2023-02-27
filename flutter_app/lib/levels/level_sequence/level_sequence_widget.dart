import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

double fontSize = 30;

class LevelSequenceWidget extends StatefulWidget {
  const LevelSequenceWidget({super.key});

  @override
  State<StatefulWidget> createState() => _LevelSequenceWidget();
}

class _LevelSequenceWidget extends State<LevelSequenceWidget> {
  bool _level1Error = false;
  bool _level2Error = false;
  bool _level3Error = false;

  String _level1Value = "";
  String _level2Value = "";
  String _level3Value = "";
  bool _done = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Text(
                "Vervollständige die Zahlenfolge",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Draggable(
              data: 1,
              feedback: Material(
                child: Center(
                  child: Text(
                    "-",
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
              ),
              childWhenDragging: Text(
                "",
                style: TextStyle(fontSize: fontSize),
              ),
              child: Text(
                "-",
                style: TextStyle(fontSize: fontSize),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Finde den nächsten Buchstaben",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _Level1Widget(
              error: _level1Error,
              onChanged: (p0) {
                _level1Value = p0;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _Level2Widget(
              error: _level2Error,
              onChanged: ((p0) {
                _level2Value = p0;
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            _Level3Widget(
              error: _level3Error,
              onChanged: ((p0, done) {
                if (p0 != null) {
                  _level3Value = p0;
                }
                _done = done;
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: (() {
                setState(() {
                  if (_level1Value != "5") {
                    _level1Error = true;
                  } else {
                    _level1Error = false;
                  }
                  if (_level2Value != "8") {
                    _level2Error = true;
                  } else {
                    _level2Error = false;
                  }
                  if (_level3Value != "5" || !_done) {
                    _level3Error = true;
                  } else {
                    _level3Error = false;
                  }
                  if (!_level1Error && !_level2Error && !_level3Error) {
                    print("Fertig!!!");
                  }
                });
              }),
              color: Theme.of(context).primaryColor,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  final int number;

  const _NumberField({required this.number});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (1 / 8),
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
            child: Center(
          child: Text("$number"),
        )),
      ),
    );
  }
}

class _InputFeedback extends StatelessWidget {
  final bool error;

  const _InputFeedback({required this.error});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * (1 / 8),
      child: Opacity(
        opacity: error ? 1 : 0,
        child: const AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Icon(
                Icons.cancel_outlined,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NumberTextField extends StatelessWidget {
  final Function(String) onChanged;

  const _NumberTextField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (1 / 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Center(
          child: TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: "",
            ),
            maxLength: 1,
            textAlignVertical: TextAlignVertical.top,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: ((value) {
              onChanged(value);
            }),
          ),
        ),
      ),
    );
  }
}

class _Level1Widget extends StatelessWidget {
  final bool error;
  final Function(String) onChanged;

  const _Level1Widget({required this.error, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const _NumberField(number: 1),
          const _NumberField(number: 2),
          const _NumberField(number: 3),
          const _NumberField(number: 4),
          SizedBox(
            width: MediaQuery.of(context).size.width * (1 / 8),
          ),
          _NumberTextField(onChanged: onChanged),
          _InputFeedback(error: error),
        ],
      ),
    );
  }
}

class _Level2Widget extends StatelessWidget {
  final bool error;
  final Function(String) onChanged;

  const _Level2Widget({required this.error, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const _NumberField(number: 0),
          const _NumberField(number: 2),
          const _NumberField(number: 4),
          const _NumberField(number: 6),
          SizedBox(
            width: MediaQuery.of(context).size.width * (1 / 8),
          ),
          _NumberTextField(onChanged: onChanged),
          _InputFeedback(error: error),
        ],
      ),
    );
  }
}

class _Level3Widget extends StatefulWidget {
  final bool error;
  final Function(String?, bool) onChanged;

  const _Level3Widget({required this.error, required this.onChanged});

  @override
  State<StatefulWidget> createState() => _Level3WidgetState();
}

class _Level3WidgetState extends State<_Level3Widget> {
  bool done = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const _NumberField(number: -1),
          const _NumberField(number: -2),
          const _NumberField(number: -3),
          const _NumberField(number: -4),
          SizedBox(
            width: MediaQuery.of(context).size.width * (1 / 8),
            child: DragTarget(
              builder: (context, candidateData, rejectedData) {
                return done
                    ? Center(
                        child: Text(
                          "-",
                          style: TextStyle(fontSize: fontSize),
                        ),
                      )
                    : const AspectRatio(
                        aspectRatio: 1,
                      );
              },
              onAccept: (data) {
                setState(() {
                  done = true;
                });
                print("Jaa");
                widget.onChanged(null, true);
              },
            ),
          ),
          DragTarget(
            builder: (context, candidateData, rejectedData) => _NumberTextField(
              onChanged: (p0) {
                widget.onChanged(p0, done);
              },
            ),
            onAccept: (data) {
              setState(() {
                done = true;
              });
              print("Jaa");
              widget.onChanged(null, true);
            },
          ),
          _InputFeedback(error: widget.error),
        ],
      ),
    );
  }
}

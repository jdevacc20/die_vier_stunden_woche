import 'dart:async';

import 'package:flutter/material.dart';

class FeedbackDialog extends StatefulWidget {
  final bool success;

  const FeedbackDialog({
    super.key,
    required this.success,
  });

  @override
  State<StatefulWidget> createState() => _FeedbackDialog();
}

class _FeedbackDialog extends State<FeedbackDialog> {
  Timer _timer = Timer(const Duration(days: 0), () {});
  int _timeLeft = 1;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_timeLeft > 0) {
        _timeLeft -= 1;
        if (!_visible) {
          setState(() {
            _visible = true;
          });
        }
      } else {
        setState(() {
          _visible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: widget.success
            ? const Icon(
                Icons.check_circle_outline,
                size: 300,
                color: Colors.green,
              )
            : const Icon(
                Icons.close_outlined,
                size: 100,
                color: Colors.red,
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

///Widgets which takes place when player finished last level
class FinishWidget extends StatelessWidget {
  const FinishWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Du bist fertig!"),
      ),
    );
  }
}

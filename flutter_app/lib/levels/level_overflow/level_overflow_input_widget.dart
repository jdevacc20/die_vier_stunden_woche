import 'package:flutter/material.dart';

class LevelOverflowInputWidget extends StatefulWidget {
  final String labelLeft;
  final String labelRight;
  final bool overflowInput;

  const LevelOverflowInputWidget({
    super.key,
    required this.labelLeft,
    required this.labelRight,
    this.overflowInput = false,
  });

  @override
  // ignore: no_logic_in_create_state
  State<LevelOverflowInputWidget> createState() => _LevelOverflowInputState();
}

class _LevelOverflowInputState extends State<LevelOverflowInputWidget> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controllerLeft = TextEditingController();
  String sharedText = "";

  _LevelOverflowInputState();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(children: [
              Text(
                widget.labelLeft,
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: ''),
                onChanged: widget.overflowInput ? onChangedInput : null,
                controller: widget.overflowInput ? controllerLeft : null,
              ),
            ]),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(children: [
              Text(
                widget.labelRight,
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: ''),
                enabled: !widget.overflowInput,
                controller: widget.overflowInput ? controller : null,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  void onChangedInput(String value) {
    if (value == "") {
      sharedText = "";
      controller.text = "";
    }
    if (sharedText.length >= 10) {
      if (value.length > 10) {
        sharedText += value.substring(10);
      } else {
        sharedText =
            sharedText.substring(0, sharedText.length - (10 - value.length));
      }
    } else {
      sharedText = value;
    }

    controllerLeft.value = controllerLeft.value.copyWith(
        text: sharedText.substring(0, 10),
        selection: TextSelection(baseOffset: 10, extentOffset: 10));
    controller.text = sharedText.substring(10);

    // fence

    /*
    if (value.length <= 10) {
      sharedText = value;
      controller.text = "";
    } else {
      sharedText += value.substring(10);
      controllerLeft.value = controllerLeft.value.copyWith(
          text: sharedText.substring(0, 10),
          selection: TextSelection(baseOffset: 10, extentOffset: 10));
      controller.text = sharedText.substring(10);
    }*/

    /*
    if (value.length > 10) {
      //controllerLeft.text = value.substring(0, 10);
      String text = controllerLeft.text;
      controllerLeft.value = controllerLeft.value.copyWith(
          text: text.substring(0, 10),
          selection: TextSelection(baseOffset: 10, extentOffset: 10));
      controller.text = value.substring(10);
      print(value.substring(10));
    } else {
      controller.text = "";
    }
    */
  }
}


// ignore_for_file: prefer_const_constructors
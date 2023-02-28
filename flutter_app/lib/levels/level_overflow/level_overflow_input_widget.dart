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
              TextFormField(
                validator: validate,
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
              TextFormField(
                validator: validate,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '',
                    errorStyle: TextStyle(
                      color: Colors.red,
                    )),
                enabled: !widget.overflowInput,
                controller: widget.overflowInput ? controller : null,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  String? Function(String?) validate = (String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter some Text";
    }
    return null;
  };

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

    if (sharedText.length > 10) {
      controllerLeft.value = controllerLeft.value.copyWith(
          text: sharedText.substring(0, 10),
          selection: TextSelection(baseOffset: 10, extentOffset: 10));
      controller.text = sharedText.substring(10);
    } else {
      controllerLeft.value = controllerLeft.value.copyWith(
          text: sharedText.substring(0, sharedText.length),
          selection: TextSelection(
              baseOffset: sharedText.length, extentOffset: sharedText.length));
      controller.text = "";
    }
  }
}


// ignore_for_file: prefer_const_constructors
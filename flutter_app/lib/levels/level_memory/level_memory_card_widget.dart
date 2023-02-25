import 'package:flutter/material.dart';

class LevelMemoryCardWidget extends StatelessWidget {
  final Icon icon;
  final int iconType;
  final bool open;
  final Function(int) onTap;
  final int index;

  const LevelMemoryCardWidget({
    super.key,
    required this.icon,
    required this.onTap,
    required this.index,
    this.open = false,
    required this.iconType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: InkWell(
          child: open
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: icon,
                    ),
                  ),
                )
              : const Center(
                  child: Text("Escape"),
                ),
          onTap: () {
            onTap(index);
          },
        ),
      ),
    );
  }
}

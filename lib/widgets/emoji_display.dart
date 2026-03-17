import 'package:flutter/material.dart';

class EmojiDisplay extends StatelessWidget {
  final String emoji;
  final Color color;
  final double size;

  const EmojiDisplay(
      {required this.emoji, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(size * 0.25),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Center(
        child: Text(emoji, style: TextStyle(fontSize: size * 0.45)),
      ),
    );
  }
}


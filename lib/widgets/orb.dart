import 'package:flutter/material.dart';

class Orb extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;
  const Orb({required this.size, required this.color, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [
          color.withOpacity(opacity),
          color.withOpacity(0),
        ]),
      ),
    );
  }
}

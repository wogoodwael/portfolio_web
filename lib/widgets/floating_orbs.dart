import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/widgets/orb.dart';

class FloatingOrbs extends StatelessWidget {
  final Animation<double> floatAnim;
  const FloatingOrbs({required this.floatAnim});

  @override
  Widget build(BuildContext context) {
    // Give the Stack bounded height and width using SizedBox.expand
    return AnimatedBuilder(
      animation: floatAnim,
      builder: (_, __) => SizedBox.expand(
        child: Stack(
          children: [
            Positioned(
              top: 60 + floatAnim.value * 0.8,
              right: 80,
              child: const Orb(size: 280, color: AppTheme.primary, opacity: 0.06),
            ),
            Positioned(
              bottom: 40 - floatAnim.value * 0.6,
              left: 40,
              child: const Orb(size: 220, color: AppTheme.accent, opacity: 0.07),
            ),
            Positioned(
              top: 200 + floatAnim.value * 0.5,
              left: 200,
              child: const Orb(size: 120, color: AppTheme.success, opacity: 0.04),
            ),
          ],
        ),
      ),
    );
  }
}

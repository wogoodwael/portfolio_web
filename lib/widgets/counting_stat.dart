import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';

class CountingStat extends StatelessWidget {
  final int endValue;
  final String suffix;
  final String label;
  final Color color;
  final AnimationController controller;

  const CountingStat({
    required this.endValue,
    required this.suffix,
    required this.label,
    required this.color,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final anim = IntTween(begin: 0, end: endValue).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: anim,
      builder: (_, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (b) => LinearGradient(
                colors: [color, color.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
              child: Text(
                '${anim.value}$suffix',
                style: AppTheme.displayMedium.copyWith(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Text(label,
                style: AppTheme.bodyMedium.copyWith(
                  fontSize: 13,
                  color: AppTheme.textSecondary,
                )),
          ],
        );
      },
    );
  }
}

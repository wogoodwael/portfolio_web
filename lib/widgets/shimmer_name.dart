import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/portfolio_data.dart';

class ShimmerName extends StatelessWidget {
  final Animation<double> shimmerAnim;
  final double fontSize;

  const ShimmerName({required this.shimmerAnim, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shimmerAnim,
      builder: (_, __) {
        final t = shimmerAnim.value;
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [
              (t - 0.4).clamp(0.0, 1.0),
              t.clamp(0.0, 1.0),
              (t + 0.4).clamp(0.0, 1.0),
            ],
            colors: const [
              AppTheme.primary,
              Colors.white,
              AppTheme.accent,
            ],
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: Text(
            PortfolioData.name,
            style: AppTheme.displayLarge.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.5,
            ),
          ),
        );
      },
    );
  }
}

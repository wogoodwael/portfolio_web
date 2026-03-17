
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/portfolio_data.dart';

class TypewriterTitle extends StatelessWidget {
  final Animation<int> typeAnim;
  final Animation<double> cursorAnim;
  final bool isMobile;

  const TypewriterTitle({
    required this.typeAnim,
    required this.cursorAnim,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([typeAnim, cursorAnim]),
      builder: (_, __) {
        final displayed = PortfolioData.title.substring(0, typeAnim.value);
        final showCursor = typeAnim.value < PortfolioData.title.length ||
            cursorAnim.value > 0.5;

        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Code bracket
            Text(
              '< ',
              style: AppTheme.displayMedium.copyWith(
                color: AppTheme.accent.withOpacity(0.7),
                fontSize: isMobile ? 20 : 28,
                fontFamily: 'JetBrainsMono',
              ),
            ),
            // Typed text
            Text(
              displayed,
              style: AppTheme.displayMedium.copyWith(
                fontSize: isMobile ? 20 : 28,
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            // Blinking cursor
            if (showCursor)
              AnimatedOpacity(
                opacity: cursorAnim.value,
                duration: Duration.zero,
                child: Container(
                  width: 2.5,
                  height: isMobile ? 22 : 30,
                  margin: const EdgeInsets.only(left: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            // Closing bracket
            if (typeAnim.value == PortfolioData.title.length)
              Text(
                ' />',
                style: AppTheme.displayMedium.copyWith(
                  color: AppTheme.accent.withOpacity(0.7),
                  fontSize: isMobile ? 20 : 28,
                  fontFamily: 'JetBrainsMono',
                ),
              ),
          ],
        );
      },
    );
  }
}


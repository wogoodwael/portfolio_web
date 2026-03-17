import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/common_widgets.dart';
import 'package:flutter_portfolio/portfolio_data.dart';

class LanguagesBlock extends StatelessWidget {
  static const List<Color> _colors = [
    AppTheme.primary,
    AppTheme.success,
    AppTheme.warning,
    Color(0xFFE040FB),
  ];

  static const List<double> _levels = [1.0, 0.65, 0.35, 0.35];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FadeSlideIn(child: SectionLabel('Languages')),
        const SizedBox(height: 16),
        const FadeSlideIn(
          delay: Duration(milliseconds: 80),
          child: Text('I Speak', style: AppTheme.headlineLarge),
        ),
        const SizedBox(height: 24),
        ...PortfolioData.languages.asMap().entries.map(
              (e) => FadeSlideIn(
                delay: Duration(milliseconds: 100 + e.key * 80),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _LanguageBar(
                    name: e.value.name,
                    level: e.value.level,
                    color: _colors[e.key % _colors.length],
                    fill: _levels[e.key % _levels.length],
                  ),
                ),
              ),
            ),
      ],
    );
  }
}

class _LanguageBar extends StatelessWidget {
  final String name;
  final String level;
  final Color color;
  final double fill;

  const _LanguageBar({
    required this.name,
    required this.level,
    required this.color,
    required this.fill,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: AppTheme.bodyMedium.copyWith(color: AppTheme.textPrimary)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Text(
                level,
                style: TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.cardBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            FractionallySizedBox(
              widthFactor: fill,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(color: color.withOpacity(0.4), blurRadius: 6)
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

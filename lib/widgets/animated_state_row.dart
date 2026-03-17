import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/widgets/counting_stat.dart';

class AnimatedStatsRow extends StatelessWidget {
  final AnimationController counterCtrl;
  const AnimatedStatsRow({required this.counterCtrl});

  static const _stats = [
    (end: 5, suffix: '+', label: 'Apps Delivered', color: AppTheme.primary),
    (end: 2, suffix: '+', label: 'Years Experience', color: AppTheme.accent),
    (end: 10, suffix: '+', label: 'APIs Integrated', color: AppTheme.success),
    (end: 30, suffix: '+', label: 'Students Trained', color: Color(0xFFFFB703)),
  ];

  @override
  Widget build(BuildContext context) {
    // Divider line above stats
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          width: 280,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              AppTheme.primary.withOpacity(0.6),
              AppTheme.accent.withOpacity(0.0),
            ]),
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 36,
          runSpacing: 20,
          children: _stats.map((s) {
            return CountingStat(
              endValue: s.end,
              suffix: s.suffix,
              label: s.label,
              color: s.color,
              controller: counterCtrl,
            );
          }).toList(),
        ),
      ],
    );
  }
}

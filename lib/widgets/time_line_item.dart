import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/portfolio_data.dart';

class TimelineItem extends StatelessWidget {
  final Experience experience;
  final bool isLast;

  const TimelineItem({required this.experience, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 20,
            child: Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppTheme.primaryGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.4),
                        blurRadius: 8,
                      )
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      color: AppTheme.cardBorder,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(experience.role, style: AppTheme.headlineMedium),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        experience.company,
                        style: AppTheme.bodyMedium
                            .copyWith(color: AppTheme.primary),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: AppTheme.textMuted,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        experience.period,
                        style: AppTheme.labelSmall.copyWith(
                            color: AppTheme.textMuted,
                            fontFamily: 'JetBrainsMono'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(experience.description, style: AppTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

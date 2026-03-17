import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/common_widgets.dart';
import 'package:flutter_portfolio/portfolio_data.dart';

class EducationBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FadeSlideIn(child: SectionLabel('Education')),
        const SizedBox(height: 16),
        const FadeSlideIn(
          delay: Duration(milliseconds: 80),
          child: Text('Background', style: AppTheme.headlineLarge),
        ),
        const SizedBox(height: 24),
        FadeSlideIn(
          delay: const Duration(milliseconds: 150),
          child: GlowCard(
            glowColor: AppTheme.accent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    '🎓  DEGREE',
                    style: TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(PortfolioData.degree,
                    style: AppTheme.headlineMedium),
                const SizedBox(height: 6),
                Text(PortfolioData.university,
                    style: AppTheme.bodyMedium
                        .copyWith(color: AppTheme.primary)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 13, color: AppTheme.textMuted),
                    const SizedBox(width: 6),
                    Text(
                      PortfolioData.eduPeriod,
                      style: AppTheme.bodyMedium.copyWith(
                          fontFamily: 'JetBrainsMono', fontSize: 12),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.location_on_outlined,
                        size: 13, color: AppTheme.textMuted),
                    const SizedBox(width: 6),
                    Text(
                      PortfolioData.eduLocation,
                      style: AppTheme.bodyMedium.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/common_widgets.dart';
import 'package:flutter_portfolio/portfolio_data.dart';

class CertsLanguagesSection extends StatelessWidget {
  const CertsLanguagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      color: AppTheme.surfaceAlt,
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _CertificatesBlock(),
                const SizedBox(height: 48),
                _LanguagesBlock(),
                const SizedBox(height: 48),
                _EducationBlock(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Expanded(flex: 3, child: _CertificatesBlock()),
                const SizedBox(width: 40),
                Expanded(flex: 2, child: _LanguagesBlock()),
                const SizedBox(width: 40),
                Expanded(flex: 2, child: _EducationBlock()),
              ],
            ),
    );
  }
}

class _CertificatesBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FadeSlideIn(child: SectionLabel('Certificates')),
        const SizedBox(height: 16),
        const FadeSlideIn(
          delay: Duration(milliseconds: 80),
          child: Text('Credentials', style: AppTheme.headlineLarge),
        ),
        const SizedBox(height: 24),
        ...PortfolioData.certificates.asMap().entries.map(
              (e) => FadeSlideIn(
                delay: Duration(milliseconds: 100 + e.key * 80),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: GlowCard(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 14),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppTheme.primary.withOpacity(0.25)),
                          ),
                          child: const Icon(Icons.workspace_premium_outlined,
                              size: 16, color: AppTheme.primary),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.value.title,
                                  style: AppTheme.bodyMedium.copyWith(
                                      color: AppTheme.textPrimary,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 2),
                              Text(
                                '${e.value.issuer}  ·  ${e.value.year}',
                                style: AppTheme.bodyMedium.copyWith(
                                    fontSize: 12,
                                    color: AppTheme.textMuted,
                                    fontFamily: 'JetBrainsMono'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ],
    );
  }
}

class _LanguagesBlock extends StatelessWidget {
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

class _EducationBlock extends StatelessWidget {
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

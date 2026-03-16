import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/common_widgets.dart';
import 'package:flutter_portfolio/portfolio_data.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;
    final crossAxis = isMobile ? 1 : 2;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      color: AppTheme.surfaceAlt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeSlideIn(child: SectionLabel('Skills')),
          const SizedBox(height: 16),
          FadeSlideIn(
            delay: const Duration(milliseconds: 100),
            child: Text('What I Work With', style: AppTheme.displayMedium),
          ),
          const SizedBox(height: 12),
          FadeSlideIn(
            delay: const Duration(milliseconds: 150),
            child: Text(
              'Technologies, tools, and practices I use to build great apps.',
              style: AppTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxis,
              childAspectRatio: isMobile ? 1.4 : 1.5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: PortfolioData.skillCategories.length,
            itemBuilder: (ctx, i) {
              final cat = PortfolioData.skillCategories[i];
              return FadeSlideIn(
                delay: Duration(milliseconds: i * 100),
                child: GlowCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cat.title, style: AppTheme.headlineMedium),
                      const SizedBox(height: 24),
                      ...cat.skills.asMap().entries.map(
                            (e) => Padding(
                              padding: EdgeInsets.only(
                                bottom: e.key < cat.skills.length - 1 ? 18 : 0,
                              ),
                              child: SkillBar(
                                name: e.value.name,
                                level: e.value.level,
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

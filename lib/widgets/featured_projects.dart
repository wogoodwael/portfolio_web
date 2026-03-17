
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/common_widgets.dart';
import 'package:flutter_portfolio/portfolio_data.dart';
import 'package:flutter_portfolio/widgets/featured_card.dart';

class FeaturedProjects extends StatelessWidget {
  final bool isMobile;
  const FeaturedProjects({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final featured = PortfolioData.projects.where((p) => p.featured).toList();
    if (featured.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                '⭐  FEATURED',
                style: TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ...featured.asMap().entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: FadeSlideIn(
                  delay: Duration(milliseconds: e.key * 150),
                  child: FeaturedCard(project: e.value, isMobile: isMobile),
                ),
              ),
            ),
      ],
    );
  }
}


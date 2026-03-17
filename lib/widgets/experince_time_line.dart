
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/common_widgets.dart';
import 'package:flutter_portfolio/portfolio_data.dart';
import 'package:flutter_portfolio/widgets/time_line_item.dart';

class ExperienceTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FadeSlideIn(child: SectionLabel('Experience')),
        const SizedBox(height: 16),
        const FadeSlideIn(
          delay: Duration(milliseconds: 100),
          child: Text('Work History', style: AppTheme.displayMedium),
        ),
        const SizedBox(height: 32),
        ...PortfolioData.experiences.asMap().entries.map(
              (e) => FadeSlideIn(
                delay: Duration(milliseconds: e.key * 150),
                child: TimelineItem(
                  experience: e.value,
                  isLast: e.key == PortfolioData.experiences.length - 1,
                ),
              ),
            ),
      ],
    );
  }
}

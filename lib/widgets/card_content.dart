import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/common_widgets.dart';
import 'package:flutter_portfolio/portfolio_data.dart';
import 'package:flutter_portfolio/widgets/link_icons.dart';

class CardContent extends StatelessWidget {
  final Project project;
  final Color color;

  const CardContent({required this.project, required this.color});

  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                child: Text(project.title, style: AppTheme.headlineLarge)),
            LinkIcons(project: project),
          ],
        ),
        const SizedBox(height: 10),
        Text(project.description, style: AppTheme.bodyLarge),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.tags.map((t) => TagChip(t, color: color)).toList(),
        ),
      ],
    );
  }
}

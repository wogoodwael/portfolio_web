import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/common_widgets.dart';
import 'package:flutter_portfolio/portfolio_data.dart';
import 'package:flutter_portfolio/widgets/featured_projects.dart';
import 'package:flutter_portfolio/widgets/filter_row.dart';
import 'package:flutter_portfolio/widgets/project_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  ProjectCategory? _filter;

  List<Project> get _filtered => _filter == null
      ? PortfolioData.projects
      : PortfolioData.projects.where((p) => p.category == _filter).toList();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;
    final isTablet = width < 1100;

    final crossAxis = isMobile ? 1 : (isTablet ? 2 : 3);

    // Filter projects for grid (all non-featured, or filtered ones)
    final projectsForGrid = _filter == null
        ? PortfolioData.projects.where((p) => !p.featured).toList()
        : _filtered;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FadeSlideIn(
            child: SectionLabel('Projects'),
          ),
          const SizedBox(height: 16),
          const FadeSlideIn(
            delay: Duration(milliseconds: 100),
            child: Text("Things I've Built", style: AppTheme.displayMedium),
          ),
          const SizedBox(height: 32),

          // Filter chips
          FadeSlideIn(
            delay: const Duration(milliseconds: 200),
            child: FilterRow(
              selected: _filter,
              onSelect: (cat) => setState(() => _filter = cat),
            ),
          ),
          const SizedBox(height: 36),

          // Featured badge row
          if (_filter == null) ...[
            FeaturedProjects(isMobile: isMobile),
            const SizedBox(height: 36),
            const Divider(color: AppTheme.cardBorder),
            const SizedBox(height: 36),
          ],

          // Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxis,
              childAspectRatio: isMobile ? 1.1 : 0.95,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: projectsForGrid.length,
            itemBuilder: (ctx, i) {
              return FadeSlideIn(
                delay: Duration(milliseconds: i * 80),
                child: ProjectCard(project: projectsForGrid[i]),
              );
            },
          ),
        ],
      ),
    );
  }
}




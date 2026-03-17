import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/portfolio_data.dart';

class FilterRow extends StatelessWidget {
  final ProjectCategory? selected;
  final ValueChanged<ProjectCategory?> onSelect;

  const FilterRow({super.key, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    // Compose actual category values present in PortfolioData.projects
    final presentCategories = PortfolioData.projects
        .map((p) => p.category)
        .toSet()
        .where((c) => c != null)
        .cast<ProjectCategory>()
        .toList();

    // Add null at the start for "All"
    final cats = [null, ...presentCategories];

    // Dynamically name mobile/package or fallback to enum name
    final labels = <ProjectCategory?, String>{
      null: 'All',
      for (var cat in presentCategories)
        cat: cat == ProjectCategory.mobile
            ? '📱 Mobile'
            : (cat == ProjectCategory.package
                ? '📦 Package'
                : cat.name[0].toUpperCase() + cat.name.substring(1)),
    };

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: cats.map((cat) {
          // Defensive label lookup (should always succeed if setup correctly)
          final label = labels[cat] ?? cat.toString();
          final active = selected == cat;
          return GestureDetector(
            onTap: () => onSelect(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: active
                    ? AppTheme.primary.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: active ? AppTheme.primary : AppTheme.cardBorder,
                  width: 1,
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 13,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                  color: active ? AppTheme.primary : AppTheme.textSecondary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

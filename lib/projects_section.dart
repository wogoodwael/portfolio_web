import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/common_widgets.dart';
import 'package:flutter_portfolio/portfolio_data.dart';
import 'package:url_launcher/url_launcher.dart';

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
            child: _FilterRow(
              selected: _filter,
              onSelect: (cat) => setState(() => _filter = cat),
            ),
          ),
          const SizedBox(height: 36),

          // Featured badge row
          if (_filter == null) ...[
            _FeaturedProjects(isMobile: isMobile),
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
                child: _ProjectCard(project: projectsForGrid[i]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  final ProjectCategory? selected;
  final ValueChanged<ProjectCategory?> onSelect;

  const _FilterRow({required this.selected, required this.onSelect});

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

class _FeaturedProjects extends StatelessWidget {
  final bool isMobile;
  const _FeaturedProjects({required this.isMobile});

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
                  child: _FeaturedCard(project: e.value, isMobile: isMobile),
                ),
              ),
            ),
      ],
    );
  }
}

class _FeaturedCard extends StatefulWidget {
  final Project project;
  final bool isMobile;
  const _FeaturedCard({required this.project, required this.isMobile});

  @override
  State<_FeaturedCard> createState() => _FeaturedCardState();
}

class _FeaturedCardState extends State<_FeaturedCard> {
  bool _hovered = false;

  // Helper to launch a URL if not empty
  Future<void> _launchIfNotEmpty(String url) async {
    if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  String? get _projectMainUrl {
    if (widget.project.githubUrl.isNotEmpty) return widget.project.githubUrl;
    if (widget.project.playStoreUrl.isNotEmpty) return widget.project.playStoreUrl;
    if (widget.project.appStoreUrl.isNotEmpty) return widget.project.appStoreUrl;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final color = hexColor(widget.project.accentColorHex);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          final url = _projectMainUrl;
          if (url != null && url.isNotEmpty) {
            _launchIfNotEmpty(url);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.card,
                color.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovered ? color.withOpacity(0.5) : AppTheme.cardBorder,
              width: 1,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.15),
                      blurRadius: 40,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: widget.isMobile ? _buildColumn(color) : _buildRow(color),
        ),
      ),
    );
  }

  Widget _buildRow(Color color) => Row(
        children: [
          _EmojiDisplay(
            emoji: widget.project.imageEmoji,
            color: color,
            size: 90,
          ),
          const SizedBox(width: 28),
          Expanded(child: _CardContent(project: widget.project, color: color)),
        ],
      );

  Widget _buildColumn(Color color) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _EmojiDisplay(emoji: widget.project.imageEmoji, color: color, size: 70),
          const SizedBox(height: 20),
          _CardContent(project: widget.project, color: color),
        ],
      );
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  // Helper to launch a URL if not empty
  Future<void> _launchIfNotEmpty(String url) async {
    if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  String? get _projectMainUrl {
    if (widget.project.githubUrl.isNotEmpty) return widget.project.githubUrl;
    if (widget.project.playStoreUrl.isNotEmpty) return widget.project.playStoreUrl;
    if (widget.project.appStoreUrl.isNotEmpty) return widget.project.appStoreUrl;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final color = hexColor(widget.project.accentColorHex);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          final url = _projectMainUrl;
          if (url != null && url.isNotEmpty) {
            _launchIfNotEmpty(url);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: AppTheme.cardGradient,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  _hovered ? color.withOpacity(0.4) : AppTheme.cardBorder,
              width: 1,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.12),
                      blurRadius: 24,
                      spreadRadius: 1,
                    )
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _EmojiDisplay(
                      emoji: widget.project.imageEmoji, color: color, size: 52),
                  const Spacer(),
                  _LinkIcons(project: widget.project),
                ],
              ),
              const SizedBox(height: 16),
              Text(widget.project.title, style: AppTheme.headlineMedium),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  widget.project.description,
                  style: AppTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: widget.project.tags
                    .map((t) => TagChip(t, color: color))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmojiDisplay extends StatelessWidget {
  final String emoji;
  final Color color;
  final double size;

  const _EmojiDisplay(
      {required this.emoji, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(size * 0.25),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Center(
        child: Text(emoji, style: TextStyle(fontSize: size * 0.45)),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final Project project;
  final Color color;

  const _CardContent({required this.project, required this.color});

  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                child: Text(project.title, style: AppTheme.headlineLarge)),
            _LinkIcons(project: project),
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

class _LinkIcons extends StatelessWidget {
  final Project project;
  const _LinkIcons({required this.project});


  // Helper to launch a URL if not empty
  Future<void> _launchIfNotEmpty(String url) async {
    if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (project.githubUrl.isNotEmpty)
          _IconBtn(
            icon: Icons.code_rounded,
            tooltip: 'GitHub',
            onTap: () => _launchIfNotEmpty(project.githubUrl),
          ),
        if (project.playStoreUrl.isNotEmpty)
          _IconBtn(
            icon: Icons.android_rounded,
            tooltip: 'Play Store',
            onTap: () => _launchIfNotEmpty(project.playStoreUrl),
          ),
        if (project.appStoreUrl.isNotEmpty)
          _IconBtn(
            icon: Icons.apple_rounded,
            tooltip: 'App Store',
            onTap: () => _launchIfNotEmpty(project.appStoreUrl),
          ),
      ],
    );
  }
}

class _IconBtn extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  const _IconBtn(
      {required this.icon, required this.tooltip, required this.onTap});

  @override
  State<_IconBtn> createState() => _IconBtnState();
}

class _IconBtnState extends State<_IconBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _hovered
                  ? AppTheme.primary.withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              widget.icon,
              size: 18,
              color: _hovered ? AppTheme.primary : AppTheme.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}

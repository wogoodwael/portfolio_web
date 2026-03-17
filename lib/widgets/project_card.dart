import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/common_widgets.dart';
import 'package:flutter_portfolio/portfolio_data.dart';
import 'package:flutter_portfolio/widgets/emoji_display.dart';
import 'package:flutter_portfolio/widgets/link_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard({required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
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
                  EmojiDisplay(
                      emoji: widget.project.imageEmoji, color: color, size: 52),
                  const Spacer(),
                  LinkIcons(project: widget.project),
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


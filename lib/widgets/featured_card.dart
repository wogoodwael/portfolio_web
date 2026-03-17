import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/portfolio_data.dart';
import 'package:flutter_portfolio/widgets/card_content.dart';
import 'package:flutter_portfolio/widgets/emoji_display.dart';
import 'package:url_launcher/url_launcher.dart';

class FeaturedCard extends StatefulWidget {
  final Project project;
  final bool isMobile;
  const FeaturedCard({required this.project, required this.isMobile});

  @override
  State<FeaturedCard> createState() => _FeaturedCardState();
}

class _FeaturedCardState extends State<FeaturedCard> {
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
          EmojiDisplay(
            emoji: widget.project.imageEmoji,
            color: color,
            size: 90,
          ),
          const SizedBox(width: 28),
          Expanded(child: CardContent(project: widget.project, color: color)),
        ],
      );

  Widget _buildColumn(Color color) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EmojiDisplay(emoji: widget.project.imageEmoji, color: color, size: 70),
          const SizedBox(height: 20),
          CardContent(project: widget.project, color: color),
        ],
      );
}

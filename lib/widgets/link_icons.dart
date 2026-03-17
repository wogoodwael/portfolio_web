import 'package:flutter/material.dart';
import 'package:flutter_portfolio/portfolio_data.dart';
import 'package:flutter_portfolio/widgets/icon_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkIcons extends StatelessWidget {
  final Project project;
  const LinkIcons({required this.project});


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
          IconBtn(
            icon: Icons.code_rounded,
            tooltip: 'GitHub',
            onTap: () => _launchIfNotEmpty(project.githubUrl),
          ),
        if (project.playStoreUrl.isNotEmpty)
          IconBtn(
            icon: Icons.android_rounded,
            tooltip: 'Play Store',
            onTap: () => _launchIfNotEmpty(project.playStoreUrl),
          ),
        if (project.appStoreUrl.isNotEmpty)
          IconBtn(
            icon: Icons.apple_rounded,
            tooltip: 'App Store',
            onTap: () => _launchIfNotEmpty(project.appStoreUrl),
          ),
      ],
    );
  }
}


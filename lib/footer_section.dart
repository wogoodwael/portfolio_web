import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'wogoodwael@gmail.com',
      // you can add subject and body if you want
      // queryParameters: {'subject': 'Let\'s Work Together'}
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchGitHub() async {
    final Uri githubUri = Uri.parse('https://github.com/wogoodwael');
    if (await canLaunchUrl(githubUri)) {
      await launchUrl(githubUri, mode: LaunchMode.externalApplication);
    }
  }

  void _launchLinkedIn() async {
    final Uri linkedInUri = Uri.parse('https://www.linkedin.com/in/wogoodwael/');
    if (await canLaunchUrl(linkedInUri)) {
      await launchUrl(linkedInUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      decoration: const BoxDecoration(
        color: AppTheme.surfaceAlt,
        border: Border(
          top: BorderSide(color: AppTheme.cardBorder, width: 1),
        ),
      ),
      child: Column(
        children: [
          const FadeSlideIn(
            child: Text(
              "Let's Work Together",
              style: AppTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          const FadeSlideIn(
            delay: Duration(milliseconds: 100),
            child: Text(
              "Have a project in mind? I'd love to help bring it to life.",
              style: AppTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 36),
          FadeSlideIn(
            delay: const Duration(milliseconds: 200),
            child: Wrap(
              spacing: 16,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                NeonButton(
                  label: 'Send Email',
                  icon: Icons.email_outlined,
                  onTap: _launchEmail,
                ),
                NeonButton(
                  label: 'GitHub',
                  icon: Icons.code_rounded,
                  outline: true,
                  onTap: _launchGitHub,
                ),
                NeonButton(
                  label: 'LinkedIn',
                  icon: Icons.work_outline_rounded,
                  outline: true,
                  onTap: _launchLinkedIn,
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          const Divider(color: AppTheme.cardBorder),
          const SizedBox(height: 24),
          Text(
            '© ${DateTime.now().year} Wogood Wael  •  Built with Flutter 💙  •  wogoodwael@gmail.com',
            style: AppTheme.bodyMedium.copyWith(
              fontFamily: 'JetBrainsMono',
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

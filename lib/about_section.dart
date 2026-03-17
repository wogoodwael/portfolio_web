import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/common_widgets.dart';
import 'package:flutter_portfolio/portfolio_data.dart';
import 'package:flutter_portfolio/widgets/contact_row.dart';
import 'package:flutter_portfolio/widgets/experince_time_line.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 70,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_AboutContent(), const SizedBox(height: 48), ExperienceTimeline()],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _AboutContent()),
                const SizedBox(width: 60),
                Expanded(child: ExperienceTimeline()),
              ],
            ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // (Can't be const anymore as we need context for url launching logic)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FadeSlideIn(child: SectionLabel('About')),
        const SizedBox(height: 16),
        const FadeSlideIn(
          delay: Duration(milliseconds: 100),
          child: Text('A Bit About Me', style: AppTheme.displayMedium),
        ),
        const SizedBox(height: 24),
        const FadeSlideIn(
          delay: Duration(milliseconds: 200),
          child: Text(PortfolioData.about, style: AppTheme.bodyLarge),
        ),
        const SizedBox(height: 32),
        FadeSlideIn(
          delay: const Duration(milliseconds: 300),
          child: GlowCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ContactRow(
                  Icons.email_outlined,
                  PortfolioData.email,
                  link: Uri.tryParse('mailto:${PortfolioData.email}'),
                ),
                const SizedBox(height: 12),
                ContactRow(
                  Icons.phone_outlined,
                  PortfolioData.phone,
                  link: Uri.tryParse('tel:${PortfolioData.phone}'),
                ),
                const SizedBox(height: 12),
                const ContactRow(
                  Icons.location_on_outlined,
                  PortfolioData.location,
                ),
                const SizedBox(height: 12),
                ContactRow(
                  Icons.code_rounded,
                  PortfolioData.github,
                  link: Uri.tryParse(
                      PortfolioData.github.startsWith('http')
                          ? PortfolioData.github
                          : 'https://${PortfolioData.github}'
                  ),
                ),
                const SizedBox(height: 12),
                ContactRow(
                  Icons.work_outline_rounded,
                  PortfolioData.linkedin,
                  link: Uri.tryParse(
                      PortfolioData.linkedin.startsWith('http')
                          ? PortfolioData.linkedin
                          : 'https://${PortfolioData.linkedin}'
                  ),
                ),
                const SizedBox(height: 12),
                ContactRow(
                  Icons.brush_outlined,
                  PortfolioData.behance,
                  link: Uri.tryParse(
                      PortfolioData.behance.startsWith('http')
                          ? PortfolioData.behance
                          : 'https://${PortfolioData.behance}'
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


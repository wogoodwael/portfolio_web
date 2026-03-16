import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/common_widgets.dart';
import 'package:flutter_portfolio/portfolio_data.dart';
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
              children: [_AboutContent(), const SizedBox(height: 48), _ExperienceTimeline()],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _AboutContent()),
                const SizedBox(width: 60),
                Expanded(child: _ExperienceTimeline()),
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
                _ContactRow(
                  Icons.email_outlined,
                  PortfolioData.email,
                  link: Uri.tryParse('mailto:${PortfolioData.email}'),
                ),
                const SizedBox(height: 12),
                _ContactRow(
                  Icons.phone_outlined,
                  PortfolioData.phone,
                  link: Uri.tryParse('tel:${PortfolioData.phone}'),
                ),
                const SizedBox(height: 12),
                const _ContactRow(
                  Icons.location_on_outlined,
                  PortfolioData.location,
                ),
                const SizedBox(height: 12),
                _ContactRow(
                  Icons.code_rounded,
                  PortfolioData.github,
                  link: Uri.tryParse(
                      PortfolioData.github.startsWith('http')
                          ? PortfolioData.github
                          : 'https://${PortfolioData.github}'
                  ),
                ),
                const SizedBox(height: 12),
                _ContactRow(
                  Icons.work_outline_rounded,
                  PortfolioData.linkedin,
                  link: Uri.tryParse(
                      PortfolioData.linkedin.startsWith('http')
                          ? PortfolioData.linkedin
                          : 'https://${PortfolioData.linkedin}'
                  ),
                ),
                const SizedBox(height: 12),
                _ContactRow(
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

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String value;
  final Uri? link;

  const _ContactRow(this.icon, this.value, {this.link});

  void _launchLink(BuildContext context) async {
    if (link == null) return;
    if (await canLaunchUrl(link!)) {
      await launchUrl(link!, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $value')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget textWidget = Text(
      value,
      style: AppTheme.bodyMedium.copyWith(
        color: link != null ? AppTheme.primary : AppTheme.textPrimary,
        decoration: link != null ? TextDecoration.underline : null,
        decorationColor: AppTheme.primary
      ),
      overflow: TextOverflow.ellipsis,
    );

    return InkWell(
      onTap: link != null ? () => _launchLink(context) : null,
      borderRadius: BorderRadius.circular(4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppTheme.primary),
          const SizedBox(width: 12),
          Expanded(child: textWidget),
        ],
      ),
    );
  }
}

class _ExperienceTimeline extends StatelessWidget {
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
                child: _TimelineItem(
                  experience: e.value,
                  isLast: e.key == PortfolioData.experiences.length - 1,
                ),
              ),
            ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final Experience experience;
  final bool isLast;

  const _TimelineItem({required this.experience, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 20,
            child: Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppTheme.primaryGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.4),
                        blurRadius: 8,
                      )
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      color: AppTheme.cardBorder,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(experience.role, style: AppTheme.headlineMedium),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        experience.company,
                        style: AppTheme.bodyMedium
                            .copyWith(color: AppTheme.primary),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: AppTheme.textMuted,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        experience.period,
                        style: AppTheme.labelSmall.copyWith(
                            color: AppTheme.textMuted,
                            fontFamily: 'JetBrainsMono'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(experience.description, style: AppTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

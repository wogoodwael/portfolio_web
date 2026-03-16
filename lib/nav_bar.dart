import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/common_widgets.dart';
import 'package:flutter_portfolio/portfolio_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; // <-- Add this import

class PortfolioNavBar extends StatelessWidget implements PreferredSizeWidget {
  final ScrollController scrollController;
  const PortfolioNavBar({super.key, required this.scrollController});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  // Define the pixel positions for each section.
  // In a real app, these should be dynamically calculated or controlled by GlobalKeys.
  static const Map<String, double> _sectionOffsets = {
    'About': 700.0,
    'Skills': 1300.0,
    'Projects': 2500.0,
  };

  void _scrollToSection(String label) {
    final offset = _sectionOffsets[label];
    if (offset != null) {
      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  // Helper function to launch WhatsApp with the provided number
  Future<void> _launchWhatsApp(String phone) async {
    final String url = 'https://wa.me/$phone';
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppTheme.background.withOpacity(0.85),
        border: const Border(
          bottom: BorderSide(color: AppTheme.cardBorder, width: 1),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60),
        child: Row(
          children: [
            // Logo
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (b) => AppTheme.primaryGradient.createShader(
                Rect.fromLTWH(0, 0, b.width, b.height),
              ),
              child: Text(
                '<${PortfolioData.name.split(' ').first} />',
                style: const TextStyle(
                  fontFamily: 'JetBrainsMono',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Spacer(),
            if (!isMobile) ...[
              _NavItem(
                'About',
                onTap: () => _scrollToSection('About'),
              ),
              _NavItem(
                'Skills',
                onTap: () => _scrollToSection('Skills'),
              ),
              _NavItem(
                'Projects',
                onTap: () => _scrollToSection('Projects'),
              ),
              const SizedBox(width: 20),
            ],
            NeonButton(
              label: 'Hire Me',
              fontAwesomeIcons:FontAwesomeIcons.whatsapp, // fix: Use the correct WhatsApp icon
              onTap: () => _launchWhatsApp('201098489028'), // <-- Egyptian country code +2: 20 + 1098489028
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  const _NavItem(this.label, {this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            widget.label,
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color:
                  _hovered ? AppTheme.primary : AppTheme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

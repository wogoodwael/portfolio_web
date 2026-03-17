import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/portfolio_data.dart';
import 'package:flutter_portfolio/widgets/animated_state_row.dart';
import 'package:flutter_portfolio/widgets/animated_tag_line.dart';
import 'package:flutter_portfolio/widgets/available_badge.dart';
import 'package:flutter_portfolio/widgets/entrance_slide.dart';
import 'package:flutter_portfolio/widgets/floating_orbs.dart';
import 'package:flutter_portfolio/widgets/shimmer_name.dart';
import 'package:flutter_portfolio/widgets/type_writer_title.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  // Master entrance controller
  late AnimationController _entranceCtrl;

  // Typewriter for title
  late AnimationController _typeCtrl;
  late Animation<int> _typeAnim;

  // Continuous floating / shimmer
  late AnimationController _floatCtrl;
  late Animation<double> _floatAnim;

  // Cursor blink
  late AnimationController _cursorCtrl;
  late Animation<double> _cursorAnim;

  // Gradient shimmer on name
  late AnimationController _shimmerCtrl;
  late Animation<double> _shimmerAnim;

  // Counter animation for stats
  late AnimationController _counterCtrl;

  final String _typedText = PortfolioData.title;

  @override
  void initState() {
    super.initState();

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _typeCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _typedText.length * 65 + 400),
    );
    _typeAnim = IntTween(begin: 0, end: _typedText.length)
        .animate(CurvedAnimation(parent: _typeCtrl, curve: Curves.easeIn));
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _typeCtrl.forward();
    });

    _cursorCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 530),
    )..repeat(reverse: true);
    _cursorAnim = CurvedAnimation(parent: _cursorCtrl, curve: Curves.easeInOut);

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _floatAnim = CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut)
        .drive(Tween(begin: -6.0, end: 6.0));

    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _shimmerAnim = _shimmerCtrl.drive(Tween(begin: -1.0, end: 2.0));

    _counterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) _counterCtrl.forward();
    });
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    _typeCtrl.dispose();
    _cursorCtrl.dispose();
    _floatCtrl.dispose();
    _shimmerCtrl.dispose();
    _counterCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    final minHeight = isMobile ? 640.0 : 680.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final constrainedHeight = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : minHeight;
        final constrainedWidth = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : double.infinity;

        return SizedBox(
          width: constrainedWidth,
          height: constrainedHeight,
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/images/hero_bg_preview.svg',
                  fit: BoxFit.cover,
                ),
              ),

              FloatingOrbs(floatAnim: _floatAnim),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 80,
                  vertical: isMobile ? 52 : 72,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EntranceSlide(
                      controller: _entranceCtrl,
                      delay: 0.0,
                      child: AvailableBadge(floatAnim: _floatAnim),
                    ),
                    const SizedBox(height: 32),

                    EntranceSlide(
                      controller: _entranceCtrl,
                      delay: 0.1,
                      child: Text(
                        "Hi, I'm",
                        style: AppTheme.bodyLarge.copyWith(
                          fontSize: 18,
                          color: AppTheme.textSecondary,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),

                    EntranceSlide(
                      controller: _entranceCtrl,
                      delay: 0.15,
                      child: ShimmerName(
                        shimmerAnim: _shimmerAnim,
                        fontSize: isMobile ? 44 : 68,
                      ),
                    ),
                    const SizedBox(height: 16),

                    EntranceSlide(
                      controller: _entranceCtrl,
                      delay: 0.2,
                      child: TypewriterTitle(
                        typeAnim: _typeAnim,
                        cursorAnim: _cursorAnim,
                        isMobile: isMobile,
                      ),
                    ),
                    const SizedBox(height: 20),

                    EntranceSlide(
                      controller: _entranceCtrl,
                      delay: 0.3,
                      child: AnimatedTagline(
                        entranceCtrl: _entranceCtrl,
                        isMobile: isMobile,
                      ),
                    ),
                    const SizedBox(height: 50),

                    EntranceSlide(
                      controller: _entranceCtrl,
                      delay: 0.9,
                      child: AnimatedStatsRow(counterCtrl: _counterCtrl),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

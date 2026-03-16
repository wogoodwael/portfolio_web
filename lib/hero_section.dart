import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/portfolio_data.dart';
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

    // Ensure the Stack always has bounded width and height.
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
              // ── SVG BACKGROUND ──────────────────────────────────
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/images/hero_bg_preview.svg',
                  fit: BoxFit.cover,
                ),
              ),

              // ── ANIMATED FLOATING ORBS ──────────────────────────
              _FloatingOrbs(floatAnim: _floatAnim),

              // ── FOREGROUND CONTENT ───────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 80,
                  vertical: isMobile ? 52 : 72,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── AVAILABLE BADGE (slides in) ──────────────
                    _EntranceSlide(
                      controller: _entranceCtrl,
                      delay: 0.0,
                      child: _AvailableBadge(floatAnim: _floatAnim),
                    ),
                    const SizedBox(height: 32),

                    // ── "Hi, I'm" label ──────────────────────────
                    _EntranceSlide(
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

                    // ── ANIMATED NAME (shimmer gradient) ─────────
                    _EntranceSlide(
                      controller: _entranceCtrl,
                      delay: 0.15,
                      child: _ShimmerName(
                        shimmerAnim: _shimmerAnim,
                        fontSize: isMobile ? 44 : 68,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── TYPEWRITER TITLE ─────────────────────────
                    _EntranceSlide(
                      controller: _entranceCtrl,
                      delay: 0.2,
                      child: _TypewriterTitle(
                        typeAnim: _typeAnim,
                        cursorAnim: _cursorAnim,
                        isMobile: isMobile,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── TAGLINE with word-by-word reveal ─────────
                    _EntranceSlide(
                      controller: _entranceCtrl,
                      delay: 0.3,
                      child: _AnimatedTagline(
                        entranceCtrl: _entranceCtrl,
                        isMobile: isMobile,
                      ),
                    ),
                    const SizedBox(height: 50),

                    _EntranceSlide(
                      controller: _entranceCtrl,
                      delay: 0.9,
                      child: _AnimatedStatsRow(counterCtrl: _counterCtrl),
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

// ─────────────────────────────────────────────────────────────
// ENTRANCE SLIDE HELPER
// ─────────────────────────────────────────────────────────────
class _EntranceSlide extends StatelessWidget {
  final AnimationController controller;
  final double delay; // 0.0 – 1.0 fraction of controller duration
  final Widget child;

  const _EntranceSlide({
    required this.controller,
    required this.delay,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final start = delay.clamp(0.0, 0.9);
    final end = (delay + 0.4).clamp(0.0, 1.0);
    final opacity = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: Curves.easeOut),
    );
    final slide = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    ));

    return AnimatedBuilder(
      animation: controller,
      builder: (_, ch) => FadeTransition(
        opacity: opacity,
        child: SlideTransition(position: slide, child: ch),
      ),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────────
// FLOATING ORBS BACKGROUND LAYER
// ─────────────────────────────────────────────────────────────
class _FloatingOrbs extends StatelessWidget {
  final Animation<double> floatAnim;
  const _FloatingOrbs({required this.floatAnim});

  @override
  Widget build(BuildContext context) {
    // Give the Stack bounded height and width using SizedBox.expand
    return AnimatedBuilder(
      animation: floatAnim,
      builder: (_, __) => SizedBox.expand(
        child: Stack(
          children: [
            Positioned(
              top: 60 + floatAnim.value * 0.8,
              right: 80,
              child: const _Orb(size: 280, color: AppTheme.primary, opacity: 0.06),
            ),
            Positioned(
              bottom: 40 - floatAnim.value * 0.6,
              left: 40,
              child: const _Orb(size: 220, color: AppTheme.accent, opacity: 0.07),
            ),
            Positioned(
              top: 200 + floatAnim.value * 0.5,
              left: 200,
              child: const _Orb(size: 120, color: AppTheme.success, opacity: 0.04),
            ),
          ],
        ),
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;
  const _Orb({required this.size, required this.color, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [
          color.withOpacity(opacity),
          color.withOpacity(0),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// AVAILABLE BADGE with pulse ring
// ─────────────────────────────────────────────────────────────
class _AvailableBadge extends StatelessWidget {
  final Animation<double> floatAnim;
  const _AvailableBadge({required this.floatAnim});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.success.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppTheme.success.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PulseDot(),
          const SizedBox(width: 8),
          Text(
            'Available for opportunities',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.success,
              fontSize: 13,
              fontFamily: 'JetBrainsMono',
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulseDot extends StatefulWidget {
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _ring;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400))
      ..repeat();
    _ring = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: AnimatedBuilder(
        animation: _ring,
        builder: (_, __) => Stack(
          alignment: Alignment.center,
          children: [
            // Expanding ring
            Container(
              width: 8 + _ring.value * 8,
              height: 8 + _ring.value * 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.success.withOpacity(0.35 * (1 - _ring.value)),
              ),
            ),
            // Solid center dot
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.success,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SHIMMER NAME
// ─────────────────────────────────────────────────────────────
class _ShimmerName extends StatelessWidget {
  final Animation<double> shimmerAnim;
  final double fontSize;

  const _ShimmerName({required this.shimmerAnim, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shimmerAnim,
      builder: (_, __) {
        final t = shimmerAnim.value;
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [
              (t - 0.4).clamp(0.0, 1.0),
              t.clamp(0.0, 1.0),
              (t + 0.4).clamp(0.0, 1.0),
            ],
            colors: const [
              AppTheme.primary,
              Colors.white,
              AppTheme.accent,
            ],
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: Text(
            PortfolioData.name,
            style: AppTheme.displayLarge.copyWith(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.5,
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// TYPEWRITER TITLE
// ─────────────────────────────────────────────────────────────
class _TypewriterTitle extends StatelessWidget {
  final Animation<int> typeAnim;
  final Animation<double> cursorAnim;
  final bool isMobile;

  const _TypewriterTitle({
    required this.typeAnim,
    required this.cursorAnim,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([typeAnim, cursorAnim]),
      builder: (_, __) {
        final displayed = PortfolioData.title.substring(0, typeAnim.value);
        final showCursor = typeAnim.value < PortfolioData.title.length ||
            cursorAnim.value > 0.5;

        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Code bracket
            Text(
              '< ',
              style: AppTheme.displayMedium.copyWith(
                color: AppTheme.accent.withOpacity(0.7),
                fontSize: isMobile ? 20 : 28,
                fontFamily: 'JetBrainsMono',
              ),
            ),
            // Typed text
            Text(
              displayed,
              style: AppTheme.displayMedium.copyWith(
                fontSize: isMobile ? 20 : 28,
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            // Blinking cursor
            if (showCursor)
              AnimatedOpacity(
                opacity: cursorAnim.value,
                duration: Duration.zero,
                child: Container(
                  width: 2.5,
                  height: isMobile ? 22 : 30,
                  margin: const EdgeInsets.only(left: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            // Closing bracket
            if (typeAnim.value == PortfolioData.title.length)
              Text(
                ' />',
                style: AppTheme.displayMedium.copyWith(
                  color: AppTheme.accent.withOpacity(0.7),
                  fontSize: isMobile ? 20 : 28,
                  fontFamily: 'JetBrainsMono',
                ),
              ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
// WORD-BY-WORD TAGLINE
// ─────────────────────────────────────────────────────────────
class _AnimatedTagline extends StatefulWidget {
  final AnimationController entranceCtrl;
  final bool isMobile;

  const _AnimatedTagline({
    required this.entranceCtrl,
    required this.isMobile,
  });

  @override
  State<_AnimatedTagline> createState() => _AnimatedTaglineState();
}

class _AnimatedTaglineState extends State<_AnimatedTagline>
    with SingleTickerProviderStateMixin {
  late AnimationController _wordCtrl;
  final List<String> _words = PortfolioData.tagline.split(' ');

  @override
  void initState() {
    super.initState();
    _wordCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _words.length * 80 + 500),
    );
    Future.delayed(const Duration(milliseconds: 1100), () {
      if (mounted) _wordCtrl.forward();
    });
  }

  @override
  void dispose() {
    _wordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640),
      child: AnimatedBuilder(
        animation: _wordCtrl,
        builder: (_, __) {
          return Wrap(
            spacing: 5,
            runSpacing: 4,
            children: List.generate(_words.length, (i) {
              final start = (i / _words.length * 0.7).clamp(0.0, 1.0);
              final end = (start + 0.3).clamp(0.0, 1.0);
              final t = CurvedAnimation(
                parent: _wordCtrl,
                curve: Interval(start, end, curve: Curves.easeOut),
              ).value;

              return Opacity(
                opacity: t,
                child: Transform.translate(
                  offset: Offset(0, 10 * (1 - t)),
                  child: Text(
                    _words[i],
                    style: AppTheme.bodyLarge.copyWith(
                      fontSize: widget.isMobile ? 15 : 17,
                      height: 1.6,
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}





// ─────────────────────────────────────────────────────────────
// ANIMATED COUNTING STATS
// ─────────────────────────────────────────────────────────────
class _AnimatedStatsRow extends StatelessWidget {
  final AnimationController counterCtrl;
  const _AnimatedStatsRow({required this.counterCtrl});

  static const _stats = [
    (end: 5, suffix: '+', label: 'Apps Delivered', color: AppTheme.primary),
    (end: 2, suffix: '+', label: 'Years Experience', color: AppTheme.accent),
    (end: 10, suffix: '+', label: 'APIs Integrated', color: AppTheme.success),
    (end: 30, suffix: '+', label: 'Students Trained', color: Color(0xFFFFB703)),
  ];

  @override
  Widget build(BuildContext context) {
    // Divider line above stats
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          width: 280,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              AppTheme.primary.withOpacity(0.6),
              AppTheme.accent.withOpacity(0.0),
            ]),
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 36,
          runSpacing: 20,
          children: _stats.map((s) {
            return _CountingStat(
              endValue: s.end,
              suffix: s.suffix,
              label: s.label,
              color: s.color,
              controller: counterCtrl,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _CountingStat extends StatelessWidget {
  final int endValue;
  final String suffix;
  final String label;
  final Color color;
  final AnimationController controller;

  const _CountingStat({
    required this.endValue,
    required this.suffix,
    required this.label,
    required this.color,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final anim = IntTween(begin: 0, end: endValue).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: anim,
      builder: (_, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (b) => LinearGradient(
                colors: [color, color.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(Rect.fromLTWH(0, 0, b.width, b.height)),
              child: Text(
                '${anim.value}$suffix',
                style: AppTheme.displayMedium.copyWith(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Text(label,
                style: AppTheme.bodyMedium.copyWith(
                  fontSize: 13,
                  color: AppTheme.textSecondary,
                )),
          ],
        );
      },
    );
  }
}

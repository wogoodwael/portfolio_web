import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Offset offset;

  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = const Offset(0, 30),
  });

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _opacity =
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOut).drive(
      Tween(begin: 0.0, end: 1.0),
    );
    _slide = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut).drive(
      Tween(begin: widget.offset, end: Offset.zero),
    );

    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, child) => Opacity(
        opacity: _opacity.value,
        child: Transform.translate(
          offset: _slide.value,
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}

// ── SECTION LABEL ─────────────────────────────────────────────
class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text.toUpperCase(),
          style: AppTheme.labelSmall,
        ),
      ],
    );
  }
}

// ── GRADIENT TEXT ─────────────────────────────────────────────
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;

  const GradientText(
    this.text, {
    super.key,
    this.style,
    this.gradient = AppTheme.primaryGradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

// ── NEON BUTTON ───────────────────────────────────────────────
class NeonButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final FaIconData? fontAwesomeIcons;
  final bool outline;

  const NeonButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.fontAwesomeIcons,
    this.outline = false,
  });

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: widget.outline
                ? null
                : (_hovered
                    ? AppTheme.primaryGradient
                    : const LinearGradient(
                        colors: [Color(0xFF00B4D8), Color(0xFF6B21D8)])),
            borderRadius: BorderRadius.circular(10),
            border: widget.outline
                ? Border.all(
                    color: _hovered ? AppTheme.primary : AppTheme.primaryDim,
                    width: 1.5)
                : null,
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.35),
                      blurRadius: 20,
                      spreadRadius: 1,
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon,
                    size: 16,
                    color: widget.outline ? AppTheme.primary : Colors.white),
                const SizedBox(width: 8),
              ]
             else if (widget.fontAwesomeIcons != null) ...[
                FaIcon(widget.fontAwesomeIcons,
                    size: 16,
                    color: widget.outline ? AppTheme.primary : Colors.white),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: widget.outline ? AppTheme.primary : Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── GLOWING CARD ──────────────────────────────────────────────
class GlowCard extends StatefulWidget {
  final Widget child;
  final Color? glowColor;
  final EdgeInsets? padding;

  const GlowCard({
    super.key,
    required this.child,
    this.glowColor,
    this.padding,
  });

  @override
  State<GlowCard> createState() => _GlowCardState();
}

class _GlowCardState extends State<GlowCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final glow = widget.glowColor ?? AppTheme.primary;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: widget.padding ?? const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: AppTheme.cardGradient,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? glow.withOpacity(0.5)
                : AppTheme.cardBorder,
            width: 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: glow.withOpacity(0.12),
                    blurRadius: 30,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: widget.child,
      ),
    );
  }
}

// ── TAG CHIP ──────────────────────────────────────────────────
class TagChip extends StatelessWidget {
  final String label;
  final Color? color;

  const TagChip(this.label, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppTheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: c.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: c.withOpacity(0.3), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'JetBrainsMono',
          fontSize: 11,
          color: c,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ── SKILL BAR ─────────────────────────────────────────────────

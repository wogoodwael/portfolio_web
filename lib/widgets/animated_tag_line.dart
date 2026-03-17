import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/portfolio_data.dart';

class AnimatedTagline extends StatefulWidget {
  final AnimationController entranceCtrl;
  final bool isMobile;

  const AnimatedTagline({
    required this.entranceCtrl,
    required this.isMobile,
  });

  @override
  State<AnimatedTagline> createState() => _AnimatedTaglineState();
}

class _AnimatedTaglineState extends State<AnimatedTagline>
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

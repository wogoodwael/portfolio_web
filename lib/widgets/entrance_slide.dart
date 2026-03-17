
import 'package:flutter/material.dart';

class EntranceSlide extends StatelessWidget {
  final AnimationController controller;
  final double delay; // 0.0 – 1.0 fraction of controller duration
  final Widget child;

  const EntranceSlide({
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

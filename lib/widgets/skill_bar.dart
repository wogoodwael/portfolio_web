import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';

class SkillBar extends StatefulWidget {
  final String name;
  final double level;

  const SkillBar({super.key, required this.name, required this.level});

  @override
  State<SkillBar> createState() => _SkillBarState();
}

class _SkillBarState extends State<SkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _anim =
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic)
            .drive(Tween(begin: 0.0, end: widget.level));
    Future.delayed(const Duration(milliseconds: 300), () {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.name, style: AppTheme.bodyMedium),
            AnimatedBuilder(
              animation: _anim,
              builder: (_, __) => Text(
                '${(_anim.value * 100).round()}%',
                style: AppTheme.labelSmall
                    .copyWith(fontSize: 11),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 4,
          decoration: BoxDecoration(
            color: AppTheme.cardBorder,
            borderRadius: BorderRadius.circular(2),
          ),
          child: AnimatedBuilder(
            animation: _anim,
            builder: (_, __) => FractionallySizedBox(
              widthFactor: _anim.value,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.5),
                      blurRadius: 6,
                      offset: const Offset(0, 0),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

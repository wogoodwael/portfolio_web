import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';

class PulseDot extends StatefulWidget {
  @override
  State<PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<PulseDot>
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

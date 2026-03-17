import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';
import 'package:flutter_portfolio/widgets/pulse_dot.dart';

class AvailableBadge extends StatelessWidget {
  final Animation<double> floatAnim;
  const AvailableBadge({required this.floatAnim});

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
          PulseDot(),
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

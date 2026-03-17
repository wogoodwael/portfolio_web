import 'package:flutter/material.dart';
import 'package:flutter_portfolio/app_theme.dart';

class IconBtn extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  const IconBtn(
      {required this.icon, required this.tooltip, required this.onTap});

  @override
  State<IconBtn> createState() => _IconBtnState();
}

class _IconBtnState extends State<IconBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _hovered
                  ? AppTheme.primary.withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              widget.icon,
              size: 18,
              color: _hovered ? AppTheme.primary : AppTheme.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}

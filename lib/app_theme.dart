import 'package:flutter/material.dart';

class AppTheme {
  // ── COLORS ────────────────────────────────────────────────
  static const Color background = Color(0xFF080C14);
  static const Color surface = Color(0xFF0D1421);
  static const Color surfaceAlt = Color(0xFF111827);
  static const Color card = Color(0xFF141E2E);
  static const Color cardBorder = Color(0xFF1E2D42);

  static const Color primary = Color(0xFF00D4FF);       // electric cyan
  static const Color primaryDim = Color(0xFF0099BB);
  static const Color accent = Color(0xFF7C3AED);        // deep violet
  static const Color accentGlow = Color(0xFF9F67FF);
  static const Color success = Color(0xFF06D6A0);
  static const Color warning = Color(0xFFFFB703);

  static const Color textPrimary = Color(0xFFE8F4FD);
  static const Color textSecondary = Color(0xFF8BA3C1);
  static const Color textMuted = Color(0xFF4A6080);

  // ── GRADIENTS ─────────────────────────────────────────────
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF080C14), Color(0xFF0D1421), Color(0xFF080C14)],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00D4FF), Color(0xFF7C3AED)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF141E2E), Color(0xFF0F1825)],
  );

  // ── TEXT STYLES ───────────────────────────────────────────
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'SpaceGrotesk',
    fontSize: 56,
    fontWeight: FontWeight.w800,
    color: textPrimary,
    letterSpacing: -2,
    height: 1.1,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'SpaceGrotesk',
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: -1,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'SpaceGrotesk',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'SpaceGrotesk',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.7,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.6,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'JetBrainsMono',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: primary,
    letterSpacing: 1.5,
  );

  // ── THEME DATA ────────────────────────────────────────────
  static ThemeData get theme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.dark(
          primary: primary,
          secondary: accent,
          surface: surface,
          background: background,
        ),
        fontFamily: 'Inter',
      );
}

// Utility: parse hex color string
Color hexColor(String hex) {
  final buffer = StringBuffer();
  if (hex.length == 6 || hex.length == 7) buffer.write('ff');
  buffer.write(hex.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

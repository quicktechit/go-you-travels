
import 'package:flutter/material.dart';

class AppColors {
  // --- Light Palette ---
  static const primary = Color(0xFF2563EB); // Main Blue
  static const primaryDark = Color(0xFF1E40AF);
  static const primaryLight = Color(0xFF5093FF);

  static const secondary = Color(0xFF17B553); // Secondary Green
  static const secondaryDark = Color(0xFF009735); // Secondary Green
  static const secondaryLight = Color(0xFFC8FFD7);

  static const background = Color(0xFFF8FAFC);
  static const surface = Colors.white;

  static const textPrimary = Color(0xFF1E293B);
  static const textSecondary = Color(0xFF64748B);
  static const textMuted = Color(0xFF475569);

  static const line = Color(0xFFE2E8F0);
  static const cardShadow = Color(0x0D000000); // 5% black

  // --- Dark Palette ---
  static const darkBackground = Color(0xFF0F172A);
  static const darkSurface = Color(0xFF1E293B);
  static const darkSurfaceHigh = Color(0xFF334155);
  static const darkLine = Color(0xFF334155);

  static const darkTextPrimary = Color(0xFFF8FAFC);
  static const darkTextSecondary = Color(0xFF94A3B8);
  static const darkTextMuted = Color(0xFF64748B);

  // --- Gradients ---
  static LinearGradient heroGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryDark, primaryLight],
  );

  static LinearGradient statsGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, primary],
  );

  static LinearGradient cardActionGradient(Color color) => LinearGradient(
    colors: [
      color.withValues(alpha: 0.08),
      color.withValues(alpha: 0.03),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
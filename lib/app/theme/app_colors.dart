
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

  static const amber = Color(0xFFFFDF59);
  static const yellow = Color(0xFFF59E0B);
  static const orange = Color(0xFFEA580C);
  static const red = Color(0xFFEA0C0C);

  // --- Social / Brand & Semantic UI Colors ---
  static const whatsappGreen = Color(0xFF25D366);
  static const imoBlue = Color(0xFF0088CC);
  static const successGreen = Color(0xFF047857);
  static const successLight = Color(0xFFDCFCE7);
  static const successDark = Color(0xFF064E3B);
  static const successAccent = Color(0xFF34D399);
  static const successEmerald = Color(0xFF16A34A);
  static const warningOrange = Color(0xFFC2410C);
  static const warningAmber = Color(0xFFD97706);
  static const softOrange = Color(0xFFFFF7ED);
  static const softOrangeBorder = Color(0xFFFFEDD5);
  static const darkBrown = Color(0xFF451A03);
  static const darkBrownBorder = Color(0xFF78350F);
  static const lightOrangeText = Color(0xFFFDBA74);
  static const purpleAccent = Color(0xFF7C3AED);
  static const tealAccent = Color(0xFF0D9488);
  static const emeraldLight = Color(0xFF6EE7B7);
  static const brownText = Color(0xFFB45309);
  static const indigoLight = Color(0xFFEEF2FF);
  static const blueLight = Color(0xFFEFF6FF);
  static const redLight = Color(0xFFFEF2F2);

  static const teal = Color(0xFF0D9488);
  static const tealDark = Color(0xFF0F766E);
  static const tealLight = Color(0xFF14B8A6);
  static const emerald = Color(0xFF059669);
  static const indigoAccent = Color(0xFF4F46E5);
  static const amberWarning = Color(0xFFD97706);

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
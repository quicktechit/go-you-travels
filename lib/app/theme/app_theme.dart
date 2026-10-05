
import '../../core/constant/const.dart';

class AppTheme {
  static ThemeData light() {
    final bodyFont = GoogleFonts.figtree();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: TimedFadePageTransitionsBuilder(),
          TargetPlatform.iOS: TimedFadePageTransitionsBuilder(),
          TargetPlatform.macOS: TimedFadePageTransitionsBuilder(),
          TargetPlatform.windows: TimedFadePageTransitionsBuilder(),
          TargetPlatform.linux: TimedFadePageTransitionsBuilder(),
        },
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: const Color(0xFFEF4444),
      ),
      fontFamily: bodyFont.fontFamily,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.surface,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        centerTitle: false,
        titleTextStyle: GoogleFonts.figtree(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.figtree(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        headlineMedium: GoogleFonts.figtree(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        titleLarge: GoogleFonts.figtree(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        titleMedium: GoogleFonts.figtree(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleSmall: GoogleFonts.figtree(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
        bodyLarge: GoogleFonts.figtree(
          fontSize: 15.sp,
          color: AppColors.textPrimary,
        ),
        bodyMedium: GoogleFonts.figtree(
          fontSize: 13.8.sp,
          color: AppColors.textPrimary,
        ),
        bodySmall: GoogleFonts.figtree(
          fontSize: 12.sp,
          color: AppColors.textMuted,
        ),
        labelLarge: GoogleFonts.figtree(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          textStyle: GoogleFonts.figtree(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        floatingLabelStyle:
            GoogleFonts.figtree(
              color: AppColors.darkSurface,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.line, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.line, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5.w),
        ),
        hintStyle: GoogleFonts.figtree(
          color: AppColors.textSecondary,
          fontSize: 14.sp,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: const BorderSide(color: AppColors.line, width: 1),
        ),
      ),
      dividerTheme: DividerThemeData(color: AppColors.line, thickness: 1.h),
    );
  }

  static ThemeData dark() {
    final bodyFont = GoogleFonts.figtree();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkTextPrimary,
        error: const Color(0xFFEF4444),
      ),
      fontFamily: bodyFont.fontFamily,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.darkSurface,
        iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
        centerTitle: false,
        titleTextStyle: GoogleFonts.figtree(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextPrimary,
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.figtree(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextPrimary,
        ),
        headlineMedium: GoogleFonts.figtree(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextPrimary,
        ),
        titleLarge: GoogleFonts.figtree(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextSecondary,
        ),
        titleMedium: GoogleFonts.figtree(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextSecondary,
        ),
        titleSmall: GoogleFonts.figtree(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.darkTextSecondary,
        ),
        bodyLarge: GoogleFonts.figtree(
          fontSize: 15.sp,
          color: AppColors.darkTextPrimary,
        ),
        bodyMedium: GoogleFonts.figtree(
          fontSize: 13.sp,
          color: AppColors.darkTextSecondary,
        ),
        bodySmall: GoogleFonts.figtree(
          fontSize: 12.sp,
          color: AppColors.darkTextMuted,
        ),
        labelLarge: GoogleFonts.figtree(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          textStyle: GoogleFonts.figtree(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceHigh,
        floatingLabelStyle:
        GoogleFonts.figtree(
          color: AppColors.darkTextSecondary,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.darkLine, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.darkLine, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5.w),
        ),
        hintStyle: GoogleFonts.figtree(
          color: AppColors.darkTextMuted,
          fontSize: 14.sp,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: const BorderSide(color: AppColors.darkLine, width: 1),
        ),
      ),
      dividerTheme: DividerThemeData(color: AppColors.darkLine, thickness: 1.h),
    );
  }
}

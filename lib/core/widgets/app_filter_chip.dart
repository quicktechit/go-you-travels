import '../constant/const.dart';

class AppFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? padding;

  const AppFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final unselectedBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final unselectedBorder = isDark ? AppColors.darkLine : AppColors.line;
    final unselectedText = isDark ? AppColors.darkTextSecondary : AppColors.textMuted;

    final selectedBg = isDark
        ? AppColors.secondaryDark.withValues(alpha: 0.25)
        : AppColors.secondaryLight.withValues(alpha: 0.4);
    final selectedBorder = isDark ? AppColors.secondaryDark : AppColors.secondaryLight;
    final selectedText = isDark ? AppColors.secondaryLight : AppColors.secondaryDark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : unselectedBg,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? selectedBorder : unselectedBorder,
            width: 1.w,
          ),
          boxShadow: [
            if (!isSelected && !isDark)
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Text(
          label,
          style: GoogleFonts.figtree(
            fontSize: 13.5.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            color: isSelected ? selectedText : unselectedText,
          ),
        ),
      ),
    );
  }
}

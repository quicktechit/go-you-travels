import '../../../../core/constant/const.dart';
import '../provider/profile_provider.dart';

class PreferenceSettingsCard extends ConsumerWidget {
  const PreferenceSettingsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(quickTechProfileProvider);
    final notifier = ref.read(quickTechProfileProvider.notifier);

    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final primaryText = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          'LANGUAGE & DISPLAY PREFERENCE',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: secondaryText,
                letterSpacing: 0.6,
              ),
        ),
        SizedBox(height: 12.h),

        // Settings Card
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: borderColor, width: 1.w),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: AppColors.cardShadow,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Column(
            children: [
              // Language Selector Row
              Row(
                children: [
                  Icon(
                    Icons.translate_rounded,
                    size: 22.sp,
                    color: AppColors.primaryDark,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Language / ভাষা',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: primaryText,
                              ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          profile.selectedLanguage == 'EN' ? 'English' : 'বাংলা',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: secondaryText,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),

                  // Language Segment Buttons
                  Row(
                    children: [
                      _buildLangSegmentButton(
                        context: context,
                        label: 'English',
                        isSelected: profile.selectedLanguage == 'EN',
                        onTap: () => notifier.setLanguage('EN'),
                        isDark: isDark,
                      ),
                      SizedBox(width: 6.w),
                      _buildLangSegmentButton(
                        context: context,
                        label: 'বাংলা',
                        isSelected: profile.selectedLanguage == 'BN',
                        onTap: () => notifier.setLanguage('BN'),
                        isDark: isDark,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 14.h),

              // Divider
              Divider(
                height: 1.h,
                color: isDark ? AppColors.darkLine : AppColors.line,
              ),
              SizedBox(height: 14.h),

              // Theme Switch Row
              Row(
                children: [
                  Icon(
                    isDark ? Icons.wb_sunny_outlined : Icons.wb_sunny_rounded,
                    size: 22.sp,
                    color: AppColors.primaryDark,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isDark ? 'Dark Mode' : 'White Mode (Default)',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: primaryText,
                              ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          isDark ? 'Dark surface background' : 'Clean white background',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: secondaryText,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: isDark,
                    activeTrackColor: AppColors.primaryDark,
                    onChanged: (val) {
                      ref.read(themeProvider.notifier).state =
                          val ? ThemeMode.dark : ThemeMode.light;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLangSegmentButton({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    final bg = isSelected
        ? (isDark ? AppColors.secondaryDark.withValues(alpha: 0.3) : AppColors.secondaryLight)
        : (isDark ? AppColors.darkSurfaceHigh : AppColors.surface);
    final border = isSelected
        ? (isDark ? AppColors.secondaryDark : AppColors.secondary)
        : (isDark ? AppColors.darkLine : AppColors.line);
    final text = isSelected
        ? (isDark ? AppColors.secondaryLight : AppColors.secondaryDark)
        : (isDark ? AppColors.darkTextSecondary : AppColors.textMuted);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: border, width: 1.w),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: text,
              ),
        ),
      ),
    );
  }
}

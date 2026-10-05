import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../../../../core/widgets/app_button.dart';
import '../provider/lead_provider.dart';

class FilterLeadsModal extends HookConsumerWidget {
  const FilterLeadsModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const FilterLeadsModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechLeadProvider);
    final notifier = ref.read(quickTechLeadProvider.notifier);
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final sheetBg = isDark ? AppColors.darkSurface : AppColors.background;
    final chipSelectedBg = isDark ? AppColors.secondaryDark.withValues(alpha: 0.3) : AppColors.secondaryLight;
    final chipUnselectedBg = isDark ? AppColors.darkSurfaceHigh : AppColors.background;
    final chipSelectedBorder = isDark ? AppColors.secondaryDark : AppColors.secondary;
    final chipUnselectedBorder = isDark ? AppColors.darkLine : AppColors.line;

    final selectedPriority = useState<String>(state.filterPriority);
    final selectedCountry = useState<String>(state.filterCountry);
    final selectedSource = useState<String>(state.filterSource);

    final priorityOptions = ['Any Priority', 'Low', 'Medium', 'High', 'Urgent'];
    final countryOptions = [
      'All',
      'Canada',
      'United Kingdom',
      'Schengen (Germany)',
      'Australia',
      'USA'
    ];
    final sourceOptions = [
      'All',
      'Facebook Ads',
      'Google Search',
      'Walk-in',
      'Local Agent',
      'Referral'
    ];

    return Container(
      decoration: BoxDecoration(
        color: sheetBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 28.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkLine : AppColors.line,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),

            // Header Row
            Row(
              children: [
                Icon(
                  LucideIcons.filter,
                  size: 20.sp,
                  color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                ),
                SizedBox(width: 10.w),
                Text(
                  'Filter Leads',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // 1. Filter by Priority
            Text(
              'Filter by Priority:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textPrimary,
                  ),
            ),
            SizedBox(height: 12.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: priorityOptions.map((option) {
                  final isSelected = selectedPriority.value == option;
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: GestureDetector(
                      onTap: () => selectedPriority.value = option,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? chipSelectedBg : chipUnselectedBg,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? chipSelectedBorder
                                : chipUnselectedBorder,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          option,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight:
                                    isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected
                                    ? (isDark
                                        ? const Color(0xFF6EE7B7)
                                        : const Color(0xFF047857))
                                    : (isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.textSecondary),
                              ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20.h),

            // 2. Filter by Destination Country
            Text(
              'Filter by Destination Country:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textPrimary,
                  ),
            ),
            SizedBox(height: 12.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: countryOptions.map((option) {
                  final isSelected = selectedCountry.value == option;
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: GestureDetector(
                      onTap: () => selectedCountry.value = option,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? chipSelectedBg : chipUnselectedBg,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? chipSelectedBorder
                                : chipUnselectedBorder,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          option,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight:
                                    isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected
                                    ? (isDark
                                        ? const Color(0xFF6EE7B7)
                                        : const Color(0xFF047857))
                                    : (isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.textSecondary),
                              ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20.h),

            // 3. Filter by Lead Source
            Text(
              'Filter by Lead Source:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textPrimary,
                  ),
            ),
            SizedBox(height: 12.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: sourceOptions.map((option) {
                  final isSelected = selectedSource.value == option;
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: GestureDetector(
                      onTap: () => selectedSource.value = option,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? chipSelectedBg : chipUnselectedBg,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? chipSelectedBorder
                                : chipUnselectedBorder,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          option,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight:
                                    isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected
                                    ? (isDark
                                        ? const Color(0xFF6EE7B7)
                                        : const Color(0xFF047857))
                                    : (isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.textSecondary),
                              ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 32.h),

            // Bottom Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  text: 'Reset All',
                  variant: AppButtonVariant.text,
                  textColor: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.primaryDark,
                  fontSize: 15.sp,
                  onPressed: () {
                    notifier.resetFilters();
                    Navigator.pop(context);
                  },
                ),
                AppButton(
                  text: 'Apply Filters',
                  backgroundColor: AppColors.primaryDark,
                  textColor: AppColors.surface,
                  height: 48.h,
                  fontSize: 15.sp,
                  borderRadius: 24.r,
                  horizontalPadding: 28.w,
                  onPressed: () {
                    notifier.applyFilters(
                      priority: selectedPriority.value,
                      country: selectedCountry.value,
                      source: selectedSource.value,
                    );
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

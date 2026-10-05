import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
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

    final sheetBg = isDark ? AppColors.darkSurface : const Color(0xFFF1F2F6);
    final chipSelectedBg = isDark ? const Color(0xFF064E3B) : const Color(0xFFECFDF5);
    final chipUnselectedBg = isDark ? AppColors.darkSurfaceHigh : const Color(0xFFF8FAFC);
    final chipSelectedBorder = isDark ? const Color(0xFF059669) : const Color(0xFFA7F3D0);
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
                  style: GoogleFonts.figtree(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // 1. Filter by Priority
            Text(
              'Filter by Priority:',
              style: GoogleFonts.figtree(
                fontSize: 13.sp,
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
                          style: GoogleFonts.figtree(
                            fontSize: 12.sp,
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
              style: GoogleFonts.figtree(
                fontSize: 13.sp,
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
                          style: GoogleFonts.figtree(
                            fontSize: 12.sp,
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
              style: GoogleFonts.figtree(
                fontSize: 13.sp,
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
                          style: GoogleFonts.figtree(
                            fontSize: 12.sp,
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
                TextButton(
                  onPressed: () {
                    notifier.resetFilters();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Reset All',
                    style: GoogleFonts.figtree(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.primaryDark,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    notifier.applyFilters(
                      priority: selectedPriority.value,
                      country: selectedCountry.value,
                      source: selectedSource.value,
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D4ED8),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 28.w,
                      vertical: 14.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Apply Filters',
                    style: GoogleFonts.figtree(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

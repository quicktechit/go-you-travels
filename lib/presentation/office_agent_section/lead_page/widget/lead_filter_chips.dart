import '../../../../core/constant/const.dart';
import '../provider/lead_provider.dart';

class LeadFilterChips extends ConsumerWidget {
  const LeadFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechLeadProvider);
    final notifier = ref.read(quickTechLeadProvider.notifier);
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final tabs = [
      'All Leads (${state.totalLeadsCount})',
      'New (${state.newInquiriesCount})',
      'Contacted (${state.contactedCount})',
      'Interested (${state.interestedCount})',
      'Follow-up (${state.followUpsDueCount})',
      'Converted (${state.convertedCount})',
      'Not Interested (${state.notInterestCount})',
      'Not Reachable (${state.notReachableCount})',
      'Lost (${state.lostCount})',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: tabs.map((tab) {
          final cleanSelected = state.selectedStatusTab.contains(' (')
              ? state.selectedStatusTab.split(' (').first
              : state.selectedStatusTab;
          final cleanTab = tab.contains(' (') ? tab.split(' (').first : tab;
          final isSelected = cleanSelected == cleanTab;

          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () => notifier.setSelectedStatusTab(tab),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDark ? const Color(0xFF064E3B) : const Color(0xFFECFDF5))
                      : (isDark ? AppColors.darkSurface : Colors.white),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? (isDark ? const Color(0xFF059669) : const Color(0xFFA7F3D0))
                        : (isDark ? AppColors.darkLine : AppColors.line),
                    width: 1,
                  ),
                ),
                child: Text(
                  tab,
                  style: GoogleFonts.figtree(
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? (isDark ? const Color(0xFF6EE7B7) : const Color(0xFF047857))
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
    );
  }
}

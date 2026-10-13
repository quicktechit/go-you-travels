import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../provider/lead_provider.dart';
import '../widget/create_lead_modal.dart';
import '../widget/filter_leads_modal.dart';
import '../widget/lead_card_item.dart';
import '../widget/lead_filter_chips.dart';
import '../widget/lead_stats_grid.dart';

class QuickTechPaidAgentLeadPage extends HookConsumerWidget {
  const QuickTechPaidAgentLeadPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechLeadProvider);
    final notifier = ref.read(quickTechLeadProvider.notifier);
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final searchController = useTextEditingController(text: state.searchQuery);



    return Scaffold(
      appBar: const CustomAppbar(
        title: 'CRM Leads',
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          heroTag: null,
          onPressed: () => CreateLeadModal.show(context),
          backgroundColor: AppColors.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(
            LucideIcons.plus,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 90.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Search Bar & Filter Button
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: searchController,
                      hint: 'Search leads, phone, destination...',
                      prefixIcon: LucideIcons.search,
                      suffixIcon: searchController.text.isNotEmpty
                          ? LucideIcons.x
                          : null,
                      onChanged: (val) => notifier.setSearchQuery(val),


                      borderRadius: 14,
                    ),
                  ),
                  SizedBox(width: 10.w),

                  // Filter Button
                  GestureDetector(
                    onTap: () => FilterLeadsModal.show(context),
                    child: Container(
                      width: 48.h,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: AppColors.darkTextSecondary.withAlpha(70), width: 1),

                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        LucideIcons.slidersHorizontal,
                        size: 20.sp,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // 2. 2x2 Metric Cards Grid
              const LeadStatsGrid(),
              SizedBox(height: 16.h),

              // 4. Horizontal Status Filter Chips
              const LeadFilterChips(),
              SizedBox(height: 16.h),

              // 5. Leads List
              if (state.filteredLeads.isEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.users,
                        size: 40.sp,
                        color: isDark
                            ? AppColors.darkTextMuted
                            : AppColors.textMuted,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'No leads found matching criteria',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.filteredLeads.length,
                  itemBuilder: (context, index) {
                    final lead = state.filteredLeads[index];
                    return LeadCardItem(lead: lead);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

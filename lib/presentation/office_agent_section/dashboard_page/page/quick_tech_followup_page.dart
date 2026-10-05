import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../home_section/quick_tech_home_page/model/role_tabs_config.dart';
import '../../../home_section/quick_tech_home_page/provider/home_provider.dart';
import '../../../home_section/quick_tech_home_page/widget/home_bottom_nav.dart';
import '../../../login_page/model/user_role.dart';
import '../provider/quick_tech_followup_provider.dart';
import '../widget/followup_card_item.dart';
import '../widget/followup_filter_chips.dart';

class QuickTechFollowupPage extends ConsumerWidget {
  const QuickTechFollowupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechFollowupProvider);
    final homeState = ref.watch(homeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;


    return Scaffold(
      appBar: CustomAppbar(
        title: 'Follow-ups',
        subtitle: 'Go You Travels',
        showBackButton: true,

      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Horizontal Category Filter Chips
              const FollowupFilterChips(),
              SizedBox(height: 16.h),

              // 2. Follow-ups List
              if (state.filteredItems.isEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 48.h),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.calendarX,
                        size: 42.sp,
                        color: isDark ? AppColors.darkTextMuted : AppColors.textMuted,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'No follow-ups found in this category',
                        style: GoogleFonts.figtree(
                          fontSize: 14.sp,
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
                  itemCount: state.filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = state.filteredItems[index];
                    return FollowupCardItem(item: item);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

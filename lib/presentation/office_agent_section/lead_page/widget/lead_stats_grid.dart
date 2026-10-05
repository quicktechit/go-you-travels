import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../provider/lead_provider.dart';

class LeadStatsGrid extends ConsumerWidget {
  const LeadStatsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechLeadProvider);
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                context: context,
                isDark: isDark,
                cardBg: cardBg,
                borderColor: borderColor,
                icon: LucideIcons.users,
                iconBg: const Color(0xFFEEF2FF),
                iconColor: const Color(0xFF4F46E5),
                badgeText: '${state.convertedPercentage}% Converted',
                valueText: '${state.totalLeadsCount}',
                labelText: 'Total Leads',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildMetricCard(
                context: context,
                isDark: isDark,
                cardBg: cardBg,
                borderColor: borderColor,
                icon: LucideIcons.userPlus,
                iconBg: const Color(0xFFEFF6FF),
                iconColor: AppColors.primary,
                badgeText: 'Action Needed',
                valueText: '${state.newInquiriesCount}',
                labelText: 'New Inquiries',
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                context: context,
                isDark: isDark,
                cardBg: cardBg,
                borderColor: borderColor,
                icon: LucideIcons.clock,
                iconBg: const Color(0xFFFFF7ED),
                iconColor: const Color(0xFFEA580C),
                badgeText: "Today's Queue",
                valueText: '${state.followUpsDueCount}',
                labelText: 'Follow-ups Due',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildMetricCard(
                context: context,
                isDark: isDark,
                cardBg: cardBg,
                borderColor: borderColor,
                icon: LucideIcons.flame,
                iconBg: const Color(0xFFFEF2F2),
                iconColor: const Color(0xFFDC2626),
                badgeText: 'Hot Leads',
                valueText: '${state.hotLeadsCount}',
                labelText: 'Urgent / High',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required BuildContext context,
    required bool isDark,
    required Color cardBg,
    required Color borderColor,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String badgeText,
    required String valueText,
    required String labelText,
  }) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 38.r,
                height: 38.r,
                decoration: BoxDecoration(
                  color: isDark ? iconBg.withValues(alpha: 0.2) : iconBg,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  size: 20.sp,
                  color: iconColor,
                ),
              ),
              Flexible(
                child: Text(
                  badgeText,
                  style: GoogleFonts.figtree(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textMuted,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Text(
            valueText,
            style: GoogleFonts.figtree(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
              height: 1.1,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            labelText,
            style: GoogleFonts.figtree(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

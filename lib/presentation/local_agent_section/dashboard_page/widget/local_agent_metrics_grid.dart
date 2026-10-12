import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../provider/local_agent_dashboard_provider.dart';

class LocalAgentMetricsGrid extends ConsumerWidget {
  const LocalAgentMetricsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(localAgentDashboardProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'REFERRAL & CLIENT METRICS',
          style: GoogleFonts.figtree(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.darkTextSecondary : AppColors.textMuted,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 12.h),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 1.45,
          children: [
            _buildMetricCard(
              context: context,
              isDark: isDark,
              cardBg: cardBg,
              borderColor: borderColor,
              icon: LucideIcons.users,
              iconBg: const Color(0xFFEEF2FF),
              iconColor: const Color(0xFF4F46E5),
              badgeText: 'This Month',
              valueText: '${state.totalSubmittedThisMonth}',
              labelText: 'Submitted Clients',
            ),
            _buildMetricCard(
              context: context,
              isDark: isDark,
              cardBg: cardBg,
              borderColor: borderColor,
              icon: LucideIcons.hourglass,
              iconBg: const Color(0xFFFFF7ED),
              iconColor: const Color(0xFFEA580C),
              badgeText: 'Processing',
              valueText: '${state.pendingInReview}',
              labelText: 'Pending In-Review',
            ),
            _buildMetricCard(
              context: context,
              isDark: isDark,
              cardBg: cardBg,
              borderColor: borderColor,
              icon: LucideIcons.checkCircle2,
              iconBg: const Color(0xFFECFDF5),
              iconColor: const Color(0xFF059669),
              badgeText: 'Success',
              valueText: '${state.convertedApproved}',
              labelText: 'Converted / Approved',
            ),
            _buildMetricCard(
              context: context,
              isDark: isDark,
              cardBg: cardBg,
              borderColor: borderColor,
              icon: LucideIcons.wallet,
              iconBg: const Color(0xFFEFF6FF),
              iconColor: AppColors.primary,
              badgeText: 'Earned',
              valueText: '\$${state.totalCommission.toStringAsFixed(2)}',
              labelText: 'Total Commission',
            ),
            _buildMetricCard(
              context: context,
              isDark: isDark,
              cardBg: cardBg,
              borderColor: borderColor,
              icon: LucideIcons.badgeDollarSign,
              iconBg: const Color(0xFFF0FDFA),
              iconColor: const Color(0xFF0D9488),
              badgeText: 'Transferred',
              valueText: '\$${state.paidCommission.toStringAsFixed(2)}',
              labelText: 'Paid Commission',
            ),
            _buildMetricCard(
              context: context,
              isDark: isDark,
              cardBg: cardBg,
              borderColor: borderColor,
              icon: LucideIcons.receipt,
              iconBg: const Color(0xFFFEF3C7),
              iconColor: const Color(0xFFD97706),
              badgeText: 'Awaiting Payout',
              valueText: '\$${state.pendingCommission.toStringAsFixed(2)}',
              labelText: 'Pending Commission',
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
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 32.r,
                height: 32.r,
                decoration: BoxDecoration(
                  color: isDark ? iconBg.withValues(alpha: 0.2) : iconBg,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, size: 18.sp, color: iconColor),
              ),
              Text(
                badgeText,
                style: GoogleFonts.figtree(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.textMuted,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                valueText,
                style: GoogleFonts.figtree(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                  height: 1.1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.h),
              Text(
                labelText,
                style: GoogleFonts.figtree(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../provider/lead_provider.dart';

class LeadStatsGrid extends ConsumerWidget {
  const LeadStatsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechLeadProvider);



    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                context: context,
                icon: LucideIcons.users,
                iconBg: AppColors.indigoLight,
                iconColor: AppColors.indigoAccent,
                badgeText: '${state.convertedPercentage}% Converted',
                valueText: '${state.totalLeadsCount}',
                labelText: 'Total Leads',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildMetricCard(
                context: context,
                icon: LucideIcons.userPlus,
                iconBg: AppColors.blueLight,
                iconColor: AppColors.yellow,
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
                icon: LucideIcons.clock,
                iconBg: AppColors.softOrange,
                iconColor: AppColors.orange,
                badgeText: "Today's Queue",
                valueText: '${state.followUpsDueCount}',
                labelText: 'Follow-ups Due',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildMetricCard(
                context: context,
                icon: LucideIcons.flame,
                iconBg: AppColors.redLight,
                iconColor: AppColors.red,
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
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color:  AppColors.darkTextSecondary.withAlpha(70), width: 1),
        boxShadow: [

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
                  color:  iconBg.withAlpha(200),
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
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
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
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              height: 1.1,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            labelText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,

            ),
          ),
        ],
      ),
    );
  }
}

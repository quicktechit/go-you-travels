import '../../../../core/constant/const.dart';
import '../provider/profile_provider.dart';

class OperationalPerformanceSection extends ConsumerWidget {
  const OperationalPerformanceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(quickTechProfileProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final headerTextColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final labelTextColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          "THIS MONTH'S OPERATIONAL PERFORMANCE",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: headerTextColor,
                letterSpacing: 0.6,
              ),
        ),
        SizedBox(height: 14.h),

        // 3 Column Metrics Row
        Row(
          children: [
            Expanded(
              child: _buildMetricColumn(
                context: context,
                label: 'Conversions',
                value: '${profile.monthlyConversions} Clients',
                valueColor: AppColors.primaryDark,
                labelColor: labelTextColor,
              ),
            ),
            Expanded(
              child: _buildMetricColumn(
                context: context,
                label: 'Visa Files',
                value: '${profile.activeVisaFiles} Active',
                valueColor: AppColors.secondaryDark,
                labelColor: labelTextColor,
              ),
            ),
            Expanded(
              child: _buildMetricColumn(
                context: context,
                label: 'Commission',
                value: profile.monthlyCommission,
                valueColor: AppColors.orange,
                labelColor: labelTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricColumn({
    required BuildContext context,
    required String label,
    required String value,
    required Color valueColor,
    required Color labelColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
                color: labelColor,
              ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

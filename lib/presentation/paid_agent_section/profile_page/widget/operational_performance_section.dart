import '../../../../core/constant/const.dart';
import '../provider/profile_provider.dart';

class OperationalPerformanceSection extends ConsumerWidget {
  const OperationalPerformanceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(quickTechProfileProvider);



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          "THIS MONTH'S OPERATIONAL PERFORMANCE",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w800,

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
                valueColor: AppColors.yellow,

              ),
            ),
            Expanded(
              child: _buildMetricColumn(
                context: context,
                label: 'Visa Files',
                value: '${profile.activeVisaFiles} Active',
                valueColor: AppColors.secondaryDark,

              ),
            ),
            Expanded(
              child: _buildMetricColumn(
                context: context,
                label: 'Commission',
                value: profile.monthlyCommission,
                valueColor: AppColors.orange,

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

  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,

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

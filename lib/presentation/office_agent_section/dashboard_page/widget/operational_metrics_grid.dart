import 'package:go_you_travels/presentation/home_section/quick_tech_home_page/provider/home_provider.dart';

import '../../../../core/constant/const.dart';
import '../model/quick_tech_dashboard_state.dart';
import '../provider/quick_tech_dashboard_provider.dart';

class OperationalMetricsGrid extends ConsumerWidget {
  const OperationalMetricsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechDashboardProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final titleColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.textSecondary;
    final valueColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.textPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          'OPERATIONAL TARGETS & METRICS',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: titleColor,
                letterSpacing: 0.6,
              ),
        ),
        SizedBox(height: 12.h),

        // 2-Column Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.metrics.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            mainAxisExtent: 108.h,
          ),
          itemBuilder: (context, index) {
            final item = state.metrics[index];
            return _buildMetricCard(
              context: context,
              item: item,
              cardBg: cardBg,
              borderColor: borderColor,
              titleColor: titleColor,
              valueColor: valueColor,
              isDark: isDark,
              onTap: () {
                if (index == 0) {
                  ref.read(homeProvider.notifier).setNavIndex(3);
                }
                if (index == 1) {
                  ref.read(homeProvider.notifier).setNavIndex(1);
                }
                if (index == 2) {
                  ref.read(homeProvider.notifier).setNavIndex(1);
                }
                if (index == 3) {
                  context.push(AppRoutes.followUp);
                }
                if (index == 4) {
                  ref.read(homeProvider.notifier).setNavIndex(2);
                }
                if (index == 5) {
                  context.push(AppRoutes.report);
                }
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required BuildContext context,
    required OperationalMetric item,
    required Color cardBg,
    required GestureTapCallback onTap,
    required Color borderColor,
    required Color titleColor,
    required Color valueColor,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: borderColor, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Row: Icon on left, Badge on right
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon Box
                Container(
                  padding: EdgeInsets.all(7.r),
                  decoration: BoxDecoration(
                    color: isDark
                        ? item.iconBgColor.withValues(alpha: 0.2)
                        : item.iconBgColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    item.icon,
                    size: 18.sp,
                    color: isDark ? AppColors.surface : item.iconColor,
                  ),
                ),

                // Right Top Badge
                Text(
                  item.badgeText,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                ),
              ],
            ),

            // Bottom Content: Value & Subtitle
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.value,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: valueColor,
                        height: 1.2,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: titleColor,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

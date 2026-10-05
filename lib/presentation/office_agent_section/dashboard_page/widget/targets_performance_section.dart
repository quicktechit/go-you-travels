import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../model/quick_tech_dashboard_state.dart';
import '../provider/quick_tech_dashboard_provider.dart';

class TargetsPerformanceSection extends ConsumerWidget {
  const TargetsPerformanceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechDashboardProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final titleColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final mainTextColor = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header: Title & View Reports
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'TARGETS & PERFORMANCE',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: titleColor,
                    letterSpacing: 0.6,
                  ),
            ),
            GestureDetector(
              onTap: () {
                context.push(AppRoutes.report);
              },
              child: Text(
                'View Reports',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // List of Target Cards
        Column(
          children: state.targets.map((target) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _buildTargetCard(
                context: context,
                target: target,
                cardBg: cardBg,
                borderColor: borderColor,
                titleColor: titleColor,
                mainTextColor: mainTextColor,
                isDark: isDark,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTargetCard({
    required BuildContext context,
    required TargetPerformance target,
    required Color cardBg,
    required Color borderColor,
    required Color titleColor,
    required Color mainTextColor,
    required bool isDark,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
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
        children: [
          // Top Row: Title & Daily Tag
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                target.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: mainTextColor,
                    ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurfaceHigh : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  target.badge,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w600,
                        color: titleColor,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // Values Row: e.g. "7 / 10 Leads" and "70%"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${target.current} / ${target.total} ${target.unit}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
              ),
              Text(
                '${target.percentage.toInt()}%',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: target.percentage / 100,
              minHeight: 7.h,
              backgroundColor: isDark ? AppColors.darkSurfaceHigh : AppColors.line,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          ),

          // Optional Warning Message
          if (target.warningMessage != null) ...[
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(
                  LucideIcons.triangleAlert,
                  size: 15.sp,
                  color: const Color(0xFFD97706), // Amber warning
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    target.warningMessage!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFD97706),
                        ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

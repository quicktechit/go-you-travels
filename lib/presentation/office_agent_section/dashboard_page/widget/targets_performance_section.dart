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

    final cardBg = isDark ? AppColors.darkSurface : Colors.white;
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
              style: GoogleFonts.figtree(
                fontSize: 12.sp,
                fontWeight: FontWeight.w800,
                color: titleColor,
                letterSpacing: 0.6,
              ),
            ),
            GestureDetector(
              onTap: () {
                ref.read(quickTechDashboardProvider.notifier).viewReports();
              },
              child: Text(
                'View Reports',
                style: GoogleFonts.figtree(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1D4ED8),
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
                style: GoogleFonts.figtree(
                  fontSize: 15.sp,
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
                  style: GoogleFonts.figtree(
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
                style: GoogleFonts.figtree(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1D4ED8),
                ),
              ),
              Text(
                '${target.percentage.toInt()}%',
                style: GoogleFonts.figtree(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF10B981), // Emerald Green
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
              backgroundColor: isDark ? AppColors.darkSurfaceHigh : const Color(0xFFE2E8F0),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
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
                    style: GoogleFonts.figtree(
                      fontSize: 12.sp,
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

import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../model/quick_tech_dashboard_state.dart';
import '../provider/quick_tech_dashboard_provider.dart';

class ScheduledFollowupsSection extends ConsumerWidget {
  const ScheduledFollowupsSection({super.key});

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
        // Section Header: Title & See All (4)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "TODAY'S SCHEDULED FOLLOW-UPS",
              style: GoogleFonts.figtree(
                fontSize: 12.sp,
                fontWeight: FontWeight.w800,
                color: titleColor,
                letterSpacing: 0.6,
              ),
            ),
            GestureDetector(
              onTap: () {
                ref
                    .read(quickTechDashboardProvider.notifier)
                    .seeAllFollowUps();
              },
              child: Text(
                'See All (4)',
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

        // List of Scheduled Follow-Up Cards
        Column(
          children: state.followUps.map((item) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _buildFollowUpCard(
                item: item,
                cardBg: cardBg,
                borderColor: borderColor,
                titleColor: titleColor,
                mainTextColor: mainTextColor,
                isDark: isDark,
                ref: ref,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFollowUpCard({
    required ScheduledFollowUp item,
    required Color cardBg,
    required Color borderColor,
    required Color titleColor,
    required Color mainTextColor,
    required bool isDark,
    required WidgetRef ref,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name & Time Badge
                Row(
                  children: [
                    Text(
                      item.name,
                      style: GoogleFonts.figtree(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: mainTextColor,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7ED), // Soft orange tag
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: const Color(0xFFFFEDD5)),
                      ),
                      child: Text(
                        item.time,
                        style: GoogleFonts.figtree(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFC2410C),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),

                // Subtitle Line (Category & Phone)
                Text(
                  '${item.category} · ${item.phone}',
                  style: GoogleFonts.figtree(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w500,
                    color: titleColor,
                  ),
                ),
                SizedBox(height: 6.h),

                // Note
                Text(
                  item.note,
                  style: GoogleFonts.figtree(
                    fontSize: 12.sp,
                    color: titleColor.withValues(alpha: 0.85),
                    fontStyle: FontStyle.normal,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),

          // Right Phone Call Button
          InkWell(
            onTap: () {
              ref
                  .read(quickTechDashboardProvider.notifier)
                  .callFollowUp(item);
            },
            borderRadius: BorderRadius.circular(24.r),
            child: Container(
              width: 44.r,
              height: 44.r,
              decoration: const BoxDecoration(
                color: Color(0xFF1E40AF), // Dark Royal Blue
                shape: BoxShape.circle,
              ),
              child: Icon(
                LucideIcons.phone,
                size: 20.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

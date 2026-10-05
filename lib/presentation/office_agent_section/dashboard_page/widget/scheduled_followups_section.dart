import 'package:go_you_travels/presentation/office_agent_section/lead_page/model/lead_model.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constant/const.dart';
import '../../lead_page/widget/call_log_modal.dart';
import '../model/quick_tech_dashboard_state.dart';
import '../provider/quick_tech_dashboard_provider.dart';

class ScheduledFollowupsSection extends ConsumerWidget {
  const ScheduledFollowupsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechDashboardProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final titleColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.textSecondary;
    final mainTextColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.textPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header: Title & See All (4)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "TODAY'S SCHEDULED FOLLOW-UPS",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: titleColor,
                    letterSpacing: 0.6,
                  ),
            ),
            GestureDetector(
              onTap: () {
                context.push(AppRoutes.followUp);
              },
              child: Text(
                'See All (4)',
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

        // List of Scheduled Follow-Up Cards
        Column(
          children: state.followUps.map((item) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _buildFollowUpCard(
                context: context,
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
    required BuildContext context,
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
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w500,
                        color: titleColor,
                      ),
                ),
                SizedBox(height: 6.h),

                // Note
                Text(
                  item.note,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: titleColor.withValues(alpha: 0.85),
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
              CallLogModal.show(
                context,
                lead: LeadItem(
                  id: '1',
                  name: item.name,
                  phone: item.phone,
                  destinationCountry: '',
                  visaInterest: '',
                  leadSource: '',
                  status: LeadStatus.followUp,
                  priority: LeadPriority.high,
                  createdAt: DateTime.now(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(24.r),
            child: Container(
              width: 44.r,
              height: 44.r,
              decoration: const BoxDecoration(
                color: AppColors.primaryDark,
                shape: BoxShape.circle,
              ),
              child: Icon(LucideIcons.phone, size: 20.sp, color: AppColors.surface),
            ),
          ),
        ],
      ),
    );
  }
}

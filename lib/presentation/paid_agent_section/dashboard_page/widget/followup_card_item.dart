import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../../../../core/widgets/app_button.dart';
import '../../lead_page/model/lead_model.dart';
import '../../lead_page/widget/call_log_modal.dart';
import '../model/quick_tech_followup_model.dart';
import '../provider/quick_tech_followup_provider.dart';

class FollowupCardItem extends ConsumerWidget {
  final FollowupItem item;

  const FollowupCardItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(quickTechFollowupProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;



    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.darkTextSecondary.withAlpha(70), width: 1.w),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Name & Time Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(

                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkBrown : AppColors.softOrange,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isDark ? AppColors.darkBrownBorder : AppColors.softOrangeBorder,
                  ),
                ),
                child: Text(
                  item.timeTag,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.lightOrangeText : AppColors.warningOrange,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // Sub-line: Phone · Visa Category
          Text(
            '${item.phone} · ${item.visaType}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,

                ),
          ),
          SizedBox(height: 8.h),

          // Notes
          Text(
            'Notes: ${item.notes}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w400,

                  height: 1.35,
                ),
          ),
          SizedBox(height: 14.h),

          // Horizontal Divider
          Divider(
            height: 1.h,
            color: isDark ? AppColors.darkLine : AppColors.line,
          ),
          SizedBox(height: 12.h),

          // Bottom Row: Assigned Agent & Buttons
          Row(
            children: [
              Expanded(
                child: Text(
                  'Assigned: ${item.assignedAgent}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,

                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),

              // Mark Done Button
              AppButton(
                width: 90.w,
                text: item.isDone ? 'Done' : 'Mark Done',
                icon: item.isDone ? LucideIcons.checkCheck : LucideIcons.check,
                variant: AppButtonVariant.outlined,
                onPressed: () => notifier.markDone(item.id),
                height: 36.h,
                fontSize: 10.sp,
                horizontalPadding: 10.w,
                color: AppColors.primary,
                textColor: AppColors.primary,
              ),
              SizedBox(width: 8.w),

              // Call Now Button
              AppButton(
                width: 90.w,
                text: 'Call Now',
                icon: LucideIcons.phone,
                variant: AppButtonVariant.primary,
                onPressed: () => CallLogModal.show(
                  context,
                  lead: LeadItem(
                    id: item.id,
                    name: item.name,
                    phone: item.phone,
                    destinationCountry: '',
                    visaInterest: '',
                    leadSource: '',
                    status: LeadStatus.followUp,
                    priority: LeadPriority.high,
                    createdAt: DateTime.now(),
                  ),
                ),
                height: 36.h,
                fontSize: 10.sp,
                horizontalPadding: 12.w,
                backgroundColor: AppColors.yellow,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

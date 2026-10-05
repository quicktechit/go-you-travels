import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constant/const.dart';
import '../../lead_page/widget/create_lead_modal.dart';

class DailyWorkflowBanner extends ConsumerWidget {
  const DailyWorkflowBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColors.primaryDark, // Rich Royal Blue
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.25),
            blurRadius: 12,
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
                Text(
                  'Daily Workflow Active',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.surface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '14/20 calls done · 6 follow-ups remaining',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.surface.withValues(alpha: 0.88),
                    fontSize: 12.5.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),

          // Right Button "+ New Lead"
          Flexible(
            child: AppButton(
              text: 'New Lead',
              icon: LucideIcons.plus,
              onPressed: () => CreateLeadModal.show(context),
            
              height: 38.h,
              fontSize: 13.5.sp,
              horizontalPadding: 14.w,
            ),
          ),
        ],
      ),
    );
  }
}

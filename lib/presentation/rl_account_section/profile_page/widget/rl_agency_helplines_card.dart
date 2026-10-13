import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constant/const.dart';

class RlAgencyHelplinesCard extends ConsumerWidget {
  const RlAgencyHelplinesCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textTheme = Theme.of(context).textTheme;


    return InkWell(
      onTap: () {
        Fluttertoast.showToast(
            msg: "Opening Agency Helplines & Embassy Contacts");
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.darkTextSecondary.withAlpha(70)
              , width: 1.w),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                LucideIcons.contact,
                size: 20.sp,
                color: AppColors.surface,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Agency Helplines & Embassy Contacts',
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Direct access to Canada VFS, Saudi MoFA & UKVI',
                    style: textTheme.bodySmall?.copyWith(

                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              LucideIcons.chevronRight,
              size: 20.sp,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

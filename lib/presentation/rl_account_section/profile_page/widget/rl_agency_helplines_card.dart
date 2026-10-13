import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constant/const.dart';

class RlAgencyHelplinesCard extends ConsumerWidget {
  const RlAgencyHelplinesCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textTheme = Theme.of(context).textTheme;
    final bg = isDark
        ? AppColors.primaryDark.withValues(alpha: 0.25)
        : AppColors.blueLight;
    final borderColor = isDark
        ? AppColors.primary
        : AppColors.line;
    final primaryText = isDark
        ? AppColors.darkTextPrimary
        : AppColors.primaryDark;
    final secondaryText = isDark
        ? AppColors.darkTextSecondary
        : AppColors.textSecondary;

    return InkWell(
      onTap: () {
        Fluttertoast.showToast(
            msg: "Opening Agency Helplines & Embassy Contacts");
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: borderColor, width: 1.w),
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
                      color: primaryText,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Direct access to Canada VFS, Saudi MoFA & UKVI',
                    style: textTheme.bodySmall?.copyWith(
                      color: secondaryText,
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

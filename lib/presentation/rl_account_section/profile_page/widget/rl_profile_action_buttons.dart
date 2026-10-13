import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constant/const.dart';

class RlProfileActionButtons extends ConsumerWidget {
  const RlProfileActionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        // Logout Session Button
        InkWell(
          onTap: () {
            context.go(AppRoutes.login);
            Fluttertoast.showToast(msg: "Session Logged Out");
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LucideIcons.logOut,
                  size: 18.sp,
                  color: AppColors.surface,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Logout Session',
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.surface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

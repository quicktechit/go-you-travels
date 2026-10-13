import '../../../../core/constant/const.dart';
import '../provider/team_provider.dart';

class MyTeamCardBanner extends ConsumerWidget {
  const MyTeamCardBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamList = ref.watch(paidAgentTeamProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        context.push(AppRoutes.paidAgentMyTeam);
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.darkBrown.withValues(alpha: 0.3)
              : AppColors.softOrange,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isDark ? AppColors.yellow : AppColors.line,
            width: 1.w,
          ),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          children: [
            // Icon Badge
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColors.yellow,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                LucideIcons.users,
                size: 22.sp,
                color: AppColors.surface,
              ),
            ),
            SizedBox(width: 14.w),

            // Text Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'My Team',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.yellow.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          '${teamList.length} Members',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.amber : AppColors.orange,
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'View campaign team & give performance ratings',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.textSecondary,
                          fontSize: 11.5.sp,
                        ),
                  ),
                ],
              ),
            ),

            // Chevron Right
            Icon(
              LucideIcons.chevronRight,
              size: 20.sp,
              color: AppColors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}

import '../../../../core/constant/const.dart';
import '../provider/local_agent_team_provider.dart';

class LocalAgentMyTeamCardBanner extends ConsumerWidget {
  const LocalAgentMyTeamCardBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamList = ref.watch(localAgentTeamProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        context.push(AppRoutes.localAgentMyTeam);
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.secondaryDark.withValues(alpha: 0.3)
              : AppColors.secondaryLight,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isDark ? AppColors.secondary : AppColors.line,
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
                color: AppColors.secondary,
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
                          color: AppColors.secondary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          '${teamList.length} Partners',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? AppColors.secondaryLight
                                    : AppColors.secondaryDark,
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'View regional hub partners & give ratings',
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
              color: isDark
                  ? AppColors.secondaryLight
                  : AppColors.secondaryDark,
            ),
          ],
        ),
      ),
    );
  }
}

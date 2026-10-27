import '../../../../core/constant/const.dart';
import '../model/team_member_model.dart';
import '../provider/team_provider.dart';

class MyTeamCardBanner extends ConsumerWidget {
  final TeamAgentType agentType;

  const MyTeamCardBanner({
    super.key,
    this.agentType = TeamAgentType.office,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTeam = ref.watch(teamProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final teamList = allTeam.where((m) => m.agentType == agentType).toList();

    Color accentColor;
    Color bgColor;
    String route;
    String subtitleText;

    switch (agentType) {
      case TeamAgentType.office:
        accentColor = AppColors.primaryDark;
        bgColor = isDark
            ? AppColors.primaryDark.withValues(alpha: 0.3)
            : AppColors.primaryLight.withValues(alpha: 0.15);
        route = AppRoutes.officeAgentMyTeam;
        subtitleText = 'View office consultants & give ratings';
        break;
      case TeamAgentType.paid:
        accentColor = AppColors.yellow;
        bgColor = isDark
            ? AppColors.darkBrown.withValues(alpha: 0.3)
            : AppColors.softOrange;
        route = AppRoutes.paidAgentMyTeam;
        subtitleText = 'View campaign team & give performance ratings';
        break;
      case TeamAgentType.local:
        accentColor = AppColors.secondary;
        bgColor = isDark
            ? AppColors.secondaryDark.withValues(alpha: 0.3)
            : AppColors.secondaryLight;
        route = AppRoutes.localAgentMyTeam;
        subtitleText = 'View regional hub partners & give ratings';
        break;
    }

    return InkWell(
      onTap: () {
        context.push(route);
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isDark ? accentColor : AppColors.line,
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
                color: accentColor,
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
                          color: accentColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          '${teamList.length} Members',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.bold,
                                color: isDark ? accentColor : accentColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    subtitleText,
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
              color: accentColor,
            ),
          ],
        ),
      ),
    );
  }
}

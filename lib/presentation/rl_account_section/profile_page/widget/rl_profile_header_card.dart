import '../../../../core/constant/const.dart';
import '../provider/rl_account_profile_provider.dart';

class RlProfileHeaderCard extends ConsumerWidget {
  const RlProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(rlAccountProfileProvider);
    final notifier = ref.read(rlAccountProfileProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textTheme = Theme.of(context).textTheme;


    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.darkTextSecondary.withAlpha(70), width: 1.w),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        children: [
          // Circular Avatar with Letter 'H'
          CircleAvatar(
            radius: 38.r,
            backgroundColor: AppColors.primaryDark,
            child: Text(
              profile.name.isNotEmpty ? profile.name[0] : 'H',
              style: textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.surface,
              ),
            ),
          ),
          SizedBox(height: 14.h),

          // Name & Account Title
          Text(
            '${profile.name} ${profile.accountTitle}',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,

            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 6.h),

          // Code & Department Subtitle
          Text(
            profile.subTitle,
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,

            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 14.h),

          // Role Badge Pill
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.purpleAccent.withValues(alpha: 0.2)
                      : AppColors.indigoLight,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  profile.roleBadge,
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.purpleAccent,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Divider
          Divider(
            height: 1.h,
            color: isDark ? AppColors.darkLine : AppColors.line,
          ),
          SizedBox(height: 12.h),

          // Duty Switch Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 9.r,
                    height: 9.r,
                    decoration: BoxDecoration(
                      color: profile.isOnDuty
                          ? AppColors.successEmerald // Green
                          : AppColors.red, // Red
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    profile.isOnDuty ? 'On Duty' : 'Off Duty',
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ],
              ),
              Switch.adaptive(
                value: profile.isOnDuty,
                activeTrackColor: AppColors.primaryDark,
                onChanged: (_) => notifier.toggleDutyStatus(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

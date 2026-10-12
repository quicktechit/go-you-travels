import '../../../../core/constant/const.dart';
import '../provider/local_agent_profile_provider.dart';

class LocalAgentProfileHeaderCard extends ConsumerWidget {
  const LocalAgentProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(localAgentProfileProvider);
    final notifier = ref.read(localAgentProfileProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final primaryText = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: borderColor, width: 1.w),
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
        children: [
          // Circular Avatar with Letter 'K'
          CircleAvatar(
            radius: 38.r,
            backgroundColor: AppColors.primary,
            child: Text(
              profile.name.isNotEmpty ? profile.name[0] : 'K',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.surface,
                  ),
            ),
          ),
          SizedBox(height: 14.h),

          // Name & Designation
          Text(
            '${profile.name} (${profile.designation})',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryText,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),

          // Regional Franchise & Referral Partner Subtitle
          Text(
            profile.partnerTitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6.h),

          // GYT-PRT-2819 · Sylhet Regional Hub (Chowhatta)
          Text(
            '${profile.partnerId} · ${profile.hubLocation}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: secondaryText,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),

          // Local Agent & 4.95 Rating Badges Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.teal.withValues(alpha: 0.3) : AppColors.teal.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  profile.roleBadge,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.tealLight : AppColors.tealDark,
                      ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurfaceHigh : AppColors.amber.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('⭐', style: TextStyle(fontSize: 12.sp)),
                    SizedBox(width: 4.w),
                    Text(
                      '${profile.rating} Rating',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.amber : AppColors.orange,
                          ),
                    ),
                  ],
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
                          ? AppColors.emerald
                          : const Color(0xFFDC2626),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    profile.isOnDuty ? 'On Duty' : 'Off Duty',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: primaryText,
                        ),
                  ),
                ],
              ),
              Switch.adaptive(
                value: profile.isOnDuty,
                activeTrackColor: AppColors.primary,
                onChanged: (_) => notifier.toggleDutyStatus(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

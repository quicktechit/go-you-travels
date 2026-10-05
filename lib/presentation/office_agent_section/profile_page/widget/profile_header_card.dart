import '../../../../core/constant/const.dart';
import '../provider/profile_provider.dart';

class ProfileHeaderCard extends ConsumerWidget {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(quickTechProfileProvider);
    final notifier = ref.read(quickTechProfileProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final primaryText = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
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
          // Circular Avatar with Letter
          CircleAvatar(
            radius: 38.r,
            backgroundColor: AppColors.primaryDark,
            child: Text(
              profile.name.isNotEmpty ? profile.name[0] : 'T',
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

          // Counselor Subtitle
          Text(
            profile.counselorTitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6.h),

          // EMP ID & Location
          Text(
            '${profile.empId} · ${profile.officeLocation}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: secondaryText,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),

          // Role Badge & Rating Pills Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.primaryDark.withValues(alpha: 0.3) : AppColors.primaryLight.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  profile.roleBadge,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
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
                    Text(
                      '⭐',
                      style: TextStyle(fontSize: 12.sp),
                    ),
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
                          ? const Color(0xFF047857) // Green
                          : const Color(0xFFDC2626), // Red
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

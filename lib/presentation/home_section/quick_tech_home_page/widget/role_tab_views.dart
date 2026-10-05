import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../provider/home_provider.dart';

class ComingSoonView extends ConsumerWidget {
  final String title;
  final IconData icon;

  const ComingSoonView({
    super.key,
    required this.title,
    this.icon = LucideIcons.sparkles,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon Container
              Container(
                padding: EdgeInsets.all(24.r),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    width: 2.w,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 48.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 24.h),

              // Title
              Text(
                '$title Section',
                style: GoogleFonts.figtree(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),

              // Badge Tag
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7), // Light amber
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.construction,
                      size: 14.sp,
                      color: const Color(0xFFD97706),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'COMING SOON',
                      style: GoogleFonts.figtree(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFFD97706),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Subtitle
              Text(
                'We are currently perfecting the $title section module. Full functionality will be available in the upcoming release.',
                style: GoogleFonts.figtree(
                  fontSize: 13.5.sp,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),

              // Back to Dashboard Action Button
              SizedBox(
                width: 200.w,
                child: AppButton(
                  text: 'Back to Dashboard',
                  icon: LucideIcons.layoutGrid,
                  backgroundColor: AppColors.primary,
                  height: 48.h,
                  fontSize: 14.sp,
                  onPressed: () {
                    ref.read(homeProvider.notifier).setNavIndex(0);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Profile View with Sign Out
class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              CircleAvatar(
                radius: 42.r,
                backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                child: Icon(
                  LucideIcons.user,
                  size: 42.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Travel Agent Account',
                style: GoogleFonts.figtree(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'agent@goyoutravels.com',
                style: GoogleFonts.figtree(
                  fontSize: 13.sp,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 32.h),

              // Account Options
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isDark ? AppColors.darkLine : AppColors.line,
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(LucideIcons.shieldCheck, color: AppColors.primary, size: 20.sp),
                      title: Text('Security & Credentials', style: GoogleFonts.figtree(fontWeight: FontWeight.w600)),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    ),
                    Divider(height: 1, color: isDark ? AppColors.darkLine : AppColors.line),
                    ListTile(
                      leading: Icon(LucideIcons.bell, color: AppColors.primary, size: 20.sp),
                      title: Text('Notification Preferences', style: GoogleFonts.figtree(fontWeight: FontWeight.w600)),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Sign Out Button
              AppButton(
                text: 'Sign Out',
                variant: AppButtonVariant.outlined,
                color: Colors.red,
                icon: LucideIcons.logOut,
                onPressed: () {
                  context.go(AppRoutes.login);
                },
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}

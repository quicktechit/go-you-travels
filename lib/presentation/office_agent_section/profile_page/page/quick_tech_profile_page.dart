import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../widget/operational_performance_section.dart';
import '../widget/preference_settings_card.dart';
import '../widget/profile_header_card.dart';

class QuickTechProfilePage extends ConsumerWidget {
  const QuickTechProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Profile',
        subtitle: 'Go You Travels',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 80.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Profile Header User Card
              const ProfileHeaderCard(),
              SizedBox(height: 20.h),

              // 2. Operational Performance Stats
              const OperationalPerformanceSection(),
              SizedBox(height: 20.h),

              // 3. Language & Display Preference Settings Card
              const PreferenceSettingsCard(),
              SizedBox(height: 16.h),

              // 4. Agency Helplines & Embassy Contacts Banner
              InkWell(
                onTap: () {
                  Fluttertoast.showToast(msg: "Opening Agency Helplines & Embassy Contacts");
                },
                borderRadius: BorderRadius.circular(14.r),
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.primaryDark.withValues(alpha: 0.3) : AppColors.primaryLight.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: isDark ? AppColors.primary : AppColors.line,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: AppColors.primaryDark,
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
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? AppColors.surface : AppColors.primaryDark,
                                  ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Direct access to Canada VFS, Saudi MoFA & UKVI',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        LucideIcons.chevronRight,
                        size: 20.sp,
                        color: AppColors.primaryDark,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // 5. Logout Session Button
              AppButton(
                onPressed: () {
                  context.go(AppRoutes.login);
                  Fluttertoast.showToast(msg: "Session Logged Out");
                },
                text: 'Logout Session',
                backgroundColor: AppColors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

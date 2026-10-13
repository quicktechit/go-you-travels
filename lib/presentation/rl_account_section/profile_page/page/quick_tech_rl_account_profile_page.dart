import '../../../../core/constant/const.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../widget/rl_agency_helplines_card.dart';
import '../widget/rl_preference_settings_card.dart';
import '../widget/rl_profile_header_card.dart';

class QuickTechRlAccountProfilePage extends ConsumerWidget {
  const QuickTechRlAccountProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.background,
      appBar: const CustomAppbar(
        title: 'Profile',
        subtitle: 'Go You Travels',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 90.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. User Profile Header Card
              const RlProfileHeaderCard(),
              SizedBox(height: 20.h),

              // 2. Language & Display Preference Settings Card
              const RlPreferenceSettingsCard(),
              SizedBox(height: 16.h),

              // 3. Agency Helplines & Embassy Contacts Banner
              const RlAgencyHelplinesCard(),
              SizedBox(height: 16.h),

              // 4. Logout Session Action Button
              AppButton(text: 'Session Logged Out',
                backgroundColor: AppColors.red,
                textColor: AppColors.background,
                icon:    LucideIcons.logOut,
                onPressed: (){
                context.go(AppRoutes.login);
                Fluttertoast.showToast(msg: "Session Logged Out");
              },)
            ],
          ),
        ),
      ),
    );
  }
}

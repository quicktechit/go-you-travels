import '../../../../core/constant/const.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../my_team_section/model/team_member_model.dart';
import '../../../my_team_section/widget/my_team_card_banner.dart';
import '../widget/local_agent_operational_performance.dart';
import '../widget/local_agent_preference_settings.dart';
import '../widget/local_agent_profile_header_card.dart';

class QuickTechLocalAgentProfilePage extends ConsumerWidget {
  const QuickTechLocalAgentProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
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
              // 1. Profile Header Card
              const LocalAgentProfileHeaderCard(),
              SizedBox(height: 20.h),

              // 2. Operational Performance Stats
              const LocalAgentOperationalPerformance(),
              SizedBox(height: 20.h),

              // 3. Language & Display Preference Settings Card
              const LocalAgentPreferenceSettings(),
              SizedBox(height: 20.h),

              // 4. My Team Banner Card (Routes to My Team Page)
              const MyTeamCardBanner(agentType: TeamAgentType.local),
              SizedBox(height: 20.h),

              // 4. Logout Session Button
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

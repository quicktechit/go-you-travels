import '../../../../core/constant/const.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../model/team_member_model.dart';
import '../widget/my_team_section.dart';

class QuickTechMyTeamPage extends ConsumerWidget {
  final TeamAgentType? agentType;

  const QuickTechMyTeamPage({
    super.key,
    this.agentType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    String subtitleText;
    switch (agentType) {
      case TeamAgentType.office:
        subtitleText = 'Office Consultants & Ratings';
        break;
      case TeamAgentType.paid:
        subtitleText = 'Paid Campaign Team & Ratings';
        break;
      case TeamAgentType.local:
        subtitleText = 'Regional Partners & Ratings';
        break;
      case null:
        subtitleText = 'All Agency Teams & Ratings';
        break;
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: CustomAppbar(
        title: 'My Team',
        subtitle: subtitleText,
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
          physics: const BouncingScrollPhysics(),
          child: MyTeamSection(initialAgentType: agentType),
        ),
      ),
    );
  }
}

import '../../../../core/constant/const.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../widget/my_team_section.dart';

class QuickTechOfficeAgentMyTeamPage extends ConsumerWidget {
  const QuickTechOfficeAgentMyTeamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: const CustomAppbar(
        title: 'My Team',
        subtitle: 'Office Consultants & Ratings',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
          physics: const BouncingScrollPhysics(),
          child: const MyTeamSection(),
        ),
      ),
    );
  }
}

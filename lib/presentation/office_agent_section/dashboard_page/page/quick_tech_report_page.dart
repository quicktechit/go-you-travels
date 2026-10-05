import '../../../../core/constant/const.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../model/quick_tech_report_model.dart';
import '../provider/quick_tech_report_provider.dart';
import '../widget/report_cards.dart';
import '../widget/report_filter_chips.dart';

class QuickTechReportPage extends ConsumerWidget {
  const QuickTechReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechReportProvider);

    Widget buildCardForTab() {
      switch (state.selectedTab) {
        case ReportTabFilter.sales:
          return const SalesReportCard();
        case ReportTabFilter.leadsFunnel:
          return const FunnelReportCard();
        case ReportTabFilter.calling:
          return const CallingReportCard();
        case ReportTabFilter.targets:
          return const TargetsReportCard();
        case ReportTabFilter.commissions:
          return const CommissionsReportCard();
        case ReportTabFilter.accounts:
          return const AccountsReportCard();
      }
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Reports',
        subtitle: 'Go You Travels',
        showBackButton: true,
        onBackTap: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go(AppRoutes.home);
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Horizontal Report Category Chips
              const ReportFilterChips(),
              SizedBox(height: 16.h),

              // 2. Active Report Card
              buildCardForTab(),
            ],
          ),
        ),
      ),
    );
  }
}

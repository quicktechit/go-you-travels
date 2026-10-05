import '../../../../core/constant/const.dart';
import '../widget/daily_workflow_banner.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../widget/operational_metrics_grid.dart';
import '../widget/scheduled_followups_section.dart';
import '../widget/targets_performance_section.dart';

class QuickTechDashboardPage extends ConsumerWidget {
  const QuickTechDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 90.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Daily Workflow Active Banner
              const DailyWorkflowBanner(),
              SizedBox(height: 20.h),

              // 2. Operational Targets & Metrics Grid
              const OperationalMetricsGrid(),
              SizedBox(height: 20.h),

              // 3. Targets & Performance Section
              const TargetsPerformanceSection(),
              SizedBox(height: 20.h),

              // 4. Today's Scheduled Follow-ups Section
              const ScheduledFollowupsSection(),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}

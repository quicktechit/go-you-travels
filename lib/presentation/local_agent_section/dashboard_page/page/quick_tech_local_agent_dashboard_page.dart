import '../../../../core/constant/const.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../provider/local_agent_dashboard_provider.dart';
import '../widget/local_agent_banner.dart';
import '../widget/local_agent_client_card_item.dart';
import '../widget/local_agent_metrics_grid.dart';

class QuickTechLocalAgentDashboardPage extends ConsumerWidget {
  const QuickTechLocalAgentDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(localAgentDashboardProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: const CustomAppbar(
        title: 'Local Agent Dashboard',
        subtitle: 'Go You Travels',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 90.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Local Partner Portal Banner with Submit Client Button
              const LocalAgentBanner(),
              SizedBox(height: 20.h),

              // 2. Referral & Client Metrics Grid
              const LocalAgentMetricsGrid(),
              SizedBox(height: 24.h),

              // 3. My Submitted Clients & Visa Status Section Header
              Text(
                'MY SUBMITTED CLIENTS & VISA STATUS',
                style: GoogleFonts.figtree(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.textMuted,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 12.h),

              // 4. List of Submitted Clients
              if (state.submittedClients.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Text(
                      'No submitted clients yet.',
                      style: GoogleFonts.figtree(
                        fontSize: 14.sp,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                      ),
                    ),
                  ),
                )
              else
                ...state.submittedClients.map(
                  (client) => LocalAgentClientCardItem(client: client),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import '../core/constant/const.dart';
import '../presentation/auth_section/login_page/page/quick_tech_login_page.dart';
import '../presentation/auth_section/register_page/page/quick_tech_register_page.dart';
import '../presentation/home_section/quick_tech_home_page/page/quick_tech_home_page.dart';
import '../presentation/my_team_section/model/team_member_model.dart';
import '../presentation/my_team_section/page/quick_tech_my_team_page.dart';
import '../presentation/notification_page/page/quick_tech_notification_page.dart';
import '../presentation/office_agent_section/dashboard_page/page/quick_tech_office_agent_dashboard_page.dart';
import '../presentation/office_agent_section/dashboard_page/page/quick_tech_office_agent_followup_page.dart';
import '../presentation/office_agent_section/dashboard_page/page/quick_tech_office_agent_report_page.dart';
import '../presentation/paid_agent_section/dashboard_page/page/quick_tech_paid_agent_dashboard_page.dart';
import '../presentation/paid_agent_section/follow_up_page/page/quick_tech_paid_agent_followup_page.dart';
import '../presentation/paid_agent_section/report_page/page/quick_tech_paid_agent_report_page.dart';
import '../presentation/splash_page/quick_tech_splash_page.dart';


class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String officeAgentDashboard = '/office-agent-dashboard';
  static const String officeAgentFollowUp = '/office-agent-follow-up';
  static const String officeAgentReport = '/office-agent-report';
  static const String paidAgentDashboard = '/paid-agent-dashboard';
  static const String paidAgentFollowUp = '/paid-agent-follow-up';
  static const String paidAgentReport = '/paid-agent-report';
  static const String officeAgentMyTeam = '/office-agent-my-team';
  static const String paidAgentMyTeam = '/paid-agent-my-team';
  static const String localAgentMyTeam = '/local-agent-my-team';
  static const String myTeam = '/my-team';
  static const String notification = '/notification';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const QuickTechSplashPage(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const QuickTechLoginPage(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const QuickTechRegisterPage(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const QuickTechHomePage(),
      ),
      GoRoute(
        path: officeAgentDashboard,
        builder: (context, state) =>
        const QuickTechOfficeAgentDashboardPage(),
      ),
      GoRoute(
        path: officeAgentFollowUp,
        builder: (context, state) =>
        const QuickTechOfficeAgentFollowupPage(),
      ),
      GoRoute(
        path: officeAgentReport,
        builder: (context, state) =>
        const QuickTechOfficeAgentReportPage(),
      ),
      GoRoute(
        path: paidAgentDashboard,
        builder: (context, state) =>
        const QuickTechPaidAgentDashboardPage(),
      ),
      GoRoute(
        path: paidAgentFollowUp,
        builder: (context, state) =>
        const QuickTechPaidAgentFollowupPage(),
      ),
      GoRoute(
        path: paidAgentReport,
        builder: (context, state) =>
        const QuickTechPaidAgentReportPage(),
      ),
      GoRoute(
        path: officeAgentMyTeam,
        builder: (context, state) =>
        const QuickTechMyTeamPage(agentType: TeamAgentType.office),
      ),
      GoRoute(
        path: paidAgentMyTeam,
        builder: (context, state) =>
        const QuickTechMyTeamPage(agentType: TeamAgentType.paid),
      ),
      GoRoute(
        path: localAgentMyTeam,
        builder: (context, state) =>
        const QuickTechMyTeamPage(agentType: TeamAgentType.local),
      ),
      GoRoute(
        path: myTeam,
        builder: (context, state) =>
        const QuickTechMyTeamPage(),
      ),
      GoRoute(
        path: notification,
        builder: (context, state) =>
        const QuickTechNotificationPage(),
      ),
    ],
  );
}

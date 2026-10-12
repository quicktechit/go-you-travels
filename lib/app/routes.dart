import '../core/constant/const.dart';
import '../presentation/home_section/quick_tech_home_page/page/quick_tech_home_page.dart';
import '../presentation/login_page/page/quick_tech_login_page.dart';
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
  static const String home = '/home';
  static const String officeAgentDashboard = '/office-agent-dashboard';
  static const String officeAgentFollowUp = '/office-agent-follow-up';
  static const String officeAgentReport = '/office-agent-report';
  static const String paidAgentDashboard = '/paid-agent-dashboard';
  static const String paidAgentFollowUp = '/paid-agent-follow-up';
  static const String paidAgentReport = '/paid-agent-report';

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
    ],
  );
}

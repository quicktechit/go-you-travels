import '../core/constant/const.dart';
import '../presentation/home_section/quick_tech_home_page/page/quick_tech_home_page.dart';
import '../presentation/login_page/page/login_page.dart';
import '../presentation/office_agent_section/dashboard_page/page/quick_tech_dashboard_page.dart';
import '../presentation/splash_page/quick_tech_splash_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String landing = '/landing';
  static const String home = '/home';
  static const String dashboard = '/dashboard';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const QuickTechSplashPage(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const QuickTechHomePage(),
      ),
      GoRoute(
        path: dashboard,
        builder: (context, state) => const QuickTechDashboardPage(),
      ),
    ],
  );
}

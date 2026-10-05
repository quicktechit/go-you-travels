import '../../../../core/constant/const.dart';
import '../model/role_tabs_config.dart';
import '../provider/home_provider.dart';
import '../widget/home_bottom_nav.dart';

class QuickTechHomePage extends ConsumerWidget {
  const QuickTechHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final tabs = RoleTabsConfig.getTabsForRole(state.activeRole);

    final safeIndex = state.selectedNavIndex < tabs.length
        ? state.selectedNavIndex: 0;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(

            child: IndexedStack(
              index: safeIndex,
              children: tabs.map((t) => t.page).toList(),
            ),
          ),

          Positioned(
            left: 0,right: 0,bottom: 0,
            child: CleanBottomNavBar(
              tabItems: tabs,
              selectedIndex: safeIndex,
              onTap: (index) => ref.read(homeProvider.notifier).setNavIndex(index),
            ),
          ),
        ],
      ),

    );
  }
}

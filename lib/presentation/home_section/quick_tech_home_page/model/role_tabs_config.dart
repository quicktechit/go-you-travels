import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../login_page/model/user_role.dart';
import '../../../office_agent_section/dashboard_page/page/quick_tech_dashboard_page.dart';
import '../../../office_agent_section/lead_page/page/quick_tech_lead_page.dart';
import '../../../office_agent_section/profile_page/page/quick_tech_profile_page.dart';
import '../../../office_agent_section/task_page/page/quick_tech_task_page.dart';
import '../../../office_agent_section/visa_files/page/quick_tech_visa_files_page.dart';
import '../widget/role_tab_views.dart';
import 'nav_tab_item.dart';

class RoleTabsConfig {
  static List<NavTabItem> getTabsForRole(UserRole role) {
    switch (role) {
      case UserRole.officeAgent:
        return const [
          NavTabItem(
            label: 'Dashboard',
            icon: LucideIcons.layoutGrid,
            sfSymbol: 'square.grid.2x2',
            selectedSfSymbol: 'square.grid.2x2.fill',
            page: QuickTechDashboardPage(),
          ),
          NavTabItem(
            label: 'Leads',
            icon: LucideIcons.users,
            sfSymbol: 'person.2',
            selectedSfSymbol: 'person.2.fill',
            page: QuickTechLeadPage(),
          ),
          NavTabItem(
            label: 'Visa Files',
            icon: LucideIcons.folderKanban,
            sfSymbol: 'folder',
            selectedSfSymbol: 'folder.fill',
            page: QuickTechVisaFilesPage(),
          ),
          NavTabItem(
            label: 'Tasks',
            icon: LucideIcons.clipboardList,
            sfSymbol: 'checkmark.square',
            selectedSfSymbol: 'checkmark.square.fill',
            page: QuickTechTaskPage(),
          ),
          NavTabItem(
            label: 'Profile',
            icon: LucideIcons.user,
            sfSymbol: 'person.crop.circle',
            selectedSfSymbol: 'person.crop.circle.fill',
            page: QuickTechProfilePage(),
          ),
        ];

      case UserRole.localAgent:
        return const [
          NavTabItem(
            label: 'Dashboard',
            icon: LucideIcons.layoutGrid,
            sfSymbol: 'square.grid.2x2',
            selectedSfSymbol: 'square.grid.2x2.fill',
            page:  ComingSoonView(title: 'Dashboard', icon: LucideIcons.layoutGrid),
          ),
          NavTabItem(
            label: 'Submit Client',
            icon: LucideIcons.userPlus,
            sfSymbol: 'person.badge.plus',
            selectedSfSymbol: 'person.badge.plus.fill',
            page: ComingSoonView(title: 'Submit Client', icon: LucideIcons.userPlus),
          ),
          NavTabItem(
            label: 'My Clients',
            icon: LucideIcons.users,
            sfSymbol: 'person.2',
            selectedSfSymbol: 'person.2.fill',
            page: QuickTechLeadPage(),
          ),
          NavTabItem(
            label: 'Commission',
            icon: LucideIcons.dollarSign,
            sfSymbol: 'dollarsign.circle',
            selectedSfSymbol: 'dollarsign.circle.fill',
            page: ComingSoonView(title: 'Commission', icon: LucideIcons.dollarSign),
          ),
          NavTabItem(
            label: 'Profile',
            icon: LucideIcons.user,
            sfSymbol: 'person.crop.circle',
            selectedSfSymbol: 'person.crop.circle.fill',
            page: QuickTechProfilePage(),
          ),
        ];

      case UserRole.paidLeadAgent:
        return const [
          NavTabItem(
            label: 'Dashboard',
            icon: LucideIcons.layoutGrid,
            sfSymbol: 'square.grid.2x2',
            selectedSfSymbol: 'square.grid.2x2.fill',
            page:  ComingSoonView(title: 'Dashboard', icon: LucideIcons.layoutGrid),
          ),
          NavTabItem(
            label: 'Leads',
            icon: LucideIcons.users,
            sfSymbol: 'person.2',
            selectedSfSymbol: 'person.2.fill',
            page: QuickTechLeadPage(),
          ),
          NavTabItem(
            label: 'Follow Ups',
            icon: LucideIcons.phoneCall,
            sfSymbol: 'phone.arrow.up.right',
            selectedSfSymbol: 'phone.arrow.up.right.fill',
            page: ComingSoonView(title: 'Follow Ups', icon: LucideIcons.phoneCall),
          ),
          NavTabItem(
            label: 'Report',
            icon: LucideIcons.chartBar,
            sfSymbol: 'chart.bar',
            selectedSfSymbol: 'chart.bar.fill',
            page: ComingSoonView(title: 'Report', icon: LucideIcons.chartBar),
          ),
          NavTabItem(
            label: 'Profile',
            icon: LucideIcons.user,
            sfSymbol: 'person.crop.circle',
            selectedSfSymbol: 'person.crop.circle.fill',
            page: QuickTechProfilePage(),
          ),
        ];

      case UserRole.rlAccountUser:
        return const [
          NavTabItem(
            label: 'Dashboard',
            icon: LucideIcons.layoutGrid,
            sfSymbol: 'square.grid.2x2',
            selectedSfSymbol: 'square.grid.2x2.fill',
            page: QuickTechDashboardPage(),
          ),
          NavTabItem(
            label: 'Ledger',
            icon: LucideIcons.bookOpen,
            sfSymbol: 'book',
            selectedSfSymbol: 'book.fill',
            page: ComingSoonView(title: 'Ledger', icon: LucideIcons.bookOpen),
          ),
          NavTabItem(
            label: 'Financials',
            icon: LucideIcons.landmark,
            sfSymbol: 'banknote',
            selectedSfSymbol: 'banknote.fill',
            page: ComingSoonView(title: 'Financials', icon: LucideIcons.landmark),
          ),
          NavTabItem(
            label: 'Notification',
            icon: LucideIcons.bell,
            sfSymbol: 'bell',
            selectedSfSymbol: 'bell.fill',
            page: ComingSoonView(title: 'Notification', icon: LucideIcons.bell),
          ),
          NavTabItem(
            label: 'Profile',
            icon: LucideIcons.user,
            sfSymbol: 'person.crop.circle',
            selectedSfSymbol: 'person.crop.circle.fill',
            page: QuickTechProfilePage(),
          ),
        ];
    }
  }
}

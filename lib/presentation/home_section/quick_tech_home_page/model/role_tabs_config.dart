import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../local_agent_section/commission_page/page/quick_tech_local_agent_commission_page.dart';
import '../../../local_agent_section/dashboard_page/page/quick_tech_local_agent_dashboard_page.dart';
import '../../../local_agent_section/my_client_page/page/quick_tech_local_agent_my_client_page.dart';
import '../../../local_agent_section/profile_page/page/quick_tech_local_agent_profile_page.dart';
import '../../../login_page/model/user_role.dart';
import '../../../office_agent_section/dashboard_page/page/quick_tech_office_agent_dashboard_page.dart';
import '../../../office_agent_section/lead_page/page/quick_tech_office_agent_lead_page.dart';
import '../../../office_agent_section/profile_page/page/quick_tech_office_agent_profile_page.dart';
import '../../../office_agent_section/task_page/page/quick_tech_office_agent_task_page.dart';
import '../../../office_agent_section/visa_files/page/quick_tech_office_agent_visa_files_page.dart';
import '../../../paid_agent_section/dashboard_page/page/quick_tech_paid_agent_dashboard_page.dart';
import '../../../paid_agent_section/follow_up_page/page/quick_tech_paid_agent_followup_page.dart';
import '../../../paid_agent_section/lead_page/page/quick_tech_paid_agent_lead_page.dart';
import '../../../paid_agent_section/profile_page/page/quick_tech_paid_agent_profile_page.dart';
import '../../../paid_agent_section/report_page/page/quick_tech_paid_agent_report_page.dart';
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
            page: QuickTechOfficeAgentDashboardPage(),
          ),
          NavTabItem(
            label: 'Leads',
            icon: LucideIcons.users,
            sfSymbol: 'person.2',
            selectedSfSymbol: 'person.2.fill',
            page: QuickTechOfficeAgentLeadPage(),
          ),
          NavTabItem(
            label: 'Visa Files',
            icon: LucideIcons.folderKanban,
            sfSymbol: 'folder',
            selectedSfSymbol: 'folder.fill',
            page: QuickTechOfficeAgentVisaFilesPage(),
          ),
          NavTabItem(
            label: 'Tasks',
            icon: LucideIcons.clipboardList,
            sfSymbol: 'checkmark.square',
            selectedSfSymbol: 'checkmark.square.fill',
            page: QuickTechOfficeAgentTaskPage(),
          ),
          NavTabItem(
            label: 'Profile',
            icon: LucideIcons.user,
            sfSymbol: 'person.crop.circle',
            selectedSfSymbol: 'person.crop.circle.fill',
            page: QuickTechOfficeAgentProfilePage(),
          ),
        ];

      case UserRole.localAgent:
        return const [
          NavTabItem(
            label: 'Dashboard',
            icon: LucideIcons.layoutGrid,
            sfSymbol: 'square.grid.2x2',
            selectedSfSymbol: 'square.grid.2x2.fill',
            page:  QuickTechLocalAgentDashboardPage(),
          ),
          NavTabItem(
            label: 'My Clients',
            icon: LucideIcons.users,
            sfSymbol: 'person.2',
            selectedSfSymbol: 'person.2.fill',
            page: QuickTechLocalAgentMyClientPage(),
          ),
          NavTabItem(
            label: 'Commission',
            icon: LucideIcons.banknoteCheck,
            sfSymbol: 'dollarsign.circle',
            selectedSfSymbol: 'dollarsign.circle.fill',
            page: QuickTechLocalAgentCommissionPage(),
          ),
          NavTabItem(
            label: 'Profile',
            icon: LucideIcons.user,
            sfSymbol: 'person.crop.circle',
            selectedSfSymbol: 'person.crop.circle.fill',
            page: QuickTechLocalAgentProfilePage(),
          ),
        ];

      case UserRole.paidLeadAgent:
        return const [
          NavTabItem(
            label: 'Dashboard',
            icon: LucideIcons.layoutGrid,
            sfSymbol: 'square.grid.2x2',
            selectedSfSymbol: 'square.grid.2x2.fill',
            page: QuickTechPaidAgentDashboardPage(),
          ),
          NavTabItem(
            label: 'Leads',
            icon: LucideIcons.users,
            sfSymbol: 'person.2',
            selectedSfSymbol: 'person.2.fill',
            page: QuickTechPaidAgentLeadPage(),
          ),
          NavTabItem(
            label: 'Follow Ups',
            icon: LucideIcons.phoneCall,
            sfSymbol: 'phone.arrow.up.right',
            selectedSfSymbol: 'phone.arrow.up.right.fill',
            page: QuickTechPaidAgentFollowupPage(),
          ),
          NavTabItem(
            label: 'Report',
            icon: LucideIcons.chartBar,
            sfSymbol: 'chart.bar',
            selectedSfSymbol: 'chart.bar.fill',
            page: QuickTechPaidAgentReportPage(),
          ),
          NavTabItem(
            label: 'Profile',
            icon: LucideIcons.user,
            sfSymbol: 'person.crop.circle',
            selectedSfSymbol: 'person.crop.circle.fill',
            page: QuickTechPaidAgentProfilePage(),
          ),
        ];

      case UserRole.rlAccountUser:
        return const [
          NavTabItem(
            label: 'Dashboard',
            icon: LucideIcons.layoutGrid,
            sfSymbol: 'square.grid.2x2',
            selectedSfSymbol: 'square.grid.2x2.fill',
            page:ComingSoonView(title: 'Dashboard', icon: LucideIcons.layoutGrid)
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
            page: ComingSoonView(title: 'Profile', icon: LucideIcons.user),
          ),
        ];
    }
  }
}

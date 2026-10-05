import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../model/quick_tech_dashboard_state.dart';

final quickTechDashboardProvider = StateNotifierProvider<
    QuickTechDashboardNotifier, QuickTechDashboardState>((ref) {
  return QuickTechDashboardNotifier();
});

class QuickTechDashboardNotifier extends StateNotifier<QuickTechDashboardState> {
  QuickTechDashboardNotifier()
      : super(const QuickTechDashboardState(
          metrics: [
            OperationalMetric(
              id: 'tasks',
              title: "Today's Tasks",
              value: '0 pending',
              badgeText: '4 total',
              icon: LucideIcons.clipboardList,
              iconBgColor: Color(0xFFEEF2FF),
              iconColor: Color(0xFF4F46E5),
            ),
            OperationalMetric(
              id: 'leads',
              title: "Today's Leads",
              value: '6 / 10',
              badgeText: '2 converted',
              icon: LucideIcons.users,
              iconBgColor: Color(0xFFECFDF5),
              iconColor: Color(0xFF059669),
            ),
            OperationalMetric(
              id: 'calling',
              title: 'Calling Target',
              value: '14 / 20',
              badgeText: '70% Done',
              icon: LucideIcons.phoneCall,
              iconBgColor: Color(0xFFFFF7ED),
              iconColor: Color(0xFFEA580C),
            ),
            OperationalMetric(
              id: 'followups',
              title: 'Pending Follow-ups',
              value: '4 pending',
              badgeText: '2 for Today',
              icon: LucideIcons.calendarClock,
              iconBgColor: Color(0xFFF3E8FF),
              iconColor: Color(0xFF9333EA),
            ),
            OperationalMetric(
              id: 'visa',
              title: 'Active Visa Files',
              value: '5 in queue',
              badgeText: '1 Approved',
              icon: LucideIcons.folderKanban,
              iconBgColor: Color(0xFFF0FDFA),
              iconColor: Color(0xFF0D9488),
            ),
            OperationalMetric(
              id: 'commission',
              title: 'Earned Commission',
              value: '\$1,170.00',
              badgeText: 'Paid: \$720.00',
              icon: LucideIcons.dollarSign,
              iconBgColor: Color(0xFFEFF6FF),
              iconColor: Color(0xFF2563EB),
            ),
          ],
          targets: [
            TargetPerformance(
              id: 'lead_target',
              title: "Today's Lead Target",
              badge: 'Daily',
              current: 7,
              total: 10,
              unit: 'Leads',
              percentage: 70.0,
            ),
            TargetPerformance(
              id: 'calling_target',
              title: "Today's Calling Target",
              badge: 'Daily',
              current: 14,
              total: 20,
              unit: 'Calls',
              percentage: 70.0,
              warningMessage: '6 calls remaining to avoid target penalty',
            ),
            TargetPerformance(
              id: 'followup_target',
              title: "Today's Follow-up Target",
              badge: 'Daily',
              current: 9,
              total: 12,
              unit: 'Follow-ups',
              percentage: 75.0,
            ),
          ],
          followUps: [
            ScheduledFollowUp(
              id: '1',
              name: 'Arifur Rahman',
              time: '04:00 PM',
              category: 'Canada PR',
              phone: '+1 (416) 782-9011',
              note: 'Confirm WES ECA report readiness for Canadian PR entry.',
            ),
            ScheduledFollowUp(
              id: '2',
              name: 'Tanvir Ahmed',
              time: '05:30 PM',
              category: 'Germany Tourist',
              phone: '+1 (647) 555-0199',
              note: 'Discuss Schengen appointment dates for Frankfurt',
            ),
          ],
        ));

  void setNavIndex(int index) {
    state = state.copyWith(selectedNavIndex: index);
  }

  void toggleLanguage() {
    final nextLang = state.selectedLanguage == 'EN' ? 'BN' : 'EN';
    state = state.copyWith(selectedLanguage: nextLang);
  }


  void callFollowUp(ScheduledFollowUp item) {
    Fluttertoast.showToast(msg: "Calling ${item.name} (${item.phone})");
  }

  void viewReports() {
    Fluttertoast.showToast(msg: "Viewing Reports");
  }

  void seeAllFollowUps() {
    Fluttertoast.showToast(msg: "Viewing All Scheduled Follow-ups");
  }
}

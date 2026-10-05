import '../../../core/constant/const.dart';

enum UserRole {
  officeAgent(
    id: 'office_agent',
    title: 'Office Agent Dashboard',
    shortName: 'Office Agent',
    subtitle: 'Leads, Calling, Visa Files & Tasks',
    icon: Icons.work_rounded,
    iconColor: Color(0xFF1E40AF), // Blue
  ),
  localAgent(
    id: 'local_agent',
    title: 'Local Agent Dashboard',
    shortName: 'Local Agent',
    subtitle: 'Client Referral, Status Tracking & Commission',
    icon: Icons.handshake_rounded,
    iconColor: Color(0xFF10B981), // Green
  ),
  paidLeadAgent(
    id: 'paid_lead_agent',
    title: 'Paid Lead Agent Dashboard',
    shortName: 'Paid Lead Agent',
    subtitle: 'Digital Campaigns, Assigned Leads & Targets',
    icon: Icons.campaign_rounded,
    iconColor: Color(0xFFF59E0B), // Orange
  ),
  rlAccountUser(
    id: 'rl_account_user',
    title: 'RL Account User Dashboard',
    shortName: 'RL Account User',
    subtitle: 'RL-1492 Account Balance, Treasury & Ledger',
    icon: Icons.account_balance_rounded,
    iconColor: Color(0xFF7C3AED), // Purple
  );

  final String id;
  final String title;
  final String shortName;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const UserRole({
    required this.id,
    required this.title,
    required this.shortName,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });
}

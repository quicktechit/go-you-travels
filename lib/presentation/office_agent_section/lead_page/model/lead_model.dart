import 'package:flutter/material.dart';

enum LeadStatus {
  newLead('New', Color(0xFF2563EB), Color(0xFFEFF6FF)),
  contacted('Contacted', Color(0xFF9333EA), Color(0xFFF3E8FF)),
  interested('Interested', Color(0xFF0284C7), Color(0xFFE0F2FE)),
  followUp('Follow-up', Color(0xFFEA580C), Color(0xFFFFF7ED)),
  converted('Converted', Color(0xFF059669), Color(0xFFECFDF5)),
  notInterest('Not Interested', Color(0xFF64748B), Color(0xFFF1F5F9)),
  notReachable('Not Reachable', Color(0xFFD97706), Color(0xFFFEF3C7)),
  lost('Lost', Color(0xFFDC2626), Color(0xFFFEF2F2));

  final String label;
  final Color primaryColor;
  final Color bgColor;

  const LeadStatus(this.label, this.primaryColor, this.bgColor);
}

enum LeadPriority {
  low('Low', Color(0xFF64748B), Color(0xFFF1F5F9)),
  medium('Medium', Color(0xFFD97706), Color(0xFFFEF3C7)),
  high('High', Color(0xFFEA580C), Color(0xFFFFEDD5)),
  urgent('Urgent', Color(0xFFDC2626), Color(0xFFFEE2E2));

  final String label;
  final Color color;
  final Color bgColor;

  const LeadPriority(this.label, this.color, this.bgColor);
}

class FollowUpHistoryItem {
  final String id;
  final String title;
  final String loggedBy;
  final String note;
  final String nextFollowUp;
  final String timeAgo;

  const FollowUpHistoryItem({
    required this.id,
    required this.title,
    required this.loggedBy,
    required this.note,
    required this.nextFollowUp,
    required this.timeAgo,
  });
}

class LeadItem {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String destinationCountry;
  final String visaInterest;
  final String leadSource;
  final String assignedConsultant;
  final int totalCallingAttempts;
  final String nextFollowUpDate;
  final LeadStatus status;
  final LeadPriority priority;
  final String? notes;
  final DateTime createdAt;
  final List<FollowUpHistoryItem> history;

  const LeadItem({
    required this.id,
    required this.name,
    required this.phone,
    this.email = 'client.email@outlook.com',
    required this.destinationCountry,
    required this.visaInterest,
    required this.leadSource,
    this.assignedConsultant = 'Tariqul Islam',
    this.totalCallingAttempts = 3,
    this.nextFollowUpDate = 'Tomorrow, 10:00 AM',
    required this.status,
    required this.priority,
    this.notes,
    required this.createdAt,
    this.history = const [
      FollowUpHistoryItem(
        id: 'h1',
        title: 'Interested',
        loggedBy: 'Current Agent',
        note: 'Call logged with result: Interested',
        nextFollowUp: 'Tomorrow, 10:00 AM',
        timeAgo: 'Just now',
      ),
      FollowUpHistoryItem(
        id: 'h2',
        title: 'Busy / Call Back',
        loggedBy: 'Tariqul Islam',
        note: 'She was in a meeting, asked to call back at 11:30 AM tomorrow.',
        nextFollowUp: 'Tomorrow, 11:30 AM',
        timeAgo: 'Yesterday, 3:15 PM',
      ),
    ],
  });

  LeadItem copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? destinationCountry,
    String? visaInterest,
    String? leadSource,
    String? assignedConsultant,
    int? totalCallingAttempts,
    String? nextFollowUpDate,
    LeadStatus? status,
    LeadPriority? priority,
    String? notes,
    DateTime? createdAt,
    List<FollowUpHistoryItem>? history,
  }) {
    return LeadItem(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      destinationCountry: destinationCountry ?? this.destinationCountry,
      visaInterest: visaInterest ?? this.visaInterest,
      leadSource: leadSource ?? this.leadSource,
      assignedConsultant: assignedConsultant ?? this.assignedConsultant,
      totalCallingAttempts: totalCallingAttempts ?? this.totalCallingAttempts,
      nextFollowUpDate: nextFollowUpDate ?? this.nextFollowUpDate,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      history: history ?? this.history,
    );
  }
}

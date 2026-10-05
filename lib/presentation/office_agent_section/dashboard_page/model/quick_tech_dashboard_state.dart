import 'package:flutter/material.dart';

class OperationalMetric {
  final String id;
  final String title;
  final String value;
  final String badgeText;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;

  const OperationalMetric({
    required this.id,
    required this.title,
    required this.value,
    required this.badgeText,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });
}

class TargetPerformance {
  final String id;
  final String title;
  final String badge;
  final int current;
  final int total;
  final String unit;
  final double percentage;
  final String? warningMessage;

  const TargetPerformance({
    required this.id,
    required this.title,
    this.badge = 'Daily',
    required this.current,
    required this.total,
    required this.unit,
    required this.percentage,
    this.warningMessage,
  });
}

class ScheduledFollowUp {
  final String id;
  final String name;
  final String time;
  final String category;
  final String phone;
  final String note;

  const ScheduledFollowUp({
    required this.id,
    required this.name,
    required this.time,
    required this.category,
    required this.phone,
    required this.note,
  });
}

class QuickTechDashboardState {
  final int selectedNavIndex;
  final String selectedLanguage;
  final int unreadNotificationCount;
  final String roleTag;
  final List<OperationalMetric> metrics;
  final List<TargetPerformance> targets;
  final List<ScheduledFollowUp> followUps;

  const QuickTechDashboardState({
    this.selectedNavIndex = 0,
    this.selectedLanguage = 'EN',
    this.unreadNotificationCount = 3,
    this.roleTag = 'Office',
    this.metrics = const [],
    this.targets = const [],
    this.followUps = const [],
  });

  QuickTechDashboardState copyWith({
    int? selectedNavIndex,
    String? selectedLanguage,
    int? unreadNotificationCount,
    String? roleTag,
    List<OperationalMetric>? metrics,
    List<TargetPerformance>? targets,
    List<ScheduledFollowUp>? followUps,
  }) {
    return QuickTechDashboardState(
      selectedNavIndex: selectedNavIndex ?? this.selectedNavIndex,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      unreadNotificationCount:
          unreadNotificationCount ?? this.unreadNotificationCount,
      roleTag: roleTag ?? this.roleTag,
      metrics: metrics ?? this.metrics,
      targets: targets ?? this.targets,
      followUps: followUps ?? this.followUps,
    );
  }
}

import '../../../../core/constant/const.dart';

enum NotificationType {
  financial,
  alert,
  visa,
  lead,
  system,
  task;

  String get label {
    switch (this) {
      case NotificationType.financial:
        return 'Financials';
      case NotificationType.alert:
        return 'Alerts';
      case NotificationType.visa:
        return 'Visa';
      case NotificationType.lead:
        return 'Leads';
      case NotificationType.system:
        return 'System';
      case NotificationType.task:
        return 'Tasks';
    }
  }

  IconData get icon {
    switch (this) {
      case NotificationType.financial:
        return LucideIcons.landmark;
      case NotificationType.alert:
        return LucideIcons.triangleAlert;
      case NotificationType.visa:
        return LucideIcons.badgeCheck;
      case NotificationType.lead:
        return LucideIcons.megaphone;
      case NotificationType.system:
        return LucideIcons.bell;
      case NotificationType.task:
        return LucideIcons.calendarCheck;
    }
  }

  Color getIconColor(bool isDark) {
    switch (this) {
      case NotificationType.financial:
        return isDark ? const Color(0xFFA855F7) : const Color(0xFF7C3AED); // Soft Purple
      case NotificationType.alert:
        return isDark ? const Color(0xFFFB923C) : const Color(0xFFEA580C); // Warm Orange/Amber
      case NotificationType.visa:
        return isDark ? const Color(0xFF4ADE80) : const Color(0xFF16A34A); // Success Green
      case NotificationType.lead:
        return isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB); // Royal Blue
      case NotificationType.system:
        return isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569); // Muted Slate
      case NotificationType.task:
        return isDark ? const Color(0xFF2DD4BF) : const Color(0xFF0D9488); // Teal
    }
  }

  Color getBackgroundColor(bool isDark) {
    switch (this) {
      case NotificationType.financial:
        return isDark ? const Color(0xFF2E1065) : const Color(0xFFF3E8FF);
      case NotificationType.alert:
        return isDark ? const Color(0xFF451A03) : const Color(0xFFFFEDD5);
      case NotificationType.visa:
        return isDark ? const Color(0xFF064E3B) : const Color(0xFFDCFCE7);
      case NotificationType.lead:
        return isDark ? const Color(0xFF1E3A8A) : const Color(0xFFEFF6FF);
      case NotificationType.system:
        return isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9);
      case NotificationType.task:
        return isDark ? const Color(0xFF134E4A) : const Color(0xFFCCFBF1);
    }
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String description;
  final String timeAgo;
  final NotificationType type;
  final bool isRead;
  final DateTime timestamp;
  final String? clientName;
  final String? fileNo;
  final String? amount;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.clientName,
    this.fileNo,
    this.amount,
  });

  NotificationItem copyWith({
    String? id,
    String? title,
    String? description,
    String? timeAgo,
    NotificationType? type,
    bool? isRead,
    DateTime? timestamp,
    String? clientName,
    String? fileNo,
    String? amount,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timeAgo: timeAgo ?? this.timeAgo,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      timestamp: timestamp ?? this.timestamp,
      clientName: clientName ?? this.clientName,
      fileNo: fileNo ?? this.fileNo,
      amount: amount ?? this.amount,
    );
  }
}

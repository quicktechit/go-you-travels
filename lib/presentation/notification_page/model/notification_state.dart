import 'notification_model.dart';

class NotificationState {
  final List<NotificationItem> notifications;
  final String selectedCategory;
  final String searchQuery;
  final bool isLoading;

  const NotificationState({
    this.notifications = const [],
    this.selectedCategory = 'All',
    this.searchQuery = '',
    this.isLoading = false,
  });

  int get unreadCount => notifications.where((item) => !item.isRead).length;

  int getCategoryCount(String category) {
    if (category == 'All') return notifications.length;
    if (category == 'Unread') return unreadCount;
    return notifications
        .where((item) => item.type.label.toLowerCase() == category.toLowerCase())
        .length;
  }

  List<NotificationItem> get filteredNotifications {
    return notifications.where((item) {
      final matchesCategory = switch (selectedCategory) {
        'All' => true,
        'Unread' => !item.isRead,
        'Visa' => item.type == NotificationType.visa,
        'Leads' => item.type == NotificationType.lead,
        'Financials' => item.type == NotificationType.financial,
        'Alerts' => item.type == NotificationType.alert,
        _ => true,
      };

      final matchesQuery = searchQuery.isEmpty ||
          item.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesCategory && matchesQuery;
    }).toList();
  }

  NotificationState copyWith({
    List<NotificationItem>? notifications,
    String? selectedCategory,
    String? searchQuery,
    bool? isLoading,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

import '../../../../core/constant/const.dart';
import '../model/notification_model.dart';
import '../model/notification_state.dart';

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  return NotificationNotifier();
});

class NotificationNotifier extends StateNotifier<NotificationState> {
  NotificationNotifier()
      : super(
          NotificationState(
            notifications: [
              NotificationItem(
                id: 'notif_1',
                title: 'RL Account Deposit Received',
                description:
                    'Client deposited \$2,500 via Bank Wire for Kamrul Islam file.',
                timeAgo: '5 hours ago',
                type: NotificationType.financial,
                isRead: false,
                timestamp: DateTime.now().subtract(const Duration(hours: 5)),
                clientName: 'Kamrul Islam',
                amount: '\$2,500',
              ),
              NotificationItem(
                id: 'notif_2',
                title: 'Daily Calling Target Alert',
                description:
                    'You have completed 14 of 20 scheduled calls today. 6 calls remaining.',
                timeAgo: '2 hours ago',
                type: NotificationType.alert,
                isRead: false,
                timestamp: DateTime.now().subtract(const Duration(hours: 2)),
              ),
              NotificationItem(
                id: 'notif_3',
                title: 'Visa Approved! 🎉',
                description:
                    "Dr. Sabrina Chowdhury's Canadian Visa has been approved by IRCC.",
                timeAgo: '10 mins ago',
                type: NotificationType.visa,
                isRead: false,
                timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
                clientName: 'Dr. Sabrina Chowdhury',
                fileNo: 'CA-VISA-2026-091',
              ),
              NotificationItem(
                id: 'notif_4',
                title: 'New High-Priority Lead',
                description:
                    'Arifur Rahman submitted an inquiry for Canada Express Entry.',
                timeAgo: '1 hour ago',
                type: NotificationType.lead,
                isRead: false,
                timestamp: DateTime.now().subtract(const Duration(hours: 1)),
                clientName: 'Arifur Rahman',
              ),
              NotificationItem(
                id: 'notif_5',
                title: 'Commission Disbursement Completed',
                description:
                    '\$450.00 commission payout processed successfully for Mahmudul Hasan file.',
                timeAgo: '1 day ago',
                type: NotificationType.financial,
                isRead: true,
                timestamp: DateTime.now().subtract(const Duration(days: 1)),
                clientName: 'Mahmudul Hasan',
                amount: '\$450.00',
              ),
              NotificationItem(
                id: 'notif_6',
                title: 'System Maintenance Scheduled',
                description:
                    'Go You Travels server optimization planned for Sunday 2:00 AM - 4:00 AM UTC.',
                timeAgo: '2 days ago',
                type: NotificationType.system,
                isRead: true,
                timestamp: DateTime.now().subtract(const Duration(days: 2)),
              ),
            ],
          ),
        );

  void markAsRead(String id) {
    state = state.copyWith(
      notifications: state.notifications.map((item) {
        if (item.id == id) {
          return item.copyWith(isRead: true);
        }
        return item;
      }).toList(),
    );
  }

  void markAllAsRead() {
    state = state.copyWith(
      notifications: state.notifications.map((item) {
        return item.copyWith(isRead: true);
      }).toList(),
    );
  }

  void toggleReadStatus(String id) {
    state = state.copyWith(
      notifications: state.notifications.map((item) {
        if (item.id == id) {
          return item.copyWith(isRead: !item.isRead);
        }
        return item;
      }).toList(),
    );
  }

  void deleteNotification(String id) {
    state = state.copyWith(
      notifications:
          state.notifications.where((item) => item.id != id).toList(),
    );
  }

  void clearAll() {
    state = state.copyWith(notifications: []);
  }

  void filterByCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }
}

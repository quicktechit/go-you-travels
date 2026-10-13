import '../../../../core/constant/const.dart';
import '../model/notification_state.dart';
import '../provider/notification_provider.dart';
import '../widget/notification_appbar.dart';
import '../widget/notification_card_item.dart';
import '../widget/notification_filter_chips.dart';

class QuickTechNotificationPage extends ConsumerWidget {
  const QuickTechNotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationProvider);
    final notifier = ref.read(notificationProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final notifications = state.filteredNotifications;
    final unreadCount = state.unreadCount;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: const NotificationAppbar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),

            // 1. Horizontal Category Filter Chips
            const NotificationFilterChips(),

            SizedBox(height: 8.h),

            // 2. Section Header Row ("Notifications (X unread)")
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications ($unreadCount unread)',
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.textPrimary,
                    ),
                  ),
                  if (notifications.isNotEmpty && unreadCount > 0)
                    InkWell(
                      onTap: () {
                        notifier.markAllAsRead();
                        Fluttertoast.showToast(msg: 'All marked as read');
                      },
                      borderRadius: BorderRadius.circular(8.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 4.h),
                        child: Text(
                          'Mark all read',
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 4.h),

            // 3. Main Notifications Card List or Empty State
            Expanded(
              child: notifications.isEmpty
                  ? _buildEmptyState(context, state, notifier, isDark)
                  : RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(
                            const Duration(milliseconds: 500));
                      },
                      color: AppColors.primary,
                      child: ListView.builder(
                        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 80.h),
                        physics: const BouncingScrollPhysics(),
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final item = notifications[index];
                          return NotificationCardItem(item: item);
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    NotificationState state,
    NotificationNotifier notifier,
    bool isDark,
  ) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurfaceHigh
                    : AppColors.primary.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  LucideIcons.bellOff,
                  size: 38.sp,
                  color: isDark ? AppColors.darkTextMuted : AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'No Notifications Found',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color:
                    isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              state.selectedCategory != 'All'
                  ? "No notifications matching '${state.selectedCategory}' category."
                  : "You're all caught up! New updates, visa statuses, and alerts will appear here.",
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 13.sp,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            SizedBox(height: 20.h),
            if (state.selectedCategory != 'All')
              ElevatedButton.icon(
                onPressed: () {
                  notifier.filterByCategory('All');
                },
                icon: Icon(LucideIcons.rotateCcw, size: 16.sp),
                label: Text(
                  'Reset Filters',
                  style: textTheme.labelLarge?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

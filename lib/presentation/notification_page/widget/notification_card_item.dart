import '../../../../core/constant/const.dart';
import '../model/notification_model.dart';
import '../provider/notification_provider.dart';
import 'notification_details_modal.dart';

class NotificationCardItem extends ConsumerWidget {
  final NotificationItem item;

  const NotificationCardItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final iconBg = item.type.getBackgroundColor(isDark);
    final iconColor = item.type.getIconColor(isDark);

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Dismissible(
        key: Key(item.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.w),
          decoration: BoxDecoration(
            color: AppColors.red.withAlpha(220),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Delete',
                style: textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(width: 6.w),
              Icon(LucideIcons.trash2, color: Colors.white, size: 20.sp),
            ],
          ),
        ),
        onDismissed: (_) {
          ref.read(notificationProvider.notifier).deleteNotification(item.id);
          Fluttertoast.showToast(msg: 'Notification removed');
        },
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Mark as read when clicked
              if (!item.isRead) {
                ref.read(notificationProvider.notifier).markAsRead(item.id);
              }
              // Show details bottom sheet
              NotificationDetailsModal.show(context, item);
            },
            borderRadius: BorderRadius.circular(16.r),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: isDark
                    ? (item.isRead
                        ? AppColors.darkSurface
                        : AppColors.darkSurface.withAlpha(230))
                    : (item.isRead
                        ? AppColors.surface
                        : const Color(0xFFF8FAFC)),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: !item.isRead
                      ? AppColors.primary.withAlpha(isDark ? 80 : 50)
                      : (isDark ? AppColors.darkLine : AppColors.line),
                  width: !item.isRead ? 1.2 : 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(isDark ? 20 : 8),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Avatar Icon Circle
                      Container(
                        width: 44.r,
                        height: 44.r,
                        decoration: BoxDecoration(
                          color: iconBg,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            item.type.icon,
                            color: iconColor,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),

                      // Content Column (Title, Timestamp, Description)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title & Time Row
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.title,
                                    style: textTheme.bodyLarge?.copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: !item.isRead
                                          ? FontWeight.w800
                                          : FontWeight.w700,
                                      color: isDark
                                          ? AppColors.darkTextPrimary
                                          : AppColors.textPrimary,
                                      height: 1.2,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  item.timeAgo,
                                  style: textTheme.bodySmall?.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: isDark
                                        ? AppColors.darkTextMuted
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.h),

                            // Description Body Text
                            Text(
                              item.description,
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.textSecondary,
                                height: 1.35,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Unread Badge Indicator Dot on Top Right
                  if (!item.isRead)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 8.r,
                        height: 8.r,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(120),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

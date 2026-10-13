import '../../../../core/constant/const.dart';
import '../model/notification_model.dart';
import '../provider/notification_provider.dart';

class NotificationDetailsModal extends ConsumerWidget {
  final NotificationItem item;

  const NotificationDetailsModal({
    super.key,
    required this.item,
  });

  static void show(BuildContext context, NotificationItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NotificationDetailsModal(item: item),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final iconBg = item.type.getBackgroundColor(isDark);
    final iconColor = item.type.getIconColor(isDark);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Grab Handle Top
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkLine : AppColors.line,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Header Section with Category Badge
            Row(
              children: [
                Container(
                  width: 48.r,
                  height: 48.r,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      item.type.icon,
                      color: iconColor,
                      size: 24.sp,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: iconBg,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          item.type.label,
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w700,
                            color: iconColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item.timeAgo,
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          color: isDark
                              ? AppColors.darkTextMuted
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    LucideIcons.x,
                    size: 20.sp,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Full Notification Title
            Text(
              item.title,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 10.h),

            // Full Description
            Text(
              item.description,
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            SizedBox(height: 16.h),

            // Extra Metadata Cards if available
            if (item.clientName != null ||
                item.fileNo != null ||
                item.amount != null) ...[
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkSurfaceHigh
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isDark ? AppColors.darkLine : AppColors.line,
                  ),
                ),
                child: Column(
                  children: [
                    if (item.clientName != null)
                      _MetaRow(
                        label: 'Client Name',
                        value: item.clientName!,
                        isDark: isDark,
                      ),
                    if (item.fileNo != null) ...[
                      SizedBox(height: 6.h),
                      _MetaRow(
                        label: 'File Number',
                        value: item.fileNo!,
                        isDark: isDark,
                      ),
                    ],
                    if (item.amount != null) ...[
                      SizedBox(height: 6.h),
                      _MetaRow(
                        label: 'Amount',
                        value: item.amount!,
                        isDark: isDark,
                        valueColor: AppColors.secondaryDark,
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ref
                          .read(notificationProvider.notifier)
                          .toggleReadStatus(item.id);
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                        msg: item.isRead
                            ? 'Marked as unread'
                            : 'Marked as read',
                      );
                    },
                    icon: Icon(
                      item.isRead
                          ? LucideIcons.mailClock
                          : LucideIcons.mailCheck,
                      size: 16.sp,
                    ),
                    label: Text(
                      item.isRead ? 'Mark Unread' : 'Mark Read',
                      style: textTheme.labelLarge?.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.textPrimary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ref
                          .read(notificationProvider.notifier)
                          .deleteNotification(item.id);
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(msg: 'Notification deleted');
                    },
                    icon: Icon(LucideIcons.trash2, size: 16.sp),
                    label: Text(
                      'Delete',
                      style: textTheme.labelLarge?.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;
  final Color? valueColor;

  const _MetaRow({
    required this.label,
    required this.value,
    required this.isDark,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            fontSize: 12.sp,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: valueColor ??
                (isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}

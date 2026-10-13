import '../../../../core/constant/const.dart';
import '../provider/notification_provider.dart';

class NotificationAppbar extends ConsumerWidget implements PreferredSizeWidget {
  final VoidCallback? onBackTap;

  const NotificationAppbar({
    super.key,
    this.onBackTap,
  });

  @override
  Size get preferredSize => Size.fromHeight(70.h);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationProvider);
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;
    final unreadCount = state.unreadCount;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isDark ? 30 : 10),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            children: [
              // 1. Back Button with styled glass container
              InkWell(
                onTap: onBackTap ?? () => context.pop(),
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurfaceHigh : AppColors.background,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isDark ? AppColors.darkLine : AppColors.line,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18.sp,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // 2. Title & Subtitle with dynamic Live Unread Badge
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Notifications',
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                            letterSpacing: -0.3,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        if (unreadCount > 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withAlpha(25),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.primary.withAlpha(60),
                              ),
                            ),
                            child: Text(
                              '$unreadCount New',
                              style: textTheme.bodySmall?.copyWith(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Stay updated with live alerts & activity',
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // 3. Action Buttons (Mark All Read & Theme Toggle)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Mark All as Read Action
                  if (unreadCount > 0) ...[
                    _ActionButton(
                      icon: LucideIcons.checkCheck,
                      tooltip: 'Mark all as read',
                      isDark: isDark,
                      iconColor: AppColors.primary,
                      onTap: () {
                        ref.read(notificationProvider.notifier).markAllAsRead();
                        Fluttertoast.showToast(
                          msg: 'All notifications marked as read',
                          backgroundColor: AppColors.primaryDark,
                          textColor: Colors.white,
                        );
                      },
                    ),
                    SizedBox(width: 6.w),
                  ],

                  // Theme Toggle Action
                  _ActionButton(
                    icon: isDark ? Icons.wb_sunny_rounded : LucideIcons.moon,
                    tooltip: 'Toggle Theme',
                    isDark: isDark,
                    iconColor: isDark ? Colors.amber : AppColors.textPrimary,
                    onTap: () {
                      ref.read(themeProvider.notifier).state =
                          isDark ? ThemeMode.light : ThemeMode.dark;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final bool isDark;
  final Color? iconColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.tooltip,
    required this.isDark,
    this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurfaceHigh : AppColors.background,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isDark ? AppColors.darkLine : AppColors.line,
              width: 1,
            ),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 16.sp,
              color: iconColor ??
                  (isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary),
            ),
          ),
        ),
      ),
    );
  }
}

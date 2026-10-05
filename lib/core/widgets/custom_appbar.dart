import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../constant/const.dart';
import '../../presentation/office_agent_section/dashboard_page/provider/quick_tech_dashboard_provider.dart';

/// A customizable top app bar that implements [PreferredSizeWidget],
/// allowing it to be used either as a [Scaffold.appBar] or as a standalone widget anywhere in the app.
class CustomAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.title = 'Dashboard',
    this.subtitle = 'Go You Travels',
    this.showBackButton = false,
    this.onBackTap,
    this.leading,
    this.showThemeToggle = true,
    this.showRoleTag = true,
    this.showNotificationBell = true,
    this.onNotificationTap,
    this.customActions,
    this.backgroundColor,
    this.padding,
    this.preferredHeight,
  });

  final String title;

  final String? subtitle;

  final bool showBackButton;

  final VoidCallback? onBackTap;

  final Widget? leading;

  final bool showThemeToggle;

  final bool showRoleTag;

  final bool showNotificationBell;

  final VoidCallback? onNotificationTap;

  final List<Widget>? customActions;

  final Color? backgroundColor;

  final EdgeInsetsGeometry? padding;

  final double? preferredHeight;

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight ?? 60.h);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechDashboardProvider);
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final pillBg = isDark ? AppColors.darkSurfaceHigh : AppColors.line;
    final pillTextColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.primaryDark;
    final bgColor =
        backgroundColor ??
        (isDark ? AppColors.darkBackground : AppColors.background);

    return Container(
      color: bgColor,

      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Title & Subtitle (with optional Leading / Back Button)
            Expanded(
              child: Row(
                children: [
                  if (leading != null) ...[
                    leading!,
                    SizedBox(width: 8.w),
                  ] else if (showBackButton) ...[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18.sp,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.textPrimary,
                      ),
                      onPressed:
                          onBackTap ?? () =>   context.pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    SizedBox(width: 8.w),
                  ],
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.figtree(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (subtitle != null && subtitle!.isNotEmpty) ...[
                          SizedBox(height: 2.h),
                          Text(
                            subtitle!,
                            style: GoogleFonts.figtree(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),

            // Right Actions (Language, Theme Toggle, Role Tag, Notifications, Custom Actions)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Theme toggle button
                if (showThemeToggle) ...[
                  IconButton(
                    onPressed: () {
                      ref.read(themeProvider.notifier).state = isDark
                          ? ThemeMode.light
                          : ThemeMode.dark;
                    },
                    icon: Icon(
                      isDark ? Icons.wb_sunny_rounded : LucideIcons.moon,
                      size: 18.sp,
                      color: isDark ? Colors.amber : AppColors.textPrimary,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(width: 8.w),
                ],

                // Office Role Pill
                if (showRoleTag && state.roleTag.isNotEmpty) ...[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: pillBg,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 7.r,
                          height: 7.r,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          state.roleTag,
                          style: GoogleFonts.figtree(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: pillTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                ],

                // Notification Bell Icon with Badge
                if (showNotificationBell) ...[
                  InkWell(
                    onTap: onNotificationTap,
                    borderRadius: BorderRadius.circular(12.r),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          LucideIcons.bell,
                          size: 20.sp,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.textPrimary,
                        ),
                        if (state.unreadNotificationCount > 0)
                          Positioned(
                            top: -4.h,
                            right: -6.w,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: Color(0xFFEF4444),
                                shape: BoxShape.circle,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16.r,
                                minHeight: 16.r,
                              ),
                              child: Text(
                                '${state.unreadNotificationCount}',
                                style: GoogleFonts.figtree(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],

                // Extra custom actions if provided
                ...?customActions,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

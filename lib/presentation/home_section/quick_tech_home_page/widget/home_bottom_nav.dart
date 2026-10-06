import 'dart:ui';

import '../../../../core/constant/const.dart';
import '../model/nav_tab_item.dart';

class CleanBottomNavBar extends StatelessWidget {
  final List<NavTabItem> tabItems;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CleanBottomNavBar({
    super.key,
    required this.tabItems,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(1.r)),
      child: BackdropFilter(
        // High-quality frosted glass blur effect
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: .topCenter,
              end: .bottomCenter,
              colors: [
                Theme.of(context).cardColor.withAlpha(120),
                Theme.of(context).cardColor.withAlpha(190),
                Theme.of(context).cardColor,
              ],
            ),
          ),
          child: SafeArea(
            top: false,
            // Keep bottom padding for device navigation bars/home indicators
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(tabItems.length, (index) {
                  final isSelected = index == selectedIndex;
                  return _CleanNavItem(
                    item: tabItems[index],
                    isSelected: isSelected,
                    isDark: isDark,
                    onTap: () => onTap(index),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CleanNavItem extends StatelessWidget {
  final NavTabItem item;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _CleanNavItem({
    required this.item,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final unselectedColor = isDark
        ? Colors.grey.shade400
        : Colors.grey.shade600;
    final selectedColor = isDark ? AppColors.primaryLight : AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(color: isSelected ? selectedColor : unselectedColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              size: isSelected ? 24.sp : 22.sp,
              color: isSelected ? selectedColor : unselectedColor,
            ),
            SizedBox(height: 6.h),
            Text(
              item.label,
              style: GoogleFonts.figtree(
                fontSize: isSelected ? 14.sp : 11.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? selectedColor : unselectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

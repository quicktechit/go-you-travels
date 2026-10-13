import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constant/const.dart';
import '../model/rl_account_dashboard_state.dart';

class LedgerBreakdownGrid extends StatelessWidget {
  final List<LedgerBreakdownItem> items;

  const LedgerBreakdownGrid({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.length < 4) return const SizedBox.shrink();

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _LedgerCard(item: items[0])),
            SizedBox(width: 12.w),
            Expanded(child: _LedgerCard(item: items[1])),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _LedgerCard(item: items[2])),
            SizedBox(width: 12.w),
            Expanded(child: _LedgerCard(item: items[3])),
          ],
        ),
      ],
    );
  }
}

class _LedgerCard extends StatelessWidget {
  final LedgerBreakdownItem item;

  const _LedgerCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;

    final IconData iconData;
    final Color iconBg;
    final Color iconColor;

    switch (item.type) {
      case LedgerType.clientInflows:
        iconData = LucideIcons.arrowDown;
        iconBg = AppColors.successLight;
        iconColor = AppColors.successEmerald;
        break;
      case LedgerType.embassyVendor:
        iconData = LucideIcons.arrowUp;
        iconBg = AppColors.redLight;
        iconColor = AppColors.red;
        break;
      case LedgerType.bridgeLoans:
        iconData = LucideIcons.creditCard;
        iconBg = AppColors.softOrange;
        iconColor = AppColors.warningAmber;
        break;
      case LedgerType.loanRepayments:
        iconData = LucideIcons.rotateCcw;
        iconBg = AppColors.blueLight;
        iconColor = AppColors.teal;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1.w),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    iconData,
                    size: 18.sp,
                    color: iconColor,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  item.title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            item.amount,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            item.subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.darkTextMuted
                  : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

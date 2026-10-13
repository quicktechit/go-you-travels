import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constant/const.dart';
import '../model/rl_account_dashboard_state.dart';
import 'transaction_voucher_modal.dart';

class AccountTransactionCard extends StatelessWidget {
  final RlAccountTransaction transaction;

  const AccountTransactionCard({
    super.key,
    required this.transaction,
  });

  void _showVoucherModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TransactionVoucherModal(transaction: transaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;

    final formattedAmount = transaction.amount
        .toStringAsFixed(2)
        .replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

    final sign = transaction.isCredit ? '+' : '-';
    final amountText = '$sign\$$formattedAmount';

    final amountColor = transaction.isCredit
        ? AppColors.successGreen
        : AppColors.warningOrange;

    final iconBg = transaction.isCredit
        ? AppColors.successLight
        : AppColors.redLight;

    final iconColor = transaction.isCredit
        ? AppColors.successEmerald
        : AppColors.red;

    final iconData = transaction.isCredit
        ? LucideIcons.arrowDownLeft
        : LucideIcons.arrowUpRight;

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showVoucherModal(context),
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: borderColor, width: 1.w),
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Row(
              children: [
                // Circular Arrow Icon
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      iconData,
                      size: 20.sp,
                      color: iconColor,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // Title & Reference / Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${transaction.dateStr} · Ref: ${transaction.reference}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppColors.darkTextMuted
                              : AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),

                // Amount & Running Balance
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      amountText,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: amountColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Bal: ${transaction.runningBalance}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.darkTextMuted
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

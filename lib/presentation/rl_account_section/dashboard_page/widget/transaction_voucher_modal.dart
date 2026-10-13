import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constant/const.dart';
import '../model/rl_account_dashboard_state.dart';

class TransactionVoucherModal extends StatelessWidget {
  final RlAccountTransaction transaction;

  const TransactionVoucherModal({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;



    final formattedAmount = transaction.amount
        .toStringAsFixed(2)
        .replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

    final sign = transaction.isCredit ? '+' : '-';
    final amountText = '$sign\$$formattedAmount';

    final bannerBg = transaction.isCredit?
    AppColors.successEmerald
        : AppColors.warningOrange;


    // Ensure running balance displays properly formatted string
    final rawRunning = transaction.runningBalance;
    final formattedRunning = rawRunning.startsWith('\$')
        ? rawRunning
        : '\$$rawRunning';

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkLine : AppColors.line,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Header Title with Voucher Icon
          Row(
            children: [
              Container(
                width: 38.r,
                height: 38.r,
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Icon(
                    LucideIcons.receipt,
                    size: 20.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Transaction Voucher',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Amount Banner Box
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: bannerBg,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Text(
                  amountText,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.background
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  transaction.categoryLabel.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.background,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Key-Value Table Details Rows
          _VoucherDetailRow(
            label: 'Transaction ID',
            value: transaction.id,
            isDark: isDark,
          ),
          SizedBox(height: 14.h),
          _VoucherDetailRow(
            label: 'Date',
            value: transaction.dateStr,
            isDark: isDark,
          ),
          SizedBox(height: 14.h),
          _VoucherDetailRow(
            label: 'Voucher Ref',
            value: transaction.reference,
            isDark: isDark,
          ),
          SizedBox(height: 14.h),
          _VoucherDetailRow(
            label: 'Running Balance',
            value: formattedRunning.contains('.00')
                ? formattedRunning
                : '$formattedRunning.00',
            isDark: isDark,
          ),
          SizedBox(height: 14.h),
          _VoucherDetailRow(
            label: 'Description',
            value: transaction.description,
            isDark: isDark,
            isMultiline: true,
          ),
          SizedBox(height: 28.h),

          // Right-aligned Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 36.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Close',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VoucherDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;
  final bool isMultiline;

  const _VoucherDetailRow({
    required this.label,
    required this.value,
    required this.isDark,
    this.isMultiline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 120.w,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13.5.sp,
              fontWeight: FontWeight.bold,
              color: isDark
                  ? AppColors.darkTextPrimary
                  : AppColors.textPrimary,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

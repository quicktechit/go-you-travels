import '../../../../core/constant/const.dart';
import '../model/commission_model.dart';

class CommissionTransactionCard extends StatelessWidget {
  final CommissionTransaction transaction;

  const CommissionTransactionCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.clientName,
                  style: GoogleFonts.figtree(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'File: ${transaction.fileNo} · Agent: ${transaction.agentName}',
                  style: GoogleFonts.figtree(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '${transaction.date} · via ${transaction.paymentMethod}',
                  style: GoogleFonts.figtree(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: isDark ? AppColors.darkTextMuted : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+\$${transaction.amount.toStringAsFixed(2)}',
                style: GoogleFonts.figtree(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.emerald,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: transaction.status.bgColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  transaction.status.label,
                  style: GoogleFonts.figtree(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: transaction.status.textColor,
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

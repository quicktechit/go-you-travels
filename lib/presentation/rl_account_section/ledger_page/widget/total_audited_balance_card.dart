import '../../../../core/constant/const.dart';

class TotalAuditedBalanceCard extends StatelessWidget {
  final double balance;
  final String accountCode;

  const TotalAuditedBalanceCard({
    super.key,
    required this.balance,
    required this.accountCode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textTheme = theme.textTheme;

    final formattedBalance = balance
        .toStringAsFixed(2)
        .replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.darkBackground,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TOTAL AUDITED BALANCE',
            style: textTheme.bodySmall?.copyWith(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.darkTextSecondary,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  '\$$formattedBalance',
                  style: textTheme.headlineLarge?.copyWith(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkTextPrimary,
                    height: 1.1,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  accountCode,
                  style: textTheme.labelLarge?.copyWith(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.surface,
                    letterSpacing: 0.5,
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

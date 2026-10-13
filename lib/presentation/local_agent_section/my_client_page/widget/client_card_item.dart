import '../../../../core/constant/const.dart';
import '../../dashboard_page/model/local_agent_dashboard_state.dart';
import 'client_details_modal.dart';

class ClientCardItem extends StatelessWidget {
  final SubmittedClient client;

  const ClientCardItem({
    super.key,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;

    return GestureDetector(
      onTap: () => ClientDetailsModal.show(context, client),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurfaceHigh : AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_rounded,
                    size: 24.sp,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              client.name,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: client.status.bgColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              client.status.label,
                              style: textTheme.bodySmall?.copyWith(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: client.status.textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Passport: P94365056 · ${client.country}',
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Divider(color: borderColor, height: 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFinancialCol(
                  context: context,
                  title: 'Package Value',
                  value: '\$${client.packageAmount.toStringAsFixed(0)}',
                  color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                ),
                _buildFinancialCol(
                  context: context,
                  title: 'Paid',
                  value: '\$1,500',
                  color: AppColors.emerald,
                ),
                _buildFinancialCol(
                  context: context,
                  title: 'Due Balance',
                  value: '\$3,000',
                  color: AppColors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialCol({
    required BuildContext context,
    required String title,
    required String value,
    required Color color,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

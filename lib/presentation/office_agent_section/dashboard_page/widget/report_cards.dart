import '../../../../core/constant/const.dart';
import '../model/quick_tech_report_model.dart';

class SalesReportCard extends StatelessWidget {
  const SalesReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final headerTextColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final primaryTextColor = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

    final items = const [
      SalesBreakdownItem(
        category: 'Canada Express Entry & Work',
        amountText: '\$16,100',
        percentage: 0.42,
        color: AppColors.primaryDark,
      ),
      SalesBreakdownItem(
        category: 'Saudi Umrah VIP Packages',
        amountText: '\$10,750',
        percentage: 0.28,
        color: AppColors.secondaryDark,
      ),
      SalesBreakdownItem(
        category: 'United Kingdom Student & Work',
        amountText: '\$6,900',
        percentage: 0.18,
        color: Color(0xFFD97706),
      ),
      SalesBreakdownItem(
        category: 'Schengen Tourist & Visit',
        amountText: '\$4,650',
        percentage: 0.12,
        color: Color(0xFF7C3AED),
      ),
    ];

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1.w),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            'MONTHLY REVENUE BREAKDOWN',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: headerTextColor,
                  letterSpacing: 0.6,
                ),
          ),
          SizedBox(height: 12.h),

          // Big Amount
          Text(
            '\$38,400.00',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                  height: 1.1,
                ),
          ),
          SizedBox(height: 4.h),

          // Target subtext
          Text(
            'Target: \$50,000.00 · 76.8% Achieved',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryDark,
                ),
          ),
          SizedBox(height: 20.h),

          // Items with progress bar
          Column(
            children: items.map((item) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.category,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: primaryTextColor,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          item.amountText,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.bold,
                                color: item.color,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    _buildProgressBar(
                      percentage: item.percentage,
                      color: item.color,
                      isDark: isDark,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class FunnelReportCard extends StatelessWidget {
  const FunnelReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final headerTextColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final primaryTextColor = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

    final stages = const [
      FunnelStageItem(
        percentageText: '100%',
        title: 'Total Leads Ingested',
        count: 140,
        badgeColor: AppColors.primaryDark,
      ),
      FunnelStageItem(
        percentageText: '82%',
        title: 'Contacted & Profiled',
        count: 115,
        badgeColor: Color(0xFF0D9488),
      ),
      FunnelStageItem(
        percentageText: '58%',
        title: 'Interested Inquiries',
        count: 81,
        badgeColor: Color(0xFFD97706),
      ),
      FunnelStageItem(
        percentageText: '36%',
        title: 'Follow-up Active',
        count: 50,
        badgeColor: Color(0xFF8B5CF6),
      ),
      FunnelStageItem(
        percentageText: '24%',
        title: 'Converted to Clients',
        count: 34,
        badgeColor: AppColors.secondaryDark,
      ),
    ];

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1.w),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            'LEAD CONVERSION FUNNEL',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: headerTextColor,
                  letterSpacing: 0.6,
                ),
          ),
          SizedBox(height: 20.h),

          // Funnel stages list
          Column(
            children: stages.map((stage) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Row(
                  children: [
                    // Percentage badge box
                    Container(
                      width: 62.w,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      decoration: BoxDecoration(
                        color: stage.badgeColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        stage.percentageText,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.surface,
                            ),
                      ),
                    ),
                    SizedBox(width: 14.w),

                    // Stage title
                    Expanded(
                      child: Text(
                        stage.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: primaryTextColor,
                            ),
                      ),
                    ),

                    // Count
                    Text(
                      '${stage.count}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: primaryTextColor,
                          ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class CallingReportCard extends StatelessWidget {
  const CallingReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final headerTextColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final primaryTextColor = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

    final items = const [
      MetricProgressItem(
        title: 'Calls Completed (Today)',
        valueText: '14 / 20',
        percentage: 0.70,
        color: AppColors.primaryDark,
      ),
      MetricProgressItem(
        title: 'Follow-ups Reached',
        valueText: '9 / 12',
        percentage: 0.75,
        color: AppColors.secondaryDark,
      ),
      MetricProgressItem(
        title: 'Call Success Rate',
        valueText: '64% Interested',
        percentage: 0.64,
        color: AppColors.secondaryDark,
      ),
    ];

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1.w),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CALLING AGENT PRODUCTIVITY',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: headerTextColor,
                  letterSpacing: 0.6,
                ),
          ),
          SizedBox(height: 20.h),

          Column(
            children: items.map((item) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: primaryTextColor,
                                ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          item.valueText,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.bold,
                                color: item.color,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    _buildProgressBar(
                      percentage: item.percentage,
                      color: item.color,
                      isDark: isDark,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class AccountsReportCard extends StatelessWidget {
  const AccountsReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final headerTextColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final primaryTextColor = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

    final items = const [
      MetricProgressItem(
        title: 'Client Inflows (Total Received)',
        valueText: '\$33,800.00',
        percentage: 0.75,
        color: AppColors.secondaryDark,
      ),
      MetricProgressItem(
        title: 'Embassy & Processing Outflows',
        valueText: '\$12,000.00',
        percentage: 0.40,
        color: Color(0xFFDC2626),
      ),
      MetricProgressItem(
        title: 'Net Operating Balance',
        valueText: '\$42,800.00',
        percentage: 0.85,
        color: AppColors.primaryDark,
      ),
    ];

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1.w),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TREASURY & RL CASH FLOW',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: headerTextColor,
                  letterSpacing: 0.6,
                ),
          ),
          SizedBox(height: 20.h),

          Column(
            children: items.map((item) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: primaryTextColor,
                                ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          item.valueText,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.bold,
                                color: item.color,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    _buildProgressBar(
                      percentage: item.percentage,
                      color: item.color,
                      isDark: isDark,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class TargetsReportCard extends StatelessWidget {
  const TargetsReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final headerTextColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final primaryTextColor = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

    final items = const [
      MetricProgressItem(
        title: "Today's Lead Generation Target",
        valueText: '7 / 10 Leads',
        percentage: 0.70,
        color: AppColors.primaryDark,
      ),
      MetricProgressItem(
        title: "Today's Calling Target",
        valueText: '14 / 20 Calls',
        percentage: 0.70,
        color: Color(0xFFEA580C),
      ),
      MetricProgressItem(
        title: "Today's Follow-up Target",
        valueText: '9 / 12 Follow-ups',
        percentage: 0.75,
        color: Color(0xFF9333EA),
      ),
    ];

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1.w),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OPERATIONAL TARGETS PERFORMANCE',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: headerTextColor,
                  letterSpacing: 0.6,
                ),
          ),
          SizedBox(height: 20.h),

          Column(
            children: items.map((item) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: primaryTextColor,
                                ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          item.valueText,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.bold,
                                color: item.color,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    _buildProgressBar(
                      percentage: item.percentage,
                      color: item.color,
                      isDark: isDark,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class CommissionsReportCard extends StatelessWidget {
  const CommissionsReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final headerTextColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final primaryTextColor = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

    final items = const [
      MetricProgressItem(
        title: 'Earned Commission',
        valueText: '\$1,170.00',
        percentage: 0.80,
        color: AppColors.primary,
      ),
      MetricProgressItem(
        title: 'Paid Commission',
        valueText: '\$720.00',
        percentage: 0.61,
        color: AppColors.secondaryDark,
      ),
      MetricProgressItem(
        title: 'Pending Payout',
        valueText: '\$450.00',
        percentage: 0.39,
        color: Color(0xFFD97706),
      ),
    ];

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1.w),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AGENT COMMISSION BREAKDOWN',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: headerTextColor,
                  letterSpacing: 0.6,
                ),
          ),
          SizedBox(height: 20.h),

          Column(
            children: items.map((item) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: primaryTextColor,
                                ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          item.valueText,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.bold,
                                color: item.color,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    _buildProgressBar(
                      percentage: item.percentage,
                      color: item.color,
                      isDark: isDark,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

Widget _buildProgressBar({
  required double percentage,
  required Color color,
  required bool isDark,
}) {
  final clamped = percentage.clamp(0.0, 1.0);

  return Stack(
    alignment: Alignment.centerLeft,
    children: [
      // Base Track
      Container(
        height: 6.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurfaceHigh : AppColors.line,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      // Active Track
      FractionallySizedBox(
        widthFactor: clamped,
        child: Container(
          height: 6.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
      // End Dot Indicator
      Align(
        alignment: Alignment(clamped * 2 - 1, 0),
        child: Container(
          width: 6.r,
          height: 6.r,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    ],
  );
}

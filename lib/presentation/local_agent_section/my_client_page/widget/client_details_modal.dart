import '../../../../core/constant/const.dart';
import '../../../../core/widgets/upload_doc_modal.dart';
import '../../dashboard_page/model/local_agent_dashboard_state.dart';

class ClientDetailsModal extends HookWidget {
  final SubmittedClient client;

  const ClientDetailsModal({
    super.key,
    required this.client,
  });

  static Future<void> show(BuildContext context, SubmittedClient client) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ClientDetailsModal(client: client),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    final sheetBg = isDark ? AppColors.darkSurface : AppColors.background;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final primaryText = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    final selectedTab = useState(0);
    const tabs = ['Overview', 'Documents', 'Visa Files', 'Payments', 'Activity'];

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.82,
        decoration: BoxDecoration(
          color: sheetBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag Indicator handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),

            // Header Row: Name & Call Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        client.name,
                        style: textTheme.headlineMedium,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'CUST-1376 · ${client.country}',
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Fluttertoast.showToast(msg: "Calling ${client.name} (+1 212 555-0143)");
                  },
                  borderRadius: BorderRadius.circular(24.r),
                  child: Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFF047857), // Green call button
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.phone_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Tabs Bar
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(tabs.length, (index) {
                  final isSelected = selectedTab.value == index;
                  return GestureDetector(
                    onTap: () => selectedTab.value = index,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      margin: EdgeInsets.only(right: 16.w),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected ? AppColors.primary : Colors.transparent,
                            width: 2.5,
                          ),
                        ),
                      ),
                      child: Text(
                        tabs[index],
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected
                              ? AppColors.primary
                              : null,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Divider(color: borderColor, height: 1),
            SizedBox(height: 12.h),

            // Tab Content Body
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: _buildTabContent(context, selectedTab.value, client, isDark, primaryText, secondaryText, borderColor),
              ),
            ),
            SizedBox(height: 16.h),

            // Close Button
            SizedBox(
              width: double.infinity,
              child: AppButton(
                text: 'Close Profile',
                backgroundColor: AppColors.primaryDark,
                textColor: Colors.white,
                height: 48.h,
                fontSize: 15.sp,
                borderRadius: 12,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(
    BuildContext context,
    int tabIndex,
    SubmittedClient client,
    bool isDark,
    Color primaryText,
    Color secondaryText,
    Color borderColor,
  ) {
    final textTheme = Theme.of(context).textTheme;

    switch (tabIndex) {
      case 0: // Overview
        return Column(
          children: [
            _buildInfoRow(context, 'Full Name', client.name, borderColor),
            _buildInfoRow(context, 'Phone Number', '+1 (212) 555-0143', borderColor),
            _buildInfoRow(context, 'Email Address', 'nusrat.jahan@gmail.com', borderColor),
            _buildInfoRow(context, 'Passport Number', 'P94365056', borderColor),
            _buildInfoRow(context, 'Passport Expiry', '2032-12-31', borderColor),
            _buildInfoRow(context, 'National ID (NID)', 'NID-9534061310', borderColor),
            _buildInfoRow(context, 'Residential Address', 'Primary Residential Address', borderColor),
            _buildInfoRow(context, 'Target Country', client.country, borderColor),
            _buildInfoRow(context, 'Travel Purpose', 'Immigration & Tourism', borderColor),
            _buildInfoRow(context, 'Service Package', client.visaType, borderColor),
            _buildInfoRow(context, 'Assigned Consultant', 'Tariqul Islam', borderColor),
            _buildInfoRow(context, 'Referral Agent', 'Website', borderColor, isLast: true),
          ],
        );
      case 1: // Documents
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Uploaded Documents (1)',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => UploadDocModal.show(
                    context,
                    onUpload: (docType, source) {
                      Fluttertoast.showToast(msg: "Successfully uploaded $docType via $source");
                    },
                  ),
                  icon: Icon(Icons.cloud_upload_rounded, size: 16.sp, color: AppColors.primary),
                  label: Text(
                    'Upload Doc',
                    style: textTheme.titleSmall?.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurfaceHigh : AppColors.background,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(Icons.description_rounded, color: AppColors.primary, size: 24.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'National ID / Passport',
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'National_ID_/_Passport.pdf · 1.8 MB',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.emerald.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'Verified',
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.emerald,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case 2: // Visa Files
        return Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurfaceHigh : AppColors.background,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'VF-2024-785',
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      'New',
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                '${client.visaType} · Travel: 2026-12-15',
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Documents: 2/6 collected',
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.emerald,
                ),
              ),
            ],
          ),
        );
      case 3: // Payments
        return Column(
          children: [
            _buildInfoRow(context, 'Total Package Fee', '\$4,500.00', borderColor),
            _buildInfoRow(context, 'Paid Amount', '\$1,500.00', borderColor),
            _buildInfoRow(context, 'Due Balance', '\$3,000.00', borderColor),
            _buildInfoRow(context, 'Payment Status', 'Partially Paid', borderColor, isLast: true),
          ],
        );
      case 4: // Activity
        return Column(
          children: [
            _buildActivityItem(context, 'Initial Lead Conversion', 'Converted from Facebook ad inquiry to VIP file.', 'Sep 20, 2026'),
            _buildActivityItem(context, 'Document Pack Collected', 'Passport and 6-month bank statement received.', 'Sep 22, 2026'),
            _buildActivityItem(context, 'Embassy Solvency Check', 'Financial solvency verified by senior officer.', 'Sep 24, 2026'),
            _buildActivityItem(context, 'Appointment Booked', 'Biometrics slot scheduled at VFS Global.', 'Sep 25, 2026', isLast: true),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, Color borderColor, {bool isLast = false}) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        border: isLast ? null : Border(bottom: BorderSide(color: borderColor, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(BuildContext context, String title, String desc, String date, {bool isLast = false}) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10.r,
                height: 10.r,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2.w,
                  height: 35.h,
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      date,
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  desc,
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

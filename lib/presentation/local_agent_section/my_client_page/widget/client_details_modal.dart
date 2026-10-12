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
                        style: GoogleFonts.figtree(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: primaryText,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'CUST-1376 · ${client.country}',
                        style: GoogleFonts.figtree(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: secondaryText,
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
                        style: GoogleFonts.figtree(
                          fontSize: 14.sp,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected
                              ? AppColors.primary
                              : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
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
    switch (tabIndex) {
      case 0: // Overview
        return Column(
          children: [
            _buildInfoRow('Full Name', client.name, primaryText, secondaryText, borderColor),
            _buildInfoRow('Phone Number', '+1 (212) 555-0143', primaryText, secondaryText, borderColor),
            _buildInfoRow('Email Address', 'nusrat.jahan@gmail.com', primaryText, secondaryText, borderColor),
            _buildInfoRow('Passport Number', 'P94365056', primaryText, secondaryText, borderColor),
            _buildInfoRow('Passport Expiry', '2032-12-31', primaryText, secondaryText, borderColor),
            _buildInfoRow('National ID (NID)', 'NID-9534061310', primaryText, secondaryText, borderColor),
            _buildInfoRow('Residential Address', 'Primary Residential Address', primaryText, secondaryText, borderColor),
            _buildInfoRow('Target Country', client.country, primaryText, secondaryText, borderColor),
            _buildInfoRow('Travel Purpose', 'Immigration & Tourism', primaryText, secondaryText, borderColor),
            _buildInfoRow('Service Package', client.visaType, primaryText, secondaryText, borderColor),
            _buildInfoRow('Assigned Consultant', 'Tariqul Islam', primaryText, secondaryText, borderColor),
            _buildInfoRow('Referral Agent', 'Website', primaryText, secondaryText, borderColor, isLast: true),
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
                  style: GoogleFonts.figtree(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: primaryText,
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
                    style: GoogleFonts.figtree(
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
                          style: GoogleFonts.figtree(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: primaryText,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'National_ID_/_Passport.pdf · 1.8 MB',
                          style: GoogleFonts.figtree(
                            fontSize: 12.sp,
                            color: secondaryText,
                          ),
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
                      style: GoogleFonts.figtree(
                        fontSize: 12.sp,
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
                    style: GoogleFonts.figtree(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: primaryText,
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
                      style: GoogleFonts.figtree(
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
                style: GoogleFonts.figtree(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: secondaryText,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Documents: 2/6 collected',
                style: GoogleFonts.figtree(
                  fontSize: 12.sp,
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
            _buildInfoRow('Total Package Fee', '\$4,500.00', primaryText, secondaryText, borderColor),
            _buildInfoRow('Paid Amount', '\$1,500.00', primaryText, secondaryText, borderColor),
            _buildInfoRow('Due Balance', '\$3,000.00', primaryText, secondaryText, borderColor),
            _buildInfoRow('Payment Status', 'Partially Paid', primaryText, secondaryText, borderColor, isLast: true),
          ],
        );
      case 4: // Activity
        return Column(
          children: [
            _buildActivityItem('Initial Lead Conversion', 'Converted from Facebook ad inquiry to VIP file.', 'Sep 20, 2026', primaryText, secondaryText),
            _buildActivityItem('Document Pack Collected', 'Passport and 6-month bank statement received.', 'Sep 22, 2026', primaryText, secondaryText),
            _buildActivityItem('Embassy Solvency Check', 'Financial solvency verified by senior officer.', 'Sep 24, 2026', primaryText, secondaryText),
            _buildActivityItem('Appointment Booked', 'Biometrics slot scheduled at VFS Global.', 'Sep 25, 2026', primaryText, secondaryText, isLast: true),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildInfoRow(String label, String value, Color primaryText, Color secondaryText, Color borderColor, {bool isLast = false}) {
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
            style: GoogleFonts.figtree(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: secondaryText,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.figtree(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: primaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String desc, String date, Color primaryText, Color secondaryText, {bool isLast = false}) {
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
                      style: GoogleFonts.figtree(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: primaryText,
                      ),
                    ),
                    Text(
                      date,
                      style: GoogleFonts.figtree(
                        fontSize: 11.sp,
                        color: secondaryText,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  desc,
                  style: GoogleFonts.figtree(
                    fontSize: 12.sp,
                    color: secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

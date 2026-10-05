import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../../../../core/widgets/app_button.dart';
import '../model/visa_file_model.dart';
import '../provider/visa_file_provider.dart';
import 'change_status_modal.dart';
import 'upload_doc_modal.dart';

class VisaFileDetailsModal extends ConsumerWidget {
  final VisaFileItem visaFile;

  const VisaFileDetailsModal({
    super.key,
    required this.visaFile,
  });

  static void show(BuildContext context, VisaFileItem visaFile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VisaFileDetailsModal(visaFile: visaFile),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Re-watch the latest state for this visa file
    final state = ref.watch(quickTechVisaFilesProvider);
    final currentFile = state.files.firstWhere(
      (f) => f.fileId == visaFile.fileId,
      orElse: () => visaFile,
    );

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final modalBg = isDark ? AppColors.darkSurface : AppColors.background;
    final cardBg = isDark ? AppColors.darkSurfaceHigh : AppColors.surface;
    final primaryText = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final secondaryText = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    final stepLabels = ['New', 'Documents', 'Processing', 'Submitted', 'Review'];

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: modalBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: File ID, Name & Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'File ${currentFile.fileId}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryDark,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        currentFile.clientName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: primaryText,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: currentFile.status.bgColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    currentFile.status.label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: currentFile.status.textColor,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // WORKFLOW PROGRESSION Title
            Text(
              'WORKFLOW PROGRESSION',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: secondaryText,
                    letterSpacing: 0.6,
                  ),
            ),
            SizedBox(height: 12.h),

            // Stepper Row
            _buildStepperRow(
              context: context,
              currentStepIndex: currentFile.currentStepIndex,
              stepLabels: stepLabels,
              isDark: isDark,
            ),
            SizedBox(height: 20.h),

            // Details Container Box
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: isDark ? AppColors.darkLine : AppColors.line,
                ),
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    context,
                    'Country & Visa',
                    '${currentFile.country} · ${currentFile.visaCategory}',
                    primaryText,
                    secondaryText,
                  ),
                  SizedBox(height: 10.h),
                  _buildDetailRow(
                    context,
                    'Application Type',
                    currentFile.applicationType,
                    primaryText,
                    secondaryText,
                  ),
                  SizedBox(height: 10.h),
                  _buildDetailRow(
                    context,
                    'Target Travel Date',
                    currentFile.targetTravelDate,
                    primaryText,
                    secondaryText,
                  ),
                  SizedBox(height: 10.h),
                  _buildDetailRow(
                    context,
                    'Package Price',
                    '\$${currentFile.packagePrice.toStringAsFixed(2)}',
                    primaryText,
                    secondaryText,
                  ),
                  SizedBox(height: 10.h),
                  _buildDetailRow(
                    context,
                    'Payment Balance',
                    'Paid: \$${currentFile.paidAmount.toInt()} | Due: \$${currentFile.dueAmount.toInt()}',
                    AppColors.secondaryDark,
                    secondaryText,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // DOCUMENT CHECKLIST Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DOCUMENT CHECKLIST (${currentFile.collectedDocsCount}/${currentFile.totalDocsCount})',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: secondaryText,
                        letterSpacing: 0.5,
                      ),
                ),
                GestureDetector(
                  onTap: () => UploadDocModal.show(context, currentFile),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.filePlus,
                        size: 15.sp,
                        color: AppColors.primaryDark,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Add Document',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryDark,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Document Items or Empty State
            if (currentFile.documents.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  'No documents uploaded yet. Tap \'Add Document\' above.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: secondaryText,
                      ),
                ),
              )
            else
              Column(
                children: currentFile.documents.map((doc) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: isDark ? AppColors.darkLine : AppColors.line,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.fileCheck,
                          size: 18.sp,
                          color: AppColors.secondary,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doc.title,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: primaryText,
                                    ),
                              ),
                              Text(
                                'Uploaded: ${doc.uploadedDate}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: secondaryText,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            SizedBox(height: 24.h),

            // Advance / Update File Stage Button
            Center(
              child: AppButton(
                text: 'Advance / Update File Stage',
                icon: LucideIcons.refreshCw,
                variant: AppButtonVariant.text,
                textColor: AppColors.primaryDark,
                fontSize: 14.sp,
                onPressed: () => ChangeStatusModal.show(context, currentFile),
              ),
            ),
            SizedBox(height: 16.h),

            // Bottom Right Done Button
            Align(
              alignment: Alignment.centerRight,
              child: AppButton(
                text: 'Done',
                backgroundColor: AppColors.primaryDark,
                textColor: AppColors.surface,
                height: 42.h,
                fontSize: 14.sp,
                horizontalPadding: 28.w,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    Color valueColor,
    Color labelColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: labelColor,
              ),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: valueColor,
                ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildStepperRow({
    required BuildContext context,
    required int currentStepIndex,
    required List<String> stepLabels,
    required bool isDark,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(stepLabels.length, (index) {
          final isDone = index <= currentStepIndex;
          final isCurrent = index == currentStepIndex;

          return Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 26.r,
                    height: 26.r,
                    decoration: BoxDecoration(
                      color: isDone
                          ? AppColors.secondary
                          : (isDark ? AppColors.darkSurfaceHigh : AppColors.line),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: isDone
                        ? Icon(
                            LucideIcons.check,
                            size: 15.sp,
                            color: AppColors.surface,
                          )
                        : Text(
                            '${index + 1}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                                ),
                          ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    stepLabels[index],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 11.sp,
                          fontWeight: isCurrent || isDone ? FontWeight.bold : FontWeight.w500,
                          color: isDone
                              ? AppColors.secondaryDark
                              : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
                        ),
                  ),
                ],
              ),
              if (index < stepLabels.length - 1) ...[
                Container(
                  width: 28.w,
                  height: 2.h,
                  margin: EdgeInsets.only(bottom: 18.h, left: 4.w, right: 4.w),
                  color: (index < currentStepIndex)
                      ? AppColors.secondary
                      : (isDark ? AppColors.darkLine : AppColors.line),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }
}

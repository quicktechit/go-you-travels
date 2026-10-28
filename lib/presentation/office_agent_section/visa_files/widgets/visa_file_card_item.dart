import '../../../../core/constant/const.dart';
import '../model/visa_file_model.dart';
import 'visa_file_details_modal.dart';

class VisaFileCardItem extends StatelessWidget {
  final VisaFileItem visaFile;

  const VisaFileCardItem({
    super.key,
    required this.visaFile,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final primaryTextColor = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final secondaryTextColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

    final stepLabels = ['New', 'Documents', 'Processing', 'Submitted', 'Review'];

    final isDocsComplete = visaFile.collectedDocsCount >= visaFile.totalDocsCount;
    final docsColor = isDocsComplete ? AppColors.secondaryDark : AppColors.orange;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
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
      child: InkWell(
        onTap: () => VisaFileDetailsModal.show(context, visaFile),
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: File ID & Status Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    visaFile.fileId,
                    style: GoogleFonts.figtree(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: visaFile.status.bgColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      visaFile.status.label,
                      style: GoogleFonts.figtree(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.bold,
                        color: visaFile.status.textColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),

              // Client Name
              Text(
                visaFile.clientName,
                style: GoogleFonts.figtree(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),

              // Visa Category · Country (Application Type)
              Text(
                '${visaFile.visaCategory} · ${visaFile.country} (${visaFile.applicationType})',
                style: GoogleFonts.figtree(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w500,
                  color: secondaryTextColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (visaFile.referralCode != null && visaFile.referralCode!.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      LucideIcons.userCheck,
                      size: 13.sp,
                      color: AppColors.primaryDark,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Ref Agent: ${visaFile.referralCode} (${visaFile.referralAgentType ?? 'Agent'})',
                      style: GoogleFonts.figtree(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 16.h),

              // Workflow Stepper
              _buildStepperRow(
                currentStepIndex: visaFile.currentStepIndex,
                stepLabels: stepLabels,
                isDark: isDark,
              ),
              SizedBox(height: 16.h),

              // Horizontal Divider
              Container(
                height: 1.h,
                color: isDark ? AppColors.darkLine : AppColors.line,
              ),
              SizedBox(height: 12.h),

              // Bottom Info Row: Docs collected & Travel date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        LucideIcons.fileText,
                        size: 15.sp,
                        color: docsColor,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Docs: ${visaFile.collectedDocsCount}/${visaFile.totalDocsCount} collected',
                        style: GoogleFonts.figtree(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.bold,
                          color: docsColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Travel: ${visaFile.targetTravelDate}',
                    style: GoogleFonts.figtree(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepperRow({
    required int currentStepIndex,
    required List<String> stepLabels,
    required bool isDark,
  }) {
    final nextStepIndex = currentStepIndex < stepLabels.length - 1 ? currentStepIndex + 1 : -1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(stepLabels.length, (index) {
        final isDone = index <= currentStepIndex;
        final isLoading = index == nextStepIndex;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 24.r,
                      height: 24.r,
                      decoration: BoxDecoration(
                        color: isDone
                            ? AppColors.secondary
                            : isLoading
                                ? (isDark
                                    ? AppColors.primaryDark.withValues(alpha: 0.25)
                                    : AppColors.primaryLight.withValues(alpha: 0.2))
                                : (isDark ? AppColors.darkSurfaceHigh : AppColors.line),
                        shape: BoxShape.circle,
                        border: isLoading
                            ? Border.all(color: AppColors.primaryDark, width: 1.5.w)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: isDone
                          ? Icon(
                              LucideIcons.check,
                              size: 14.sp,
                              color: AppColors.surface,
                            )
                          : isLoading
                              ? Icon(
                                  LucideIcons.clock,
                                  size: 14.sp,
                                  color: AppColors.primaryDark,
                                )
                              : Text(
                                  '${index + 1}',
                                  style: GoogleFonts.figtree(
                                    fontSize: 11.5.sp,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                                  ),
                                ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      stepLabels[index],
                      style: GoogleFonts.figtree(
                        fontSize: 10.5.sp,
                        fontWeight: isDone || isLoading ? FontWeight.bold : FontWeight.w500,
                        color: isDone
                            ? AppColors.secondaryDark
                            : isLoading
                                ? AppColors.primaryDark
                                : (isDark ? AppColors.darkTextSecondary : AppColors.textSecondary),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              if (index < stepLabels.length - 1)
                Container(
                  width: 14.w,
                  height: 2.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  color: (index < currentStepIndex)
                      ? AppColors.secondary
                      : (index == currentStepIndex)
                          ? AppColors.primary
                          : (isDark ? AppColors.darkLine : AppColors.line),
                ),
            ],
          ),
        );
      }),
    );
  }
}

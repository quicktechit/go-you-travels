import '../../../../core/constant/const.dart';
import '../../../../core/widgets/app_button.dart';
import '../model/visa_file_model.dart';
import '../provider/visa_file_provider.dart';

class ChangeStatusModal extends ConsumerWidget {
  final VisaFileItem visaFile;

  const ChangeStatusModal({
    super.key,
    required this.visaFile,
  });

  static void show(BuildContext context, VisaFileItem visaFile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChangeStatusModal(visaFile: visaFile),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(quickTechVisaFilesProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final statuses = VisaFileStatus.values;

    final modalBg = isDark ? AppColors.darkSurface : AppColors.background;
    final primaryText = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

    return Container(
      height: 0.85.sh,
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: modalBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Select New File Status',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: primaryText,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16.h),

          // Status Options List
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: statuses.map((status) {
                  final isSelected = visaFile.status == status;

                  final itemBg = isSelected
                      ? (isDark ? AppColors.primaryDark.withValues(alpha: 0.3) : AppColors.primaryLight.withValues(alpha: 0.15))
                      : (isDark ? AppColors.darkSurfaceHigh : AppColors.surface);

                  final itemText = isSelected
                      ? AppColors.primaryDark
                      : (isDark ? AppColors.darkTextPrimary : AppColors.textPrimary);

                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: InkWell(
                      onTap: () {
                        notifier.updateFileStatus(visaFile.fileId, status);
                        Navigator.of(context).pop();
                      },
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: itemBg,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : (isDark ? AppColors.darkLine : AppColors.line),
                            width: 1.w,
                          ),
                        ),
                        child: Text(
                          status.label,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: itemText,
                              ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Cancel Action
          Align(
            alignment: Alignment.centerRight,
            child: AppButton(
              text: 'Cancel',
              variant: AppButtonVariant.text,
              textColor: AppColors.primaryDark,
              fontSize: 14.sp,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}

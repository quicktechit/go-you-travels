import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../presentation/office_agent_section/visa_files/model/visa_file_model.dart';
import '../../presentation/office_agent_section/visa_files/provider/visa_file_provider.dart';
import '../constant/const.dart';

class UploadDocModal extends HookConsumerWidget {
  final VisaFileItem? visaFile;
  final Function(String docType, String source)? onUpload;

  const UploadDocModal({
    super.key,
    this.visaFile,
    this.onUpload,
  });

  static void show(
    BuildContext context, {
    VisaFileItem? visaFile,
    Function(String docType, String source)? onUpload,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => UploadDocModal(visaFile: visaFile, onUpload: onUpload),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedDocType = useState<String>('National ID / Passport');

    final docTypes = [
      'National ID / Passport',
      'Bank Statement & Balance Cert',
      'Sponsorship Certificate',
      'Police Clearance',
      'Employment Letter',
      'Medical Report',
    ];

    void handleUpload(String source) {
      if (visaFile != null) {
        ref.read(quickTechVisaFilesProvider.notifier).addDocument(
              visaFile!.fileId,
              '${selectedDocType.value} ($source)',
              selectedDocType.value,
            );
      }
      if (onUpload != null) {
        onUpload!(selectedDocType.value, source);
      } else if (visaFile == null) {
        Fluttertoast.showToast(msg: "Uploaded ${selectedDocType.value} via $source");
      }
      Navigator.of(context).pop();
    }

    final modalBg = isDark ? AppColors.darkSurface : AppColors.background;
    final primaryText = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: modalBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Upload Doc Icon & Title
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LucideIcons.cloudUpload,
                  size: 20.sp,
                  color: AppColors.surface,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Upload Doc',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: primaryText,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Label: Document Type
          Text(
            'Document Type',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                ),
          ),
          SizedBox(height: 6.h),

          // Dropdown Field
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurfaceHigh : AppColors.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isDark ? AppColors.darkLine : AppColors.line,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedDocType.value,
                isDense: true,
                isExpanded: true,
                dropdownColor: isDark ? AppColors.darkSurface : AppColors.surface,
                items: docTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(
                      type,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: primaryText,
                          ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) selectedDocType.value = val;
                },
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Select Document Source
          Text(
            'Select Document Source:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryText,
                ),
          ),
          SizedBox(height: 14.h),

          // Source Options Row
          Row(
            children: [
              Expanded(
                child: _buildSourceButton(
                  context: context,
                  icon: LucideIcons.camera,
                  label: 'Camera',
                  onTap: () => handleUpload('Camera'),
                  isDark: isDark,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _buildSourceButton(
                  context: context,
                  icon: LucideIcons.image,
                  label: 'Gallery',
                  onTap: () => handleUpload('Gallery'),
                  isDark: isDark,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _buildSourceButton(
                  context: context,
                  icon: LucideIcons.paperclip,
                  label: 'File',
                  onTap: () => handleUpload('File'),
                  isDark: isDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

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

  Widget _buildSourceButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurfaceHigh : AppColors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isDark ? AppColors.darkLine : AppColors.line,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: AppColors.primaryDark,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

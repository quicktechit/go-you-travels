import '../../../../core/constant/const.dart';
import '../../../../core/widgets/app_button.dart';
import '../model/lead_model.dart';
import '../provider/lead_provider.dart';

class CreateLeadModal extends HookConsumerWidget {
  const CreateLeadModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CreateLeadModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final sheetBg = isDark ? AppColors.darkSurface : AppColors.background;
    final inputBg = isDark ? AppColors.darkSurfaceHigh : AppColors.background;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;

    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final countryController = useTextEditingController(text: 'Canada');
    final visaController = useTextEditingController(text: 'Express Entry & Work Visa');
    final sourceController = useTextEditingController(text: 'Facebook Ads');
    final notesController = useTextEditingController();

    final selectedPriority = useState<LeadPriority>(LeadPriority.medium);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: sheetBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag Indicator handle
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkLine : AppColors.line,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),

              // Title
              Text(
                'Create New Lead Inquiry',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20.h),

              // 1. Customer Full Name *
              AppTextField(
                controller: nameController,
                hint: 'Customer Full Name *',
                fillColor: inputBg,
                borderColor: borderColor,
                borderRadius: 10,
              ),
              SizedBox(height: 12.h),

              // 2. Phone Number *
              AppTextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                hint: 'Phone Number *',
                fillColor: inputBg,
                borderColor: borderColor,
                borderRadius: 10,
              ),
              SizedBox(height: 12.h),

              // 3. Destination Country
              AppTextField(
                controller: countryController,
                label: 'Destination Country',
                fillColor: inputBg,
                borderColor: borderColor,
                borderRadius: 10,
              ),
              SizedBox(height: 12.h),

              // 4. Visa / Service Interest
              AppTextField(
                controller: visaController,
                label: 'Visa / Service Interest',
                fillColor: inputBg,
                borderColor: borderColor,
                borderRadius: 10,
              ),
              SizedBox(height: 12.h),

              // 5. Lead Source
              AppTextField(
                controller: sourceController,
                label: 'Lead Source',
                fillColor: inputBg,
                borderColor: borderColor,
                borderRadius: 10,
              ),
              SizedBox(height: 12.h),

              // 6. Initial Client Notes
              AppTextField(
                controller: notesController,
                hint: 'Initial Client Notes',
                maxLines: 2,
                fillColor: inputBg,
                borderColor: borderColor,
                borderRadius: 10,
              ),
              SizedBox(height: 24.h),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    text: 'Cancel',
                    variant: AppButtonVariant.text,
                    textColor: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.primaryDark,
                    fontSize: 15.sp,
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 12.w),
                  AppButton(width: 115.w,
                    text: 'Save Lead',
                    backgroundColor: AppColors.primaryDark,
                    textColor: AppColors.surface,
                    height: 44.h,
                    fontSize: 15.sp,
                    horizontalPadding: 24.w,
                    onPressed: () {
                      if (nameController.text.trim().isEmpty) {
                        Fluttertoast.showToast(msg: "Please enter customer name");
                        return;
                      }
                      if (phoneController.text.trim().isEmpty) {
                        Fluttertoast.showToast(msg: "Please enter phone number");
                        return;
                      }

                      final newLead = LeadItem(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: nameController.text.trim(),
                        phone: phoneController.text.trim(),
                        destinationCountry: countryController.text.trim(),
                        visaInterest: visaController.text.trim(),
                        leadSource: sourceController.text.trim(),
                        status: LeadStatus.newLead,
                        priority: selectedPriority.value,
                        notes: notesController.text.trim(),
                        createdAt: DateTime.now(),
                      );

                      ref.read(quickTechLeadProvider.notifier).addNewLead(newLead);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

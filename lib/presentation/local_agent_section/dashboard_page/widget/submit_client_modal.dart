import '../../../../core/constant/const.dart';
import '../model/local_agent_dashboard_state.dart';
import '../provider/local_agent_dashboard_provider.dart';

class SubmitClientModal extends HookConsumerWidget {
  const SubmitClientModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SubmitClientModal(),
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
    final passportController = useTextEditingController();
    final countryController = useTextEditingController(text: 'Canada');
    final visaController = useTextEditingController(text: 'Tourist / Work Visa');

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: sheetBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 28.h),
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
                'Submit Client',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20.h),

              // 1. Client Full Name *
              AppTextField(
                controller: nameController,
                hint: 'Client Full Name *',
                fillColor: inputBg,
                borderColor: borderColor,
                borderRadius: 12,
              ),
              SizedBox(height: 14.h),

              // 2. Phone Number *
              AppTextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                hint: 'Phone Number *',
                fillColor: inputBg,
                borderColor: borderColor,
                borderRadius: 12,
              ),
              SizedBox(height: 14.h),

              // 3. Passport Number (Optional)
              AppTextField(
                controller: passportController,
                hint: 'Passport Number (Optional)',
                fillColor: inputBg,
                borderColor: borderColor,
                borderRadius: 12,
              ),
              SizedBox(height: 14.h),

              // 4. Target Country
              AppTextField(
                controller: countryController,
                label: 'Target Country',
                fillColor: inputBg,
                borderColor: borderColor,
                borderRadius: 12,
              ),
              SizedBox(height: 14.h),

              // 5. Service / Visa Type
              AppTextField(
                controller: visaController,
                label: 'Service / Visa Type',
                fillColor: inputBg,
                borderColor: borderColor,
                borderRadius: 12,
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
                  AppButton(
                    width: 150.w,
                    text: 'Submit Client',
                    backgroundColor: AppColors.primaryDark,
                    textColor: Colors.white,
                    height: 48.h,
                    fontSize: 15.sp,
                    borderRadius: 12,
                    onPressed: () {
                      if (nameController.text.trim().isEmpty) {
                        Fluttertoast.showToast(msg: "Please enter client full name");
                        return;
                      }
                      if (phoneController.text.trim().isEmpty) {
                        Fluttertoast.showToast(msg: "Please enter phone number");
                        return;
                      }

                      final newClient = SubmittedClient(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: nameController.text.trim(),
                        visaType: visaController.text.trim(),
                        country: countryController.text.trim(),
                        packageAmount: 4500.0,
                        commissionAmount: 450.0,
                        status: ClientSubmissionStatus.newFileCreated,
                        createdAt: DateTime.now(),
                      );

                      ref.read(localAgentDashboardProvider.notifier).addClient(newClient);
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

import '../../../../core/constant/const.dart';
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

    final sheetBg = isDark ? AppColors.darkSurface : const Color(0xFFF1F2F6);
    final inputBg = isDark ? AppColors.darkSurfaceHigh : const Color(0xFFF8FAFC);
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
                style: GoogleFonts.figtree(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.figtree(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.primaryDark,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  ElevatedButton(
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D4ED8),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Save Lead',
                      style: GoogleFonts.figtree(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
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
}

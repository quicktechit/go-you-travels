import '../../../../core/constant/const.dart';
import '../provider/visa_file_provider.dart';

class CreateVisaFileModal extends HookConsumerWidget {
  const CreateVisaFileModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CreateVisaFileModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final sheetBg = isDark ? AppColors.darkSurface : AppColors.background;
    final inputBg = isDark ? AppColors.darkSurfaceHigh : AppColors.background;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final dropdownBg = isDark ? AppColors.darkSurfaceHigh : AppColors.surface;

    final clientNameController = useTextEditingController();
    final travelDateController = useTextEditingController(text: '2026-12-01');
    final packagePriceController = useTextEditingController(text: '5000');
    final paidAmountController = useTextEditingController(text: '2000');
    final referralCodeController = useTextEditingController();

    final selectedCountry = useState<String>('Canada');
    final selectedVisaCategory = useState<String>('Visitor & Work Permit');
    final selectedApplicationType = useState<String>('Individual');

    final countries = const [
      'Canada',
      'Saudi Arabia',
      'United Kingdom',
      'USA',
      'Malaysia',
      'United Arab Emirates',
      'Turkey',
      'Australia',
      'Schengen Area',
    ];

    final visaCategories = const [
      'Visitor & Work Permit',
      'Tourist Visa',
      'Umrah Visa',
      'Student Visa',
      'Business Visa',
      'Family Visit Visa',
      'Work Visa',
    ];

    final applicationTypes = const [
      'Individual',
      'Family (2 Persons)',
      'Family (3 Persons)',
      'Family (4 Persons)',
      'Family (5+ Persons)',
      'Group Application',
    ];

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
          physics: const BouncingScrollPhysics(),
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
                'Create New Visa File',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20.h),

              // 1. Client Full Name *
              AppTextField(
                controller: clientNameController,
                hint: 'Client Full Name *',
                fillColor: inputBg,
                borderColor: borderColor,
                borderRadius: 10,
              ),
              SizedBox(height: 12.h),

              // 2. Destination Country Dropdown
              AppDropdown<String>(
                label: 'Destination Country',
                value: selectedCountry.value,
                dropdownColor: dropdownBg,
                borderColor: borderColor,
                borderRadius: 10,
                items: countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(
                      country,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                          ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) selectedCountry.value = val;
                },
              ),
              SizedBox(height: 12.h),

              // 3. Visa Category Dropdown
              AppDropdown<String>(
                label: 'Visa Category',
                value: selectedVisaCategory.value,
                dropdownColor: dropdownBg,
                borderColor: borderColor,
                borderRadius: 10,
                items: visaCategories.map((cat) {
                  return DropdownMenuItem<String>(
                    value: cat,
                    child: Text(
                      cat,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                          ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) selectedVisaCategory.value = val;
                },
              ),
              SizedBox(height: 12.h),

              // 4. Application Type Dropdown
              AppDropdown<String>(
                label: 'Application Type',
                value: selectedApplicationType.value,
                dropdownColor: dropdownBg,
                borderColor: borderColor,
                borderRadius: 10,
                items: applicationTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(
                      type,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
                          ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) selectedApplicationType.value = val;
                },
              ),
              SizedBox(height: 12.h),

              // 5. Agent Referral Code Text Field
              AppTextField(
                controller: referralCodeController,
                label: 'Agent Referral Code (Local / Paid Agent)',
                hint: 'e.g. GYT-PRT-2811 or GYT-PA-5015',
                fillColor: inputBg,
                borderColor: borderColor,
                borderRadius: 10,
              ),
              SizedBox(height: 12.h),

              // 6. Target Travel Date
              AppTextField(
                controller: travelDateController,
                label: 'Target Travel Date',
                hint: 'YYYY-MM-DD',
                prefixIcon: Icons.calendar_today_rounded,
                fillColor: inputBg,
                borderColor: borderColor,
                borderRadius: 10,
              ),
              SizedBox(height: 12.h),

              // 7. Pricing Row (Package Price & Paid Amount)
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: packagePriceController,
                      label: 'Package Price (\$)',
                      keyboardType: TextInputType.number,
                      hint: '0.00',
                      fillColor: inputBg,
                      borderColor: borderColor,
                      borderRadius: 10,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: AppTextField(
                      controller: paidAmountController,
                      label: 'Paid Amount (\$)',
                      keyboardType: TextInputType.number,
                      hint: '0.00',
                      fillColor: inputBg,
                      borderColor: borderColor,
                      borderRadius: 10,
                    ),
                  ),
                ],
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
                    width: 135.w,
                    text: 'Create File',
                    backgroundColor: AppColors.primaryDark,
                    textColor: AppColors.surface,
                    height: 44.h,
                    fontSize: 15.sp,
                    horizontalPadding: 20.w,
                    onPressed: () {
                      if (clientNameController.text.trim().isEmpty) {
                        Fluttertoast.showToast(msg: "Please enter client name");
                        return;
                      }

                      final packagePrice = double.tryParse(packagePriceController.text.trim()) ?? 0.0;
                      final paidAmount = double.tryParse(paidAmountController.text.trim()) ?? 0.0;

                      ref.read(quickTechVisaFilesProvider.notifier).addVisaFile(
                        clientName: clientNameController.text.trim(),
                        visaCategory: selectedVisaCategory.value,
                        country: selectedCountry.value,
                        applicationType: selectedApplicationType.value,
                        targetTravelDate: travelDateController.text.trim().isEmpty
                            ? '2026-12-01'
                            : travelDateController.text.trim(),
                        packagePrice: packagePrice,
                        paidAmount: paidAmount,
                        referralCode: referralCodeController.text.trim(),
                      );

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

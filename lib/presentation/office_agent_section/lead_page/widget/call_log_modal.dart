import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../../../../core/widgets/app_button.dart';
import '../model/lead_model.dart';
import '../provider/lead_provider.dart';

class CallLogModal extends HookConsumerWidget {
  final LeadItem lead;

  const CallLogModal({
    super.key,
    required this.lead,
  });

  static Future<void> show(BuildContext context, {required LeadItem lead}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CallLogModal(lead: lead),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final sheetBg = isDark ? AppColors.darkSurface : AppColors.background;
    final cardBg = isDark ? AppColors.darkSurfaceHigh : AppColors.background;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;

    final selectedResult = useState<String>('Scheduled Visit');
    final followUpTime = useState<String>('Tomorrow, 10:00 AM');
    final notesController = useTextEditingController();

    final callResults = [
      'Interested',
      'Busy / Call Back',
      'Not Reachable',
      'Scheduled Visit',
      'Wrong Number',
      'Not Interested',
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
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle Bar
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

              // Header Row with Phone Icon and Name/Phone
              Row(
                children: [
                  Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.primary.withValues(alpha: 0.2)
                          : AppColors.primaryLight.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LucideIcons.phoneCall,
                      size: 22.sp,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Calling ${lead.name}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          lead.phone,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Launch Device Phone Dialer Primary Button
              AppButton(
                text: 'Launch Device Phone Dialer',
                icon: LucideIcons.phone,
                height: 48.h,
                fontSize: 15.sp,
                onPressed: () {
                  Fluttertoast.showToast(msg: "Launching dialer for ${lead.phone}");
                },
              ),
              SizedBox(height: 20.h),

              // Select Call Result Label
              Text(
                'Select Call Result:',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.textPrimary,
                    ),
              ),
              SizedBox(height: 12.h),

              // 2x3 Grid of Call Results
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3.2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                ),
                itemCount: callResults.length,
                itemBuilder: (context, index) {
                  final result = callResults[index];
                  final isSelected = selectedResult.value == result;

                  return GestureDetector(
                    onTap: () => selectedResult.value = result,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryDark
                            : cardBg,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryDark
                              : borderColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        result,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 13.sp,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.surface
                                  : (isDark
                                      ? AppColors.darkTextPrimary
                                      : AppColors.textPrimary),
                            ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),

              // Next Follow-up Date & Time Picker Container
              GestureDetector(
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (pickedDate == null || !context.mounted) return;

                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 10, minute: 0),
                  );
                  if (pickedTime == null || !context.mounted) return;

                  final formattedTime = pickedTime.format(context);
                  followUpTime.value =
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}, $formattedTime";
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: borderColor, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Next Follow-up Date & Time',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.textSecondary,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        followUpTime.value,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.textPrimary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Call Discussion Notes
              AppTextField(
                controller: notesController,
                hint: 'Call Discussion Notes',
                maxLines: 2,

                borderRadius: 12,
              ),
              SizedBox(height: 24.h),

              // Bottom Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    width: 115.w,
                    text: 'Cancel',
                    variant: AppButtonVariant.text,
                    textColor: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.primaryDark,
                    fontSize: 15.sp,
                    onPressed: () => Navigator.pop(context),
                  ),
                  AppButton(
                    width: 135.w,
                    text: 'Save Call Log',
                    backgroundColor: AppColors.primaryDark,
                    textColor: AppColors.surface,
                    height: 48.h,
                    fontSize: 15.sp,
                    horizontalPadding: 24.w,
                    onPressed: () {
                      ref.read(quickTechLeadProvider.notifier).saveCallLog(
                            leadId: lead.id,
                            callResult: selectedResult.value,
                            followUpTime: followUpTime.value,
                            notes: notesController.text.trim(),
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

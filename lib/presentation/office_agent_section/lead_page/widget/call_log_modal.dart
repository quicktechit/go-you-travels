import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
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

    final sheetBg = isDark ? AppColors.darkSurface : const Color(0xFFF1F2F6);
    final cardBg = isDark ? AppColors.darkSurfaceHigh : const Color(0xFFF8FAFC);
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
                          : const Color(0xFFEFF6FF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LucideIcons.phoneCall,
                      size: 22.sp,
                      color: const Color(0xFF1D4ED8),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Calling ${lead.name}',
                          style: GoogleFonts.figtree(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          lead.phone,
                          style: GoogleFonts.figtree(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
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
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Fluttertoast.showToast(msg: "Launching dialer for ${lead.phone}");
                  },
                  icon: Icon(
                    LucideIcons.phone,
                    size: 18.sp,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Launch Device Phone Dialer',
                    style: GoogleFonts.figtree(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF047857),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Select Call Result Label
              Text(
                'Select Call Result:',
                style: GoogleFonts.figtree(
                  fontSize: 14.sp,
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
                            ? const Color(0xFF1D4ED8)
                            : cardBg,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF1D4ED8)
                              : borderColor,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        result,
                        style: GoogleFonts.figtree(
                          fontSize: 13.sp,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
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
                        style: GoogleFonts.figtree(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        followUpTime.value,
                        style: GoogleFonts.figtree(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
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
                fillColor: cardBg,
                borderColor: borderColor,
                borderRadius: 12,
              ),
              SizedBox(height: 24.h),

              // Bottom Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ElevatedButton(
                    onPressed: () {
                      ref.read(quickTechLeadProvider.notifier).saveCallLog(
                            leadId: lead.id,
                            callResult: selectedResult.value,
                            followUpTime: followUpTime.value,
                            notes: notesController.text.trim(),
                          );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D4ED8),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 28.w,
                        vertical: 14.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Save Call Log',
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

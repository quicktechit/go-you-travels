import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constant/const.dart';
import '../../../../core/widgets/app_button.dart';
import '../model/lead_model.dart';
import '../provider/lead_provider.dart';
import 'call_log_modal.dart';

class LeadDetailsModal extends HookConsumerWidget {
  final LeadItem lead;

  const LeadDetailsModal({super.key, required this.lead});

  static Future<void> show(BuildContext context, {required LeadItem lead}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LeadDetailsModal(lead: lead),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final sheetBg = isDark ? AppColors.darkSurface : AppColors.background;
    final cardBg = isDark ? AppColors.darkSurfaceHigh : AppColors.surface;
    final innerBg = isDark ? AppColors.darkBackground : AppColors.background;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;

    final state = ref.watch(quickTechLeadProvider);
    final notifier = ref.read(quickTechLeadProvider.notifier);

    final currentLead = state.leads.firstWhere(
      (l) => l.id == lead.id,
      orElse: () => lead,
    );

    // Active Tab Index: 0 = Lead Details, 1 = Follow-up History
    final selectedTab = useState<int>(0);
    final isEditingSchedule = useState<bool>(false);

    final followUpDateController = useTextEditingController(
      text: currentLead.nextFollowUpDate,
    );
    final followUpNotesController = useTextEditingController(
      text:
          currentLead.notes ??
          'Looking for healthcare sponsorship. Document checklist shared.',
    );

    final initialChar = currentLead.name.isNotEmpty
        ? currentLead.name[0].toUpperCase()
        : 'L';

    // Filter out 'Converted' from status list as requested
    final availableStatuses = LeadStatus.values
        .where((s) => s != LeadStatus.converted)
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.88,
        decoration: BoxDecoration(
          color: sheetBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
        child: Column(
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkLine : AppColors.line,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),

            // Top Header: Avatar, Name, Lead ID, Close Icon
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
                  alignment: Alignment.center,
                  child: Text(
                    initialChar,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: isDark
                              ? AppColors.primaryLight
                              : AppColors.primaryDark,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentLead.name,
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
                        'Lead ID: LD-${currentLead.id.padLeft(4, '0')} · ${currentLead.destinationCountry}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    LucideIcons.x,
                    size: 20.sp,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Tab Bar Header (Lead Details vs Follow-up History)
            Container(
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: borderColor, width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => selectedTab.value = 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedTab.value == 0
                                  ? AppColors.primaryDark
                                  : Colors.transparent,
                              width: 2.w,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              LucideIcons.info,
                              size: 16.sp,
                              color: selectedTab.value == 0
                                  ? AppColors.primaryDark
                                  : (isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.textSecondary),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'Lead Details',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: selectedTab.value == 0
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: selectedTab.value == 0
                                        ? AppColors.primaryDark
                                        : (isDark
                                              ? AppColors.darkTextSecondary
                                              : AppColors.textSecondary),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => selectedTab.value = 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedTab.value == 1
                                  ? AppColors.primaryDark
                                  : Colors.transparent,
                              width: 2.w,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              LucideIcons.history,
                              size: 16.sp,
                              color: selectedTab.value == 1
                                  ? AppColors.primaryDark
                                  : (isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.textSecondary),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'Follow-up History (${currentLead.history.length})',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: selectedTab.value == 1
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: selectedTab.value == 1
                                        ? AppColors.primaryDark
                                        : (isDark
                                              ? AppColors.darkTextSecondary
                                              : AppColors.textSecondary),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Tab View Body
            Expanded(
              child: selectedTab.value == 0
                  ? _buildLeadDetailsTab(
                      context: context,
                      ref: ref,
                      lead: currentLead,
                      isDark: isDark,
                      cardBg: cardBg,
                      innerBg: innerBg,
                      borderColor: borderColor,
                      notifier: notifier,
                      availableStatuses: availableStatuses,
                      followUpDateController: followUpDateController,
                      followUpNotesController: followUpNotesController,
                      isEditingSchedule: isEditingSchedule,
                    )
                  : _buildFollowUpHistoryTab(
                      context: context,
                      lead: currentLead,
                      isDark: isDark,
                      cardBg: cardBg,
                      innerBg: innerBg,
                      borderColor: borderColor,
                    ),
            ),

            // Bottom Action Bar: Close Button
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.centerRight,
              child: AppButton(
                text: 'Close',
                backgroundColor: AppColors.primaryDark,
                textColor: AppColors.surface,
                height: 44.h,
                fontSize: 15.sp,
                horizontalPadding: 32.w,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- TAB 1: LEAD DETAILS ---
  Widget _buildLeadDetailsTab({
    required BuildContext context,
    required WidgetRef ref,
    required LeadItem lead,
    required bool isDark,
    required Color cardBg,
    required Color innerBg,
    required Color borderColor,
    required QuickTechLeadNotifier notifier,
    required List<LeadStatus> availableStatuses,
    required TextEditingController followUpDateController,
    required TextEditingController followUpNotesController,
    required ValueNotifier<bool> isEditingSchedule,
  }) {
    return ListView(
      children: [
        // 1. Contact Info Card
        Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          LucideIcons.phone,
                          size: 15.sp,
                          color: AppColors.primaryDark,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            lead.phone,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? AppColors.darkTextPrimary
                                      : AppColors.textPrimary,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.mail,
                          size: 15.sp,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.textSecondary,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            lead.email,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.textSecondary,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              AppButton(
                width: 110.w,
                text: 'Dial',
                icon: LucideIcons.phone,
                backgroundColor: AppColors.secondaryDark,
                textColor: AppColors.surface,
                height: 36.h,
                fontSize: 13.sp,
                horizontalPadding: 14.w,
                onPressed: () => CallLogModal.show(context, lead: lead),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // 2. LEAD STATUS Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'LEAD STATUS',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
                  ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isDark
                    ? lead.status.bgColor.withValues(alpha: 0.2)
                    : lead.status.bgColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                lead.status.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: lead.status.primaryColor,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.8,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
          ),
          itemCount: availableStatuses.length,
          itemBuilder: (context, index) {
            final status = availableStatuses[index];
            final isSelected = lead.status == status;

            return GestureDetector(
              onTap: () => notifier.updateLeadStatus(lead.id, status),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryDark : cardBg,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryDark : borderColor,
                    width: 1,
                  ),
                ),
                child: Text(
                  status.label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected
                            ? AppColors.surface
                            : (isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.textPrimary),
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
        SizedBox(height: 16.h),

        // 3. PRIORITY LEVEL Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PRIORITY LEVEL',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
                  ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isDark
                    ? lead.priority.bgColor.withValues(alpha: 0.2)
                    : lead.priority.bgColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                lead.priority.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: lead.priority.color,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: LeadPriority.values.map((priority) {
            final isSelected = lead.priority == priority;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: priority != LeadPriority.urgent ? 8.w : 0,
                ),
                child: GestureDetector(
                  onTap: () => notifier.updateLeadPriority(lead.id, priority),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFC2410C) : cardBg,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFC2410C)
                            : borderColor,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      priority.label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : (isDark
                                      ? AppColors.darkTextPrimary
                                      : AppColors.textPrimary),
                          ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 16.h),

        // 4. Key Values Details Container
        Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Column(
            children: [
              _buildInfoRow(context, 'Service Interest:', lead.visaInterest, isDark),
              SizedBox(height: 10.h),
              _buildInfoRow(
                context,
                'Destination Country:',
                lead.destinationCountry,
                isDark,
              ),
              SizedBox(height: 10.h),
              _buildInfoRow(
                context,
                'Lead Acquisition Source:',
                lead.leadSource,
                isDark,
                valueColor: AppColors.primaryDark,
              ),
              SizedBox(height: 10.h),
              _buildInfoRow(
                context,
                'Assigned Consultant:',
                lead.assignedConsultant,
                isDark,
              ),
              SizedBox(height: 10.h),
              _buildInfoRow(
                context,
                'Total Calling Attempts:',
                '${lead.totalCallingAttempts} calls logged',
                isDark,
                valueColor: AppColors.secondaryDark,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // 5. Next Follow-up Schedule Card
        Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        LucideIcons.calendar,
                        size: 16.sp,
                        color: AppColors.orange,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Next Follow-up Schedule',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.textPrimary,
                            ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      isEditingSchedule.value = !isEditingSchedule.value;
                    },
                    child: Text(
                      isEditingSchedule.value ? 'Cancel' : 'Reschedule',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              if (isEditingSchedule.value) ...[
                // Date & Time Input
                AppTextField(
                  controller: followUpDateController,
                  label: 'Follow-up Date & Time',
                  fillColor: innerBg,
                  borderColor: borderColor,
                  borderRadius: 10,
                ),
                SizedBox(height: 10.h),

                // Counselor Notes Input
                AppTextField(
                  controller: followUpNotesController,
                  label: 'Follow-up / Counselor Notes',
                  maxLines: 2,
                  fillColor: innerBg,
                  borderColor: borderColor,
                  borderRadius: 10,
                ),
                SizedBox(height: 14.h),

                // Save Schedule Button
                AppButton(
                  text: 'Save Schedule Update',
                  backgroundColor: AppColors.primaryDark,
                  textColor: AppColors.surface,
                  height: 42.h,
                  fontSize: 14.sp,
                  onPressed: () {
                    notifier.updateLeadSchedule(
                      leadId: lead.id,
                      followUpTime: followUpDateController.text.trim(),
                      notes: followUpNotesController.text.trim(),
                    );
                    isEditingSchedule.value = false;
                  },
                ),
              ] else ...[
                // Summary View Mode
                Text(
                  lead.nextFollowUpDate,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Notes: ${lead.notes != null && lead.notes!.isNotEmpty ? lead.notes : "Looking for healthcare sponsorship. Document checklist shared."}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                        height: 1.3,
                      ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // --- TAB 2: FOLLOW-UP HISTORY ---
  Widget _buildFollowUpHistoryTab({
    required BuildContext context,
    required LeadItem lead,
    required bool isDark,
    required Color cardBg,
    required Color innerBg,
    required Color borderColor,
  }) {
    if (lead.history.isEmpty) {
      return Center(
        child: Text(
          'No follow-up history logged yet.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
              ),
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: lead.history.length,
      itemBuilder: (context, index) {
        final item = lead.history[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Phone Icon, Title, Logged by, Time
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 34.r,
                    height: 34.r,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LucideIcons.phoneCall,
                      size: 16.sp,
                      color: index == 0
                          ? AppColors.secondaryDark
                          : AppColors.orange,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.textPrimary,
                              ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Logged by: ${item.loggedBy}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    item.timeAgo,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 11.5.sp,
                          color: isDark
                              ? AppColors.darkTextMuted
                              : AppColors.textMuted,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Note Inner Box
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: innerBg,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.note,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDark
                                ? AppColors.darkTextPrimary
                                : AppColors.textPrimary,
                            height: 1.3,
                          ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.clock,
                          size: 13.sp,
                          color: AppColors.orange,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Next Follow-up: ${item.nextFollowUp}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.orange,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    bool isDark, {
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
              ),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color:
                      valueColor ??
                      (isDark ? AppColors.darkTextPrimary : AppColors.textPrimary),
                ),
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

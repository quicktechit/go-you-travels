import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/constant/const.dart';
import '../model/lead_model.dart';
import 'call_log_modal.dart';
import 'lead_details_modal.dart';

class LeadCardItem extends ConsumerWidget {
  final LeadItem lead;

  const LeadCardItem({super.key, required this.lead});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final cardBg = isDark ? AppColors.darkSurface : Colors.white;
    final innerBannerBg = isDark
        ? AppColors.darkSurfaceHigh
        : AppColors.darkTextPrimary;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;

    final initialChar = lead.name.isNotEmpty ? lead.name[0].toUpperCase() : 'L';

    return GestureDetector(
      onTap: () => LeadDetailsModal.show(context, lead: lead),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Avatar Initial, Name, Phone + Country, Status Pill
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              Container(
                width: 42.r,
                height: 42.r,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.primary.withValues(alpha: 0.2)
                      : const Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  initialChar,
                  style: GoogleFonts.figtree(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.primaryLight
                        : AppColors.primaryDark,
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Name & Contact details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lead.name,
                      style: GoogleFonts.figtree(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.textPrimary,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      '${lead.phone} · ${lead.destinationCountry}',
                      style: GoogleFonts.figtree(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),

              // Status Pill
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: isDark
                      ? lead.status.bgColor.withValues(alpha: 0.2)
                      : lead.status.bgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  lead.status.label,
                  style: GoogleFonts.figtree(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: lead.status.primaryColor,
                  ),
                ),
              ),
              SizedBox(width: 8.w),

              // Call Action Button
              GestureDetector(
                onTap: () => CallLogModal.show(context, lead: lead),
                child: Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF064E3B)
                        : const Color(0xFFDCFCE7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.phoneCall,
                    size: 16.sp,
                    color: isDark
                        ? const Color(0xFF34D399)
                        : const Color(0xFF16A34A),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Bottom Container: Visa / Service Interest & Priority
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: innerBannerBg,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    lead.visaInterest,
                    style: GoogleFonts.figtree(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),

                // Priority Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: lead.priority.bgColor,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isDark
                          ? lead.priority.color.withValues(alpha: 0.4)
                          : AppColors.line,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    lead.priority.label,
                    style: GoogleFonts.figtree(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: lead.priority.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}

import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/constant/const.dart';
import '../../lead_page/widget/create_lead_modal.dart';
import '../provider/quick_tech_dashboard_provider.dart';

class DailyWorkflowBanner extends ConsumerWidget {
  const DailyWorkflowBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1D4ED8), // Rich Royal Blue
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D4ED8).withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Workflow Active',
                  style: GoogleFonts.figtree(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '14/20 calls done · 6 follow-ups remaining',
                  style: GoogleFonts.figtree(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.88),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),

          // Right Button "+ New Lead"
          ElevatedButton(
            onPressed: () {
              CreateLeadModal.show(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1E40AF),
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  LucideIcons.plus,
                  size: 16.sp,
                  color: const Color(0xFF1E40AF),
                ),
                SizedBox(width: 4.w),
                Text(
                  'New Lead',
                  style: GoogleFonts.figtree(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E40AF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

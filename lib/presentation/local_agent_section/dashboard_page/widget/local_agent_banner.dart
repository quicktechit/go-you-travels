import '../../../../core/constant/const.dart';
import 'submit_client_modal.dart';

class LocalAgentBanner extends StatelessWidget {
  const LocalAgentBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.teal,
            AppColors.tealDark,
            isDark ? const Color(0xFF115E59) : AppColors.tealLight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.teal.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Local Partner Portal',
                      style: GoogleFonts.figtree(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Submit client referrals & track status and earnings',
                      style: GoogleFonts.figtree(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withValues(alpha: 0.9),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              AppButton(
                width: 150.w,
                text: 'Submit Client',
                backgroundColor: AppColors.background,
                textColor: AppColors.tealDark,
                height: 48.h,
                fontSize: 15.sp,
                icon: Icons.person_add_rounded,
                borderRadius: 12,
                onPressed: () => SubmitClientModal.show(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

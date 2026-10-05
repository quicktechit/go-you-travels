import '../../../core/constant/const.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Blue App Logo Box
        Container(
          width: 68.r,
          height: 68.r,
          alignment: .center,
          padding: .all(5),
          decoration: BoxDecoration(
            color: AppColors.primaryDark, // Rich Blue
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryDark.withValues(alpha: 0.25),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Image.asset('assets/logo/plane.png',color: Colors.white,),
        ),
        SizedBox(height: 16.h),

        // App Name
        Text(
          'Go You Travels',
          style: GoogleFonts.figtree(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6.h),

        // Subtitle
        Text(
          'Enterprise Travel Agency ERP & CRM Mobile System',
          style: GoogleFonts.figtree(
            fontSize: 12.8.sp,
            fontWeight: FontWeight.w400,
            color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

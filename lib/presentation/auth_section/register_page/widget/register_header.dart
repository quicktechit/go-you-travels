import '../../../../core/constant/const.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        // Blue App Logo Box
        Image.asset('assets/logo/appicon.png', scale: 5),
        SizedBox(height: 16.h),

        // App Name
        Text(
          'Go You Travels',
          style: textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6.h),

        // Subtitle
        Text(
          'Agent Registration & Account Onboarding',
          style: textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w400,

          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

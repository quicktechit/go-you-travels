import '../../../../core/constant/const.dart';
import '../provider/register_provider.dart';

class RegisterTopBar extends ConsumerWidget {
  const RegisterTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerProvider);
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back to Login Button
        InkWell(
          onTap: () => context.go(AppRoutes.login),
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withGreen(180).withAlpha(40),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_rounded,
                  size: 16.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Back to Sign In',
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Right Actions: Language Switcher & Theme Toggle
        Row(
          children: [
            // Language selector button
            InkWell(
              onTap: () => ref.read(registerProvider.notifier).toggleLanguage(),
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withGreen(180).withAlpha(40),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.translate_rounded,
                      size: 16.sp,

                    ),
                    SizedBox(width: 6.w),
                    Text(
                      state.selectedLanguage,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // Theme toggle button
            IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).state =
                    isDark ? ThemeMode.light : ThemeMode.dark;
              },
              icon: Icon(
                isDark ? Icons.wb_sunny_rounded : LucideIcons.moon,
                size: 22.sp,
                color: isDark ? AppColors.amber : AppColors.textPrimary,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ],
    );
  }
}

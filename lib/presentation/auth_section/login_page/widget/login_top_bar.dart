import '../../../../core/constant/const.dart';
import '../provider/login_provider.dart';

class LoginTopBar extends ConsumerWidget {
  const LoginTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;
    
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Pill: System Online Status
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withGreen(180).withAlpha(40),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8.r,
                height: 8.r,
                decoration: const BoxDecoration(
                  color: AppColors.secondary, // Emerald Green
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'System Online',
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
           
                ),
              ),
            ],
          ),
        ),

        // Right Actions: Language Switcher & Theme Toggle
        Row(
          children: [
            // Language selector button
            InkWell(
              onTap: () => ref.read(loginProvider.notifier).toggleLanguage(),
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

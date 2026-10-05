import '../../../core/constant/const.dart';
import '../model/user_role.dart';
import '../provider/login_provider.dart';

class LoginCard extends ConsumerStatefulWidget {
  const LoginCard({super.key});

  @override
  ConsumerState<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends ConsumerState<LoginCard> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(loginProvider);
    _emailController = TextEditingController(text: state.emailOrPhone);
    _passwordController = TextEditingController(text: state.password);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? AppColors.darkSurface : AppColors.surface;
    final borderColor = isDark ? AppColors.darkLine : AppColors.line;
    final textDarkColor = isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
    final textMutedColor = isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
    final dropdownBg = isDark ? AppColors.darkSurfaceHigh : AppColors.background;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: borderColor, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Title
          Text(
            'Sign In',
            style: GoogleFonts.figtree(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: textDarkColor,
            ),
          ),
          SizedBox(height: 4.h),

          // Card Subtitle
          Text(
            'Select your role and dashboard to visit below',
            style: GoogleFonts.figtree(
              fontSize: 13.sp,
              color: textMutedColor,
            ),
          ),
          SizedBox(height: 20.h),

          // Role & Target Dashboard Dropdown
          AppDropdown<UserRole>(
            labelWidget: Text(
              'ROLE & TARGET DASHBOARD *',
              style: GoogleFonts.figtree(
                fontSize: 12.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryDark,
                letterSpacing: 0.4,
              ),
            ),
            value: state.selectedRole,
            prefixIcon: state.selectedRole.icon,
            prefixIconColor: state.selectedRole.iconColor,
            borderColor: AppColors.primaryDark,
            dropdownColor: dropdownBg,
            itemHeight: 62.h,
            selectedItemBuilder: (context) {
              return UserRole.values.map((role) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    role.title,
                    style: GoogleFonts.figtree(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: textDarkColor,
                    ),
                  ),
                );
              }).toList();
            },
            items: UserRole.values.map((role) {
              final isSelected = role == state.selectedRole;
              return DropdownMenuItem<UserRole>(
                value: role,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Role Icon
                      Icon(
                        role.icon,
                        size: 20.sp,
                        color: role.iconColor,
                      ),
                      SizedBox(width: 12.w),

                      // Title & Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    role.title,
                                    style: GoogleFonts.figtree(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: textDarkColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (isSelected) ...[
                                  SizedBox(width: 6.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 3.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? AppColors.primaryDark.withValues(alpha: 0.3)
                                          : AppColors.primaryLight.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      'Selected',
                                      style: GoogleFonts.figtree(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w700,
                                        color: isDark ? AppColors.darkTextPrimary : AppColors.primaryDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              role.subtitle,
                              style: GoogleFonts.figtree(
                                fontSize: 11.5.sp,
                                color: textMutedColor,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            onChanged: (role) {
              if (role != null) {
                ref.read(loginProvider.notifier).selectRole(role);
              }
            },
          ),
          SizedBox(height: 18.h),

          // Email or Phone Field
          AppTextField(
            labelText: 'Email or Phone',
            controller: _emailController,
            prefixIcon: Icons.mail_rounded,
            onChanged: (val) {
              ref.read(loginProvider.notifier).updateEmailOrPhone(val);
            },
          ),
          SizedBox(height: 18.h),

          // Password Field
          AppTextField(
            labelText: 'Password',
            controller: _passwordController,
            isPassword: true,
            prefixIcon: Icons.lock_rounded,
            borderColor: borderColor,
            onChanged: (val) {
              ref.read(loginProvider.notifier).updatePassword(val);
            },
          ),
          SizedBox(height: 12.h),

          // Forgot Password Link
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Fluttertoast.showToast(
                  msg: "Forgot password link tapped",
                  toastLength: Toast.LENGTH_SHORT,
                );
              },
              child: Text(
                'Forgot Password?',
                style: GoogleFonts.figtree(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Error Message Banner if any
          if (state.errorMessage != null) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: Theme.of(context).colorScheme.error.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    color: Theme.of(context).colorScheme.error,
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      state.errorMessage!,
                      style: GoogleFonts.figtree(
                        fontSize: 13.sp,
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
          ],

          // Sign In Action Button
          AppButton(
            text: 'Sign In (${state.selectedRole.shortName})',
            isLoading: state.isLoading,
            backgroundColor: AppColors.primary,
            borderRadius: 12.r,
            height: 52.h,
            fontSize: 15.sp,
            onPressed: () async {
              final success = await ref.read(loginProvider.notifier).login();
              if (success && context.mounted) {
                Fluttertoast.showToast(
                  msg: "Logged in successfully as ${state.selectedRole.shortName}",
                  toastLength: Toast.LENGTH_SHORT,
                );
                context.go(AppRoutes.home);
              }
            },
          ),
        ],
      ),
    );
  }
}

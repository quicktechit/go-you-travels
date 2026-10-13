import '../../../../core/constant/const.dart';
import '../../login_page/model/user_role.dart';
import '../provider/register_provider.dart';

class RegisterCard extends ConsumerStatefulWidget {
  const RegisterCard({super.key});

  @override
  ConsumerState<RegisterCard> createState() => _RegisterCardState();
}

class _RegisterCardState extends ConsumerState<RegisterCard> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _referCodeController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(registerProvider);
    _fullNameController = TextEditingController(text: state.fullName);
    _emailController = TextEditingController(text: state.email);
    _phoneController = TextEditingController(text: state.phone);
    _referCodeController = TextEditingController(text: state.referCode);
    _passwordController = TextEditingController(text: state.password);
    _confirmPasswordController = TextEditingController(text: state.confirmPassword);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _referCodeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;

    final borderColor = AppColors.darkTextSecondary.withAlpha(70);
    final dropdownBg = isDark ? AppColors.darkSurfaceHigh : AppColors.background;

    final isRlAccountUser = state.selectedRole == UserRole.rlAccountUser;

    final availableDesignations = getDesignationsForRole(state.selectedRole);
    final currentDesignation = availableDesignations.contains(state.designation)
        ? state.designation
        : (availableDesignations.isNotEmpty ? availableDesignations.first : '');

    final currentOfficeBranch = officeBranchOptions.contains(state.officeBranch)
        ? state.officeBranch
        : officeBranchOptions.first;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: theme.cardColor,
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
            'Create Account',
            style: textTheme.headlineMedium,
          ),
          SizedBox(height: 4.h),

          // Card Subtitle
          Text(
            'Register as an agent or user to access Go You Travels ERP',
            style: textTheme.bodyMedium,
          ),
          SizedBox(height: 20.h),

          // 1. Role Dropdown (Includes all UserRole choices)
          AppDropdown<UserRole>(
            labelWidget: Text(
              'SELECT AGENT ROLE *',
              style: textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.primaryDark,
                letterSpacing: 0.4,
              ),
            ),
            value: state.selectedRole,
            prefixIcon: state.selectedRole.icon,
            itemHeight: 62.h,
            dropdownColor: dropdownBg,
            selectedItemBuilder: (context) {
              return UserRole.values.map((role) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    role.title,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
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
                      Icon(
                        role.icon,
                        size: 20.sp,
                        color: role.iconColor,
                      ),
                      SizedBox(width: 12.w),
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
                                    style: textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
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
                                      style: textTheme.bodySmall?.copyWith(
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
                              style: textTheme.bodySmall?.copyWith(
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
                ref.read(registerProvider.notifier).selectRole(role);
              }
            },
          ),
          SizedBox(height: 18.h),

          // 2. Designation Dropdown (Only for NON-RL Account users)
          if (!isRlAccountUser && availableDesignations.isNotEmpty) ...[
            AppDropdown<String>(
              labelWidget: Text(
                'DESIGNATION (${state.selectedRole.shortName.toUpperCase()}) *',
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryDark,
                  letterSpacing: 0.4,
                ),
              ),
              value: currentDesignation,
              prefixIcon: Icons.badge_rounded,
              dropdownColor: dropdownBg,
              items: availableDesignations.map((designation) {
                return DropdownMenuItem<String>(
                  value: designation,
                  child: Text(
                    designation,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  ref.read(registerProvider.notifier).updateDesignation(val);
                }
              },
            ),
            SizedBox(height: 18.h),
          ],

          // 3. Referral Code (Mandatory) Field
          AppTextField(
            labelText: 'Referral Code (Mandatory) *',
            hint: 'e.g. GYT-REF-8842',
            controller: _referCodeController,
            prefixIcon: Icons.confirmation_number_rounded,
            onChanged: (val) {
              ref.read(registerProvider.notifier).updateReferCode(val);
            },
          ),
          SizedBox(height: 18.h),

          // 4. Full Name Field
          AppTextField(
            labelText: 'Full Name *',
            controller: _fullNameController,
            prefixIcon: Icons.person_rounded,
            onChanged: (val) {
              ref.read(registerProvider.notifier).updateFullName(val);
            },
          ),
          SizedBox(height: 18.h),

          // 5. Email Field
          AppTextField(
            labelText: 'Email Address *',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.mail_rounded,
            onChanged: (val) {
              ref.read(registerProvider.notifier).updateEmail(val);
            },
          ),
          SizedBox(height: 18.h),

          // 6. Phone Field
          AppTextField(
            labelText: 'Phone Number *',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            prefixIcon: Icons.phone_rounded,
            onChanged: (val) {
              ref.read(registerProvider.notifier).updatePhone(val);
            },
          ),
          SizedBox(height: 18.h),

          // 7. Office / Branch Location Dropdown (Only for NON-RL Account users)
          if (!isRlAccountUser) ...[
            AppDropdown<String>(
              labelWidget: Text(
                'OFFICE / BRANCH LOCATION *',
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryDark,
                  letterSpacing: 0.4,
                ),
              ),
              value: currentOfficeBranch,
              prefixIcon: Icons.location_city_rounded,
              dropdownColor: dropdownBg,
              items: officeBranchOptions.map((branch) {
                return DropdownMenuItem<String>(
                  value: branch,
                  child: Text(
                    branch,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  ref.read(registerProvider.notifier).updateOfficeBranch(val);
                }
              },
            ),
            SizedBox(height: 18.h),
          ],

          // 8. Password Field
          AppTextField(
            labelText: 'Password *',
            controller: _passwordController,
            isPassword: true,
            prefixIcon: Icons.lock_rounded,
            onChanged: (val) {
              ref.read(registerProvider.notifier).updatePassword(val);
            },
          ),
          SizedBox(height: 18.h),

          // 9. Confirm Password Field
          AppTextField(
            labelText: 'Confirm Password *',
            controller: _confirmPasswordController,
            isPassword: true,
            prefixIcon: Icons.lock_outline_rounded,
            onChanged: (val) {
              ref.read(registerProvider.notifier).updateConfirmPassword(val);
            },
          ),
          SizedBox(height: 14.h),

          // Terms & Conditions Checkbox Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 24.w,
                height: 24.h,
                child: Checkbox(
                  value: state.acceptTerms,
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  onChanged: (val) {
                    ref.read(registerProvider.notifier).toggleAcceptTerms(val);
                  },
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref.read(registerProvider.notifier).toggleAcceptTerms(!state.acceptTerms);
                  },
                  child: RichText(
                    text: TextSpan(
                      style: textTheme.bodyMedium,
                      children: [
                         TextSpan(text: 'I agree to the ',style: textTheme.titleSmall),
                        TextSpan(
                          text: 'Terms of Service',
                          style: textTheme.titleSmall?.copyWith(
                            color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                         TextSpan(text: ' & ',style: textTheme.titleSmall),
                        TextSpan(
                          text: 'Privacy Policy',
                          style:  textTheme.titleSmall?.copyWith(
                            color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Error Message Banner
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
                      style: textTheme.bodyMedium?.copyWith(
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

          // Register Action Button
          AppButton(
            text: 'Request To Register Account',
            isLoading: state.isLoading,
            backgroundColor: AppColors.primary,
            borderRadius: 12.r,
            height: 52.h,
            fontSize: 15.sp,
            onPressed: () async {
              final success = await ref.read(registerProvider.notifier).register();
              if (success && context.mounted) {
                Fluttertoast.showToast(
                  msg: "Account registered successfully for ${state.selectedRole.shortName}",
                  toastLength: Toast.LENGTH_SHORT,
                );
                context.go(AppRoutes.home);
              }
            },
          ),
          SizedBox(height: 18.h),

          // Sign In Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.go(AppRoutes.login);
                },
                child: Text(
                  'Sign In',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

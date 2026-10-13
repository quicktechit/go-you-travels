import '../../login_page/model/user_role.dart';

class RegisterState {
  final String fullName;
  final String email;
  final String phone;
  final UserRole selectedRole;
  final String designation;
  final String referCode;
  final String officeBranch;
  final String password;
  final String confirmPassword;
  final bool acceptTerms;
  final bool isLoading;
  final String? errorMessage;
  final String selectedLanguage;
  final bool isSystemOnline;

  const RegisterState({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.selectedRole = UserRole.officeAgent,
    this.designation = 'Sr. Office Consultant',
    this.referCode = '',
    this.officeBranch = 'Corporate HQ (Banani, Dhaka)',
    this.password = '',
    this.confirmPassword = '',
    this.acceptTerms = false,
    this.isLoading = false,
    this.errorMessage,
    this.selectedLanguage = 'EN',
    this.isSystemOnline = true,
  });

  RegisterState copyWith({
    String? fullName,
    String? email,
    String? phone,
    UserRole? selectedRole,
    String? designation,
    String? referCode,
    String? officeBranch,
    String? password,
    String? confirmPassword,
    bool? acceptTerms,
    bool? isLoading,
    String? errorMessage,
    String? selectedLanguage,
    bool? isSystemOnline,
  }) {
    return RegisterState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      selectedRole: selectedRole ?? this.selectedRole,
      designation: designation ?? this.designation,
      referCode: referCode ?? this.referCode,
      officeBranch: officeBranch ?? this.officeBranch,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      acceptTerms: acceptTerms ?? this.acceptTerms,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      isSystemOnline: isSystemOnline ?? this.isSystemOnline,
    );
  }
}

import 'user_role.dart';

class LoginState {
  final UserRole selectedRole;
  final String emailOrPhone;
  final String password;
  final bool isLoading;
  final String? errorMessage;
  final String selectedLanguage;
  final bool isSystemOnline;

  const LoginState({
    this.selectedRole = UserRole.officeAgent,
    this.emailOrPhone = 'tariqul@goyoutravels.com',
    this.password = '••••••••••',
    this.isLoading = false,
    this.errorMessage,
    this.selectedLanguage = 'EN',
    this.isSystemOnline = true,
  });

  LoginState copyWith({
    UserRole? selectedRole,
    String? emailOrPhone,
    String? password,
    bool? isLoading,
    String? errorMessage,
    String? selectedLanguage,
    bool? isSystemOnline,
  }) {
    return LoginState(
      selectedRole: selectedRole ?? this.selectedRole,
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      isSystemOnline: isSystemOnline ?? this.isSystemOnline,
    );
  }
}

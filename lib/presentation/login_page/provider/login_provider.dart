import '../../../core/constant/const.dart';
import '../model/login_state.dart';
import '../model/user_role.dart';
import '../service/login_service.dart';

final loginServiceProvider = Provider<LoginService>((ref) {
  return LoginService();
});

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref.watch(loginServiceProvider));
});

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginService _loginService;

  LoginNotifier(this._loginService) : super(const LoginState());

  void selectRole(UserRole role) {
    state = state.copyWith(selectedRole: role);
  }

  void updateEmailOrPhone(String value) {
    state = state.copyWith(emailOrPhone: value, errorMessage: null);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value, errorMessage: null);
  }

  void toggleLanguage() {
    final nextLang = state.selectedLanguage == 'EN' ? 'BN' : 'EN';
    state = state.copyWith(selectedLanguage: nextLang);
  }

  Future<bool> login() async {
    if (state.emailOrPhone.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter email or phone');
      return false;
    }
    if (state.password.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter password');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final success = await _loginService.login(
        role: state.selectedRole,
        emailOrPhone: state.emailOrPhone,
        password: state.password,
      );
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }
}

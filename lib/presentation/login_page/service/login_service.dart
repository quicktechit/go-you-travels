import '../model/user_role.dart';

class LoginService {
  Future<bool> login({
    required UserRole role,
    required String emailOrPhone,
    required String password,
  }) async {
    // Simulate network delay for login requests
    await Future.delayed(const Duration(milliseconds: 1200));
    return true;
  }
}

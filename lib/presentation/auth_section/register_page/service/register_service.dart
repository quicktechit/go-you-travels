import '../../login_page/model/user_role.dart';

class RegisterService {
  Future<bool> register({
    required String fullName,
    required String email,
    required String phone,
    required UserRole role,
    required String designation,
    required String referCode,
    required String officeBranch,
    required String password,
  }) async {
    // Simulate network delay for registration request
    await Future.delayed(const Duration(milliseconds: 1400));
    return true;
  }
}

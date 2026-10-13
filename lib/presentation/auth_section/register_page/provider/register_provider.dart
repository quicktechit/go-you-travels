import '../../../../core/constant/const.dart';
import '../../login_page/model/user_role.dart';
import '../model/register_state.dart';
import '../service/register_service.dart';

final registerServiceProvider = Provider<RegisterService>((ref) {
  return RegisterService();
});

final registerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  return RegisterNotifier(ref.watch(registerServiceProvider));
});

const List<String> officeBranchOptions = [
  'Corporate HQ (Banani, Dhaka)',
  'Chittagong Branch (Agrabad)',
  'Sylhet Branch (Zindabazar)',
  'Uttara Branch (Sector 3, Dhaka)',
  'Dhanmondi Branch (Dhaka)',
  'Jashore Regional Office',
  'London Overseas Branch (UK)',
];

List<String> getDesignationsForRole(UserRole role) {
  switch (role) {
    case UserRole.officeAgent:
      return [
        'Sr. Office Consultant',
        'Travel & Immigration Counselor',
        'Visa Processing Executive',
        'Operations Manager',
      ];
    case UserRole.localAgent:
      return [
        'District Referral Agent',
        'Field Representative',
        'Regional Franchise Lead',
        'Local Agency Partner',
      ];
    case UserRole.paidLeadAgent:
      return [
        'Digital Campaign Specialist',
        'Lead Generation Executive',
        'Performance Marketer',
        'Social Media Growth Manager',
      ];
    case UserRole.rlAccountUser:
      return [];
  }
}

class RegisterNotifier extends StateNotifier<RegisterState> {
  final RegisterService _registerService;

  RegisterNotifier(this._registerService) : super(const RegisterState());

  void updateFullName(String value) {
    state = state.copyWith(fullName: value, errorMessage: null);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value, errorMessage: null);
  }

  void updatePhone(String value) {
    state = state.copyWith(phone: value, errorMessage: null);
  }

  void selectRole(UserRole role) {
    final availableDesignations = getDesignationsForRole(role);
    state = state.copyWith(
      selectedRole: role,
      designation: availableDesignations.isNotEmpty ? availableDesignations.first : '',
      errorMessage: null,
    );
  }

  void updateDesignation(String value) {
    state = state.copyWith(designation: value, errorMessage: null);
  }

  void updateReferCode(String value) {
    state = state.copyWith(referCode: value, errorMessage: null);
  }

  void updateOfficeBranch(String value) {
    state = state.copyWith(officeBranch: value, errorMessage: null);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value, errorMessage: null);
  }

  void updateConfirmPassword(String value) {
    state = state.copyWith(confirmPassword: value, errorMessage: null);
  }

  void toggleAcceptTerms(bool? value) {
    state = state.copyWith(acceptTerms: value ?? false, errorMessage: null);
  }

  void toggleLanguage() {
    final nextLang = state.selectedLanguage == 'EN' ? 'BN' : 'EN';
    state = state.copyWith(selectedLanguage: nextLang);
  }

  Future<bool> register() async {
    if (state.fullName.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your full name');
      return false;
    }
    if (state.email.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your email address');
      return false;
    }
    if (!state.email.contains('@') || !state.email.contains('.')) {
      state = state.copyWith(errorMessage: 'Please enter a valid email address');
      return false;
    }
    if (state.phone.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your phone number');
      return false;
    }

    // Designation and Office Branch are NOT required for RL Account User
    if (state.selectedRole != UserRole.rlAccountUser) {
      if (state.designation.trim().isEmpty) {
        state = state.copyWith(errorMessage: 'Please select a designation');
        return false;
      }
      if (state.officeBranch.trim().isEmpty) {
        state = state.copyWith(errorMessage: 'Please select an office branch location');
        return false;
      }
    }

    if (state.referCode.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Referral code is mandatory');
      return false;
    }
    if (state.password.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter a password');
      return false;
    }
    if (state.password.length < 6) {
      state = state.copyWith(errorMessage: 'Password must be at least 6 characters');
      return false;
    }
    if (state.confirmPassword.trim() != state.password.trim()) {
      state = state.copyWith(errorMessage: 'Passwords do not match');
      return false;
    }
    if (!state.acceptTerms) {
      state = state.copyWith(errorMessage: 'Please accept Terms & Conditions to proceed');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final success = await _registerService.register(
        fullName: state.fullName,
        email: state.email,
        phone: state.phone,
        role: state.selectedRole,
        designation: state.selectedRole == UserRole.rlAccountUser ? 'RL Account User' : state.designation,
        referCode: state.referCode,
        officeBranch: state.selectedRole == UserRole.rlAccountUser ? 'RL Head Office' : state.officeBranch,
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

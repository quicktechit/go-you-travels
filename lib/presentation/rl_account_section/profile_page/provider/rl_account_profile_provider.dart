import '../../../../core/constant/const.dart';
import '../model/rl_account_profile_state.dart';

final rlAccountProfileProvider = StateNotifierProvider<
    RlAccountProfileNotifier, RlAccountProfileState>((ref) {
  return RlAccountProfileNotifier();
});

class RlAccountProfileNotifier extends StateNotifier<RlAccountProfileState> {
  RlAccountProfileNotifier()
      : super(
          const RlAccountProfileState(
            name: 'Haji Anwar Hossain',
            accountTitle: '(RL-1492 Account)',
            designation: 'Escrow & RL-1492 Account Officer',
            subTitle: 'GYT-ESC-1492 · Treasury & Escrow Division',
            roleBadge: 'RL Account User',
            isOnDuty: true,
            selectedLanguage: 'EN',
          ),
        );

  void toggleDutyStatus() {
    state = state.copyWith(isOnDuty: !state.isOnDuty);
  }

  void setLanguage(String lang) {
    state = state.copyWith(selectedLanguage: lang);
  }
}

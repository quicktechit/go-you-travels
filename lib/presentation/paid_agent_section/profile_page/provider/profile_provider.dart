import '../../../../core/constant/const.dart';
import '../model/profile_model.dart';

final quickTechProfileProvider =
    StateNotifierProvider<QuickTechProfileNotifier, UserProfileModel>((ref) {
  return QuickTechProfileNotifier();
});

class QuickTechProfileNotifier extends StateNotifier<UserProfileModel> {
  QuickTechProfileNotifier() : super(const UserProfileModel());

  void toggleDutyStatus() {
    final nextStatus = !state.isOnDuty;
    state = state.copyWith(isOnDuty: nextStatus);
    Fluttertoast.showToast(
      msg: nextStatus ? "Status updated to On Duty" : "Status updated to Off Duty",
    );
  }

  void setLanguage(String lang) {
    state = state.copyWith(selectedLanguage: lang);
    Fluttertoast.showToast(msg: "Language changed to ${lang == 'EN' ? 'English' : 'Bangla'}");
  }
}

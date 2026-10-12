import '../../../../core/constant/const.dart';
import '../model/local_agent_profile_model.dart';

final localAgentProfileProvider = StateNotifierProvider<
    LocalAgentProfileNotifier, LocalAgentProfileModel>((ref) {
  return LocalAgentProfileNotifier();
});

class LocalAgentProfileNotifier extends StateNotifier<LocalAgentProfileModel> {
  LocalAgentProfileNotifier()
      : super(const LocalAgentProfileModel(
          name: 'Karim Uddin',
          designation: 'Sylhet Regional Partner',
          partnerTitle: 'Regional Franchise & Referral Partner',
          partnerId: 'GYT-PRT-2819',
          hubLocation: 'Sylhet Regional Hub (Chowhatta)',
          roleBadge: 'Local Agent',
          rating: 4.95,
          isOnDuty: true,
          monthlyConversions: 18,
          activeVisaFiles: 24,
          monthlyCommission: '\$2,450',
          selectedLanguage: 'EN',
        ));

  void toggleDutyStatus() {
    state = state.copyWith(isOnDuty: !state.isOnDuty);
    Fluttertoast.showToast(
      msg: state.isOnDuty ? "Status set to On Duty" : "Status set to Off Duty",
    );
  }

  void setLanguage(String lang) {
    state = state.copyWith(selectedLanguage: lang);
    Fluttertoast.showToast(msg: "Language changed to ${lang == 'EN' ? 'English' : 'বাংলা'}");
  }
}

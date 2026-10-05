import '../../../../core/constant/const.dart';
import '../../../login_page/model/user_role.dart';
import '../../../login_page/provider/login_provider.dart';
import '../model/home_state.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final loginState = ref.watch(loginProvider);
  return HomeNotifier(loginState.selectedRole);
});

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(UserRole role)
      : super(HomeState(activeRole: role, selectedNavIndex: 0));

  void setNavIndex(int index) {
    state = state.copyWith(selectedNavIndex: index);
  }


}

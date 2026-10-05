import '../../../login_page/model/user_role.dart';

class HomeState {
  final int selectedNavIndex;
  final UserRole activeRole;

  const HomeState({
    this.selectedNavIndex = 0,
    this.activeRole = UserRole.officeAgent,
  });

  HomeState copyWith({
    int? selectedNavIndex,
    UserRole? activeRole,
  }) {
    return HomeState(
      selectedNavIndex: selectedNavIndex ?? this.selectedNavIndex,
      activeRole: activeRole ?? this.activeRole,
    );
  }
}

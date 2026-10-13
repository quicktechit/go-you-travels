class RlAccountProfileState {
  final String name;
  final String accountTitle;
  final String designation;
  final String subTitle;
  final String roleBadge;
  final bool isOnDuty;
  final String selectedLanguage;

  const RlAccountProfileState({
    required this.name,
    required this.accountTitle,
    required this.designation,
    required this.subTitle,
    required this.roleBadge,
    required this.isOnDuty,
    required this.selectedLanguage,
  });

  RlAccountProfileState copyWith({
    String? name,
    String? accountTitle,
    String? designation,
    String? subTitle,
    String? roleBadge,
    bool? isOnDuty,
    String? selectedLanguage,
  }) {
    return RlAccountProfileState(
      name: name ?? this.name,
      accountTitle: accountTitle ?? this.accountTitle,
      designation: designation ?? this.designation,
      subTitle: subTitle ?? this.subTitle,
      roleBadge: roleBadge ?? this.roleBadge,
      isOnDuty: isOnDuty ?? this.isOnDuty,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}

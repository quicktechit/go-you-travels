class LocalAgentProfileModel {
  final String name;
  final String designation;
  final String partnerTitle;
  final String partnerId;
  final String hubLocation;
  final String roleBadge;
  final double rating;
  final bool isOnDuty;
  final int monthlyConversions;
  final int activeVisaFiles;
  final String monthlyCommission;
  final String selectedLanguage;

  const LocalAgentProfileModel({
    required this.name,
    required this.designation,
    required this.partnerTitle,
    required this.partnerId,
    required this.hubLocation,
    required this.roleBadge,
    required this.rating,
    required this.isOnDuty,
    required this.monthlyConversions,
    required this.activeVisaFiles,
    required this.monthlyCommission,
    required this.selectedLanguage,
  });

  LocalAgentProfileModel copyWith({
    String? name,
    String? designation,
    String? partnerTitle,
    String? partnerId,
    String? hubLocation,
    String? roleBadge,
    double? rating,
    bool? isOnDuty,
    int? monthlyConversions,
    int? activeVisaFiles,
    String? monthlyCommission,
    String? selectedLanguage,
  }) {
    return LocalAgentProfileModel(
      name: name ?? this.name,
      designation: designation ?? this.designation,
      partnerTitle: partnerTitle ?? this.partnerTitle,
      partnerId: partnerId ?? this.partnerId,
      hubLocation: hubLocation ?? this.hubLocation,
      roleBadge: roleBadge ?? this.roleBadge,
      rating: rating ?? this.rating,
      isOnDuty: isOnDuty ?? this.isOnDuty,
      monthlyConversions: monthlyConversions ?? this.monthlyConversions,
      activeVisaFiles: activeVisaFiles ?? this.activeVisaFiles,
      monthlyCommission: monthlyCommission ?? this.monthlyCommission,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}

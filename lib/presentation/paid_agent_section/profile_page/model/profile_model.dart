class UserProfileModel {
  final String name;
  final String designation;
  final String counselorTitle;
  final String empId;
  final String officeLocation;
  final String roleBadge;
  final double rating;
  final bool isOnDuty;
  final int monthlyConversions;
  final int activeVisaFiles;
  final String monthlyCommission;
  final String selectedLanguage; // EN or BN

  const UserProfileModel({
    this.name = 'Tariqul Islam',
    this.designation = 'Paid Lead Agent',
    this.counselorTitle = 'Senior Digital & Lead Generation Specialist',
    this.empId = 'GYT-PA-5012',
    this.officeLocation = 'Digital Campaign HQ (Banani, Dhaka)',
    this.roleBadge = 'Paid Lead Agent',
    this.rating = 4.95,
    this.isOnDuty = true,
    this.monthlyConversions = 18,
    this.activeVisaFiles = 24,
    this.monthlyCommission = '\$2,450',
    this.selectedLanguage = 'EN',
  });

  UserProfileModel copyWith({
    String? name,
    String? designation,
    String? counselorTitle,
    String? empId,
    String? officeLocation,
    String? roleBadge,
    double? rating,
    bool? isOnDuty,
    int? monthlyConversions,
    int? activeVisaFiles,
    String? monthlyCommission,
    String? selectedLanguage,
  }) {
    return UserProfileModel(
      name: name ?? this.name,
      designation: designation ?? this.designation,
      counselorTitle: counselorTitle ?? this.counselorTitle,
      empId: empId ?? this.empId,
      officeLocation: officeLocation ?? this.officeLocation,
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

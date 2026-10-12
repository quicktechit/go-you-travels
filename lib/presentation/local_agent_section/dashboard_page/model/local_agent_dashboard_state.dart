import '../../../../core/constant/const.dart';

enum ClientSubmissionStatus {
  newFileCreated('New File Created', Color(0xFFEFF6FF), AppColors.primary),
  processing('Processing', Color(0xFFEFF6FF), AppColors.primary),
  underReview('Under Review', Color(0xFFFFF7ED), AppColors.orange),
  approved('Converted / Approved', Color(0xFFECFDF5), AppColors.emerald);

  final String label;
  final Color bgColor;
  final Color textColor;
  const ClientSubmissionStatus(this.label, this.bgColor, this.textColor);
}

class SubmittedClient {
  final String id;
  final String name;
  final String visaType;
  final String country;
  final double packageAmount;
  final double commissionAmount;
  final ClientSubmissionStatus status;
  final DateTime createdAt;

  const SubmittedClient({
    required this.id,
    required this.name,
    required this.visaType,
    required this.country,
    required this.packageAmount,
    required this.commissionAmount,
    required this.status,
    required this.createdAt,
  });
}

class LocalAgentDashboardState {
  final List<SubmittedClient> submittedClients;
  final int totalSubmittedThisMonth;
  final int pendingInReview;
  final int convertedApproved;
  final double totalCommission;
  final double paidCommission;
  final double pendingCommission;

  const LocalAgentDashboardState({
    required this.submittedClients,
    this.totalSubmittedThisMonth = 7,
    this.pendingInReview = 6,
    this.convertedApproved = 1,
    this.totalCommission = 800.00,
    this.paidCommission = 0.00,
    this.pendingCommission = 800.00,
  });

  LocalAgentDashboardState copyWith({
    List<SubmittedClient>? submittedClients,
    int? totalSubmittedThisMonth,
    int? pendingInReview,
    int? convertedApproved,
    double? totalCommission,
    double? paidCommission,
    double? pendingCommission,
  }) {
    return LocalAgentDashboardState(
      submittedClients: submittedClients ?? this.submittedClients,
      totalSubmittedThisMonth: totalSubmittedThisMonth ?? this.totalSubmittedThisMonth,
      pendingInReview: pendingInReview ?? this.pendingInReview,
      convertedApproved: convertedApproved ?? this.convertedApproved,
      totalCommission: totalCommission ?? this.totalCommission,
      paidCommission: paidCommission ?? this.paidCommission,
      pendingCommission: pendingCommission ?? this.pendingCommission,
    );
  }
}

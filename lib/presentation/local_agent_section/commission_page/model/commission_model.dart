import '../../../../core/constant/const.dart';

enum CommissionStatus {
  approved('Approved', Color(0xFFEFF6FF), AppColors.primary),
  pending('Pending', Color(0xFFFFF7ED), AppColors.orange),
  paid('Paid', Color(0xFFECFDF5), AppColors.emerald);

  final String label;
  final Color bgColor;
  final Color textColor;
  const CommissionStatus(this.label, this.bgColor, this.textColor);
}

class CommissionTransaction {
  final String id;
  final String clientName;
  final String fileNo;
  final String agentName;
  final String date;
  final String paymentMethod;
  final double amount;
  final CommissionStatus status;

  const CommissionTransaction({
    required this.id,
    required this.clientName,
    required this.fileNo,
    required this.agentName,
    required this.date,
    required this.paymentMethod,
    required this.amount,
    required this.status,
  });
}

class CommissionState {
  final double totalEarnings;
  final double paidPayouts;
  final double pendingClearance;
  final List<CommissionTransaction> transactions;

  const CommissionState({
    this.totalEarnings = 1520.00,
    this.paidPayouts = 720.00,
    this.pendingClearance = 800.00,
    required this.transactions,
  });

  CommissionState copyWith({
    double? totalEarnings,
    double? paidPayouts,
    double? pendingClearance,
    List<CommissionTransaction>? transactions,
  }) {
    return CommissionState(
      totalEarnings: totalEarnings ?? this.totalEarnings,
      paidPayouts: paidPayouts ?? this.paidPayouts,
      pendingClearance: pendingClearance ?? this.pendingClearance,
      transactions: transactions ?? this.transactions,
    );
  }
}

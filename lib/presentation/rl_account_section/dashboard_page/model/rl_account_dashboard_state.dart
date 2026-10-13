import '../../../../core/constant/const.dart';

class TreasuryInfo {
  final String treasuryCode;
  final String verifiedAuditLabel;
  final double balanceAmount;
  final String accountSubtitle;
  final double outstandingDueAmount;
  final String liquidityPoolName;

  const TreasuryInfo({
    required this.treasuryCode,
    required this.verifiedAuditLabel,
    required this.balanceAmount,
    required this.accountSubtitle,
    required this.outstandingDueAmount,
    required this.liquidityPoolName,
  });
}

enum LedgerType {
  clientInflows,
  embassyVendor,
  bridgeLoans,
  loanRepayments,
}

class LedgerBreakdownItem {
  final String title;
  final String amount;
  final String subtitle;
  final LedgerType type;

  const LedgerBreakdownItem({
    required this.title,
    required this.amount,
    required this.subtitle,
    required this.type,
  });
}

enum LedgerCategory {
  received,
  payable,
  borrowed,
  returned,
}

class RlAccountTransaction {
  final String id;
  final String title;
  final String description;
  final String dateStr;
  final String reference;
  final double amount;
  final bool isCredit;
  final String categoryLabel;
  final LedgerCategory category;
  final String runningBalance;

  const RlAccountTransaction({
    required this.id,
    required this.title,
    required this.description,
    required this.dateStr,
    required this.reference,
    required this.amount,
    required this.isCredit,
    required this.categoryLabel,
    required this.category,
    required this.runningBalance,
  });
}

class RlAccountDashboardState {
  final TreasuryInfo treasuryInfo;
  final List<LedgerBreakdownItem> ledgerItems;
  final List<RlAccountTransaction> recentTransactions;

  const RlAccountDashboardState({
    required this.treasuryInfo,
    required this.ledgerItems,
    required this.recentTransactions,
  });

  RlAccountDashboardState copyWith({
    TreasuryInfo? treasuryInfo,
    List<LedgerBreakdownItem>? ledgerItems,
    List<RlAccountTransaction>? recentTransactions,
  }) {
    return RlAccountDashboardState(
      treasuryInfo: treasuryInfo ?? this.treasuryInfo,
      ledgerItems: ledgerItems ?? this.ledgerItems,
      recentTransactions: recentTransactions ?? this.recentTransactions,
    );
  }
}

import '../../../../core/constant/const.dart';
import '../../dashboard_page/model/rl_account_dashboard_state.dart';

enum LedgerFilter {
  all('ALL'),
  received('RECEIVED'),
  payable('PAYABLE'),
  borrowed('BORROWED'),
  returned('RETURNED');

  final String label;
  const LedgerFilter(this.label);
}

class LedgerState {
  final double totalAuditedBalance;
  final String accountCode;
  final LedgerFilter selectedFilter;
  final List<RlAccountTransaction> transactions;

  const LedgerState({
    required this.totalAuditedBalance,
    required this.accountCode,
    required this.selectedFilter,
    required this.transactions,
  });

  List<RlAccountTransaction> get filteredTransactions {
    switch (selectedFilter) {
      case LedgerFilter.all:
        return transactions;
      case LedgerFilter.received:
        return transactions
            .where((t) => t.category == LedgerCategory.received)
            .toList();
      case LedgerFilter.payable:
        return transactions
            .where((t) => t.category == LedgerCategory.payable)
            .toList();
      case LedgerFilter.borrowed:
        return transactions
            .where((t) => t.category == LedgerCategory.borrowed)
            .toList();
      case LedgerFilter.returned:
        return transactions
            .where((t) => t.category == LedgerCategory.returned)
            .toList();
    }
  }

  LedgerState copyWith({
    double? totalAuditedBalance,
    String? accountCode,
    LedgerFilter? selectedFilter,
    List<RlAccountTransaction>? transactions,
  }) {
    return LedgerState(
      totalAuditedBalance: totalAuditedBalance ?? this.totalAuditedBalance,
      accountCode: accountCode ?? this.accountCode,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      transactions: transactions ?? this.transactions,
    );
  }
}

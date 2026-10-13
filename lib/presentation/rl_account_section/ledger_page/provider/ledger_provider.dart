import '../../../../core/constant/const.dart';
import '../../dashboard_page/model/rl_account_dashboard_state.dart';
import '../model/ledger_state.dart';

final ledgerProvider =
    StateNotifierProvider<LedgerNotifier, LedgerState>((ref) {
  return LedgerNotifier();
});

class LedgerNotifier extends StateNotifier<LedgerState> {
  LedgerNotifier()
      : super(
          const LedgerState(
            totalAuditedBalance: 42800.00,
            accountCode: 'RL-1492',
            selectedFilter: LedgerFilter.all,
            transactions: [
              RlAccountTransaction(
                id: 'TX-901',
                title: 'Customer Advance Deposit -',
                description:
                    'Customer advance deposit for VIP visa processing',
                dateStr: '2026-09-28',
                reference: 'INV-2026-091',
                amount: 3000.00,
                isCredit: true,
                categoryLabel: 'RECEIVED',
                category: LedgerCategory.received,
                runningBalance: '\$42,800',
              ),
              RlAccountTransaction(
                id: 'TX-902',
                title: 'Saudi Ministry Visa Fee & Muqeem',
                description:
                    'Saudi Ministry visa fee & Muqeem portal service fee',
                dateStr: '2026-09-27',
                reference: 'EXP-9811',
                amount: 1800.00,
                isCredit: false,
                categoryLabel: 'PAYABLE',
                category: LedgerCategory.payable,
                runningBalance: '\$39,800',
              ),
              RlAccountTransaction(
                id: 'TX-903',
                title: 'Short-term agency liquidity loan',
                description:
                    'Short-term agency liquidity loan from City Bank Escrow',
                dateStr: '2026-09-26',
                reference: 'LOAN-ESC-12',
                amount: 5000.00,
                isCredit: true,
                categoryLabel: 'BORROWED',
                category: LedgerCategory.borrowed,
                runningBalance: '\$41,600',
              ),
              RlAccountTransaction(
                id: 'TX-904',
                title: 'Settlement of loan installment to',
                description:
                    'Settlement of loan installment to City Bank Escrow',
                dateStr: '2026-09-24',
                reference: 'REPAY-402',
                amount: 2000.00,
                isCredit: false,
                categoryLabel: 'RETURNED',
                category: LedgerCategory.returned,
                runningBalance: '\$36,600',
              ),
              RlAccountTransaction(
                id: 'TX-905',
                title: 'Full Package Payment - Dr. Sabrina',
                description:
                    'Full package payment received from Dr. Sabrina',
                dateStr: '2026-09-22',
                reference: 'INV-2026-084',
                amount: 6200.00,
                isCredit: true,
                categoryLabel: 'RECEIVED',
                category: LedgerCategory.received,
                runningBalance: '\$38,600',
              ),
            ],
          ),
        );

  void setFilter(LedgerFilter filter) {
    state = state.copyWith(selectedFilter: filter);
  }
}

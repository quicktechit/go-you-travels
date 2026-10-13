import '../../../../core/constant/const.dart';
import '../model/rl_account_dashboard_state.dart';

final rlAccountDashboardProvider = StateNotifierProvider<
    RlAccountDashboardNotifier, RlAccountDashboardState>((ref) {
  return RlAccountDashboardNotifier();
});

class RlAccountDashboardNotifier
    extends StateNotifier<RlAccountDashboardState> {
  RlAccountDashboardNotifier()
      : super(
          const RlAccountDashboardState(
            treasuryInfo: TreasuryInfo(
              treasuryCode: 'RL-1492 TREASURY BALANCE',
              verifiedAuditLabel: 'VERIFIED AUDIT',
              balanceAmount: 42800.00,
              accountSubtitle: 'Go You Travels & Escrow Settlement Account',
              outstandingDueAmount: 7800.00,
              liquidityPoolName: 'City Bank Escrow',
            ),
            ledgerItems: [
              LedgerBreakdownItem(
                title: 'Client Inflows',
                amount: '\$43,000',
                subtitle: 'Total Received',
                type: LedgerType.clientInflows,
              ),
              LedgerBreakdownItem(
                title: 'Embassy & Vendor',
                amount: '\$13,800',
                subtitle: 'Total Payable',
                type: LedgerType.embassyVendor,
              ),
              LedgerBreakdownItem(
                title: 'Bridge Loans',
                amount: '\$5,000',
                subtitle: 'Total Borrowed',
                type: LedgerType.bridgeLoans,
              ),
              LedgerBreakdownItem(
                title: 'Loan Repayments',
                amount: '\$2,000',
                subtitle: 'Total Returned',
                type: LedgerType.loanRepayments,
              ),
            ],
            recentTransactions: [
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
}

import '../../../../core/constant/const.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../dashboard_page/widget/account_transaction_card.dart';
import '../provider/ledger_provider.dart';
import '../widget/ledger_filter_chips.dart';
import '../widget/total_audited_balance_card.dart';

class QuickTechRlAccountLedgerPage extends ConsumerWidget {
  const QuickTechRlAccountLedgerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ledgerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredList = state.filteredTransactions;

    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Ledger',
        subtitle: 'Go You Travels',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 90.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Total Audited Balance Card with RL-1492 Pill
              TotalAuditedBalanceCard(
                balance: state.totalAuditedBalance,
                accountCode: state.accountCode,
              ),
              SizedBox(height: 20.h),

              // 2. Horizontal Filter Chips (ALL, RECEIVED, PAYABLE, BORROWED, RETURNED)
              LedgerFilterChips(
                selectedFilter: state.selectedFilter,
                onSelectFilter: (filter) {
                  ref.read(ledgerProvider.notifier).setFilter(filter);
                },
              ),
              SizedBox(height: 16.h),

              // 3. Ledger Transactions List using shared AccountTransactionCard
              if (filteredList.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Text(
                      'No ledger transactions found.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final tx = filteredList[index];
                    return AccountTransactionCard(transaction: tx);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import '../../../../core/constant/const.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../provider/rl_account_dashboard_provider.dart';
import '../widget/account_transaction_card.dart';
import '../widget/ledger_breakdown_grid.dart';
import '../widget/treasury_balance_card.dart';

class QuickTechRlAccountDashboardPage extends ConsumerWidget {
  const QuickTechRlAccountDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rlAccountDashboardProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: const CustomAppbar(
        title: 'RL Account User Dashboard',
        subtitle: 'Go You Travels',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 90.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Treasury Balance Main Dark Card
              TreasuryBalanceCard(info: state.treasuryInfo),
              SizedBox(height: 24.h),

              // 2. Account Ledger Breakdown Section Header
              Text(
                'ACCOUNT LEDGER BREAKDOWN',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.textMuted,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 12.h),

              // 3. Ledger Breakdown Grid (2x2)
              LedgerBreakdownGrid(items: state.ledgerItems),
              SizedBox(height: 24.h),

              // 4. Recent Account Transactions Section Header
              Text(
                'RECENT ACCOUNT TRANSACTIONS',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.textMuted,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 12.h),

              // 5. List of Recent Account Transactions
              if (state.recentTransactions.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: Text(
                      'No recent transactions found.',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
                  itemCount: state.recentTransactions.length,
                  itemBuilder: (context, index) {
                    final tx = state.recentTransactions[index];
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

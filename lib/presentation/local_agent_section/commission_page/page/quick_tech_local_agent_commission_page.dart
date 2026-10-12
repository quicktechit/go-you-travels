import '../../../../core/constant/const.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../provider/commission_provider.dart';
import '../widget/commission_summary_card.dart';
import '../widget/commission_transaction_card.dart';

class QuickTechLocalAgentCommissionPage extends ConsumerWidget {
  const QuickTechLocalAgentCommissionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(localAgentCommissionProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: const CustomAppbar(
        title: 'Commission',
        subtitle: 'Go You Travels',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 90.h),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Commission Earnings Summary Card
              const CommissionSummaryCard(),
              SizedBox(height: 24.h),

              // 2. Commission Transaction Log Section Header
              Text(
                'COMMISSION TRANSACTION LOG',
                style: GoogleFonts.figtree(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.textMuted,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 12.h),

              // 3. Transactions List
              if (state.transactions.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Text(
                      'No commission transactions found.',
                      style: GoogleFonts.figtree(
                        fontSize: 14.sp,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                      ),
                    ),
                  ),
                )
              else
                ...state.transactions.map(
                  (tx) => CommissionTransactionCard(transaction: tx),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

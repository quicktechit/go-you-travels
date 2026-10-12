import '../../../../core/constant/const.dart';
import '../model/commission_model.dart';

final localAgentCommissionProvider = StateNotifierProvider<
    LocalAgentCommissionNotifier, CommissionState>((ref) {
  return LocalAgentCommissionNotifier();
});

class LocalAgentCommissionNotifier extends StateNotifier<CommissionState> {
  LocalAgentCommissionNotifier()
      : super(CommissionState(
          transactions: [
            const CommissionTransaction(
              id: '1',
              clientName: 'Mahmudul Hasan',
              fileNo: 'VF-2024-001',
              agentName: 'Karim Uddin',
              date: '2026-09-25',
              paymentMethod: 'Bank Transfer',
              amount: 450.00,
              status: CommissionStatus.approved,
            ),
            const CommissionTransaction(
              id: '2',
              clientName: 'Kamrul Islam',
              fileNo: 'VF-2024-003',
              agentName: 'Rahim Ali',
              date: '2026-09-22',
              paymentMethod: 'Pending Approval',
              amount: 350.00,
              status: CommissionStatus.pending,
            ),
            const CommissionTransaction(
              id: '3',
              clientName: 'Arifur Rahman',
              fileNo: 'LD-8901',
              agentName: 'Selim Reza',
              date: '2026-09-18',
              paymentMethod: 'Instant Wallet',
              amount: 120.00,
              status: CommissionStatus.paid,
            ),
            const CommissionTransaction(
              id: '4',
              clientName: 'Dr. Sabrina Chowdhury',
              fileNo: 'VF-2024-002',
              agentName: 'Tariqul Islam',
              date: '2026-09-15',
              paymentMethod: 'Monthly Payroll',
              amount: 600.00,
              status: CommissionStatus.paid,
            ),
          ],
        ));
}

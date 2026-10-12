import '../../../../core/constant/const.dart';
import '../model/local_agent_dashboard_state.dart';

final localAgentDashboardProvider = StateNotifierProvider<
    LocalAgentDashboardNotifier, LocalAgentDashboardState>((ref) {
  return LocalAgentDashboardNotifier();
});

class LocalAgentDashboardNotifier extends StateNotifier<LocalAgentDashboardState> {
  LocalAgentDashboardNotifier()
      : super(LocalAgentDashboardState(
          submittedClients: [
            SubmittedClient(
              id: '1',
              name: 'Nusrat Jahan',
              visaType: 'B1/B2 Tourist Visa',
              country: 'USA',
              packageAmount: 4500.0,
              commissionAmount: 450.0,
              status: ClientSubmissionStatus.newFileCreated,
              createdAt: DateTime.now().subtract(const Duration(days: 1)),
            ),
            SubmittedClient(
              id: '2',
              name: 'Zubair Hossain',
              visaType: 'Higher Education Student Visa',
              country: 'Australia',
              packageAmount: 4500.0,
              commissionAmount: 450.0,
              status: ClientSubmissionStatus.newFileCreated,
              createdAt: DateTime.now().subtract(const Duration(days: 2)),
            ),
            SubmittedClient(
              id: '3',
              name: 'Zubair Hossain',
              visaType: 'Higher Education Student Visa',
              country: 'Australia',
              packageAmount: 4500.0,
              commissionAmount: 450.0,
              status: ClientSubmissionStatus.newFileCreated,
              createdAt: DateTime.now().subtract(const Duration(days: 3)),
            ),
            SubmittedClient(
              id: '4',
              name: 'Mahmudul Hasan',
              visaType: 'Umrah VIP Family Package',
              country: 'Saudi Arabia',
              packageAmount: 4500.0,
              commissionAmount: 450.0,
              status: ClientSubmissionStatus.processing,
              createdAt: DateTime.now().subtract(const Duration(days: 4)),
            ),
            SubmittedClient(
              id: '5',
              name: 'Kamrul Islam',
              visaType: 'Student Visa Tier 4',
              country: 'United Kingdom',
              packageAmount: 5800.0,
              commissionAmount: 450.0,
              status: ClientSubmissionStatus.underReview,
              createdAt: DateTime.now().subtract(const Duration(days: 5)),
            ),
          ],
        ));

  void addClient(SubmittedClient client) {
    final updatedList = [client, ...state.submittedClients];
    state = state.copyWith(
      submittedClients: updatedList,
      totalSubmittedThisMonth: state.totalSubmittedThisMonth + 1,
      pendingInReview: state.pendingInReview + 1,
      totalCommission: state.totalCommission + client.commissionAmount,
      pendingCommission: state.pendingCommission + client.commissionAmount,
    );
    Fluttertoast.showToast(msg: "Client submitted successfully!");
  }
}

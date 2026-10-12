import '../../../../core/constant/const.dart';
import '../model/quick_tech_report_model.dart';

class ReportState {
  final ReportTabFilter selectedTab;

  const ReportState({
    this.selectedTab = ReportTabFilter.sales,
  });

  ReportState copyWith({
    ReportTabFilter? selectedTab,
  }) {
    return ReportState(
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}

final quickTechReportProvider =
    StateNotifierProvider<QuickTechReportNotifier, ReportState>((ref) {
  return QuickTechReportNotifier();
});

class QuickTechReportNotifier extends StateNotifier<ReportState> {
  QuickTechReportNotifier() : super(const ReportState());

  void setTab(ReportTabFilter tab) {
    state = state.copyWith(selectedTab: tab);
  }
}

import '../../../../core/constant/const.dart';
import '../model/quick_tech_report_model.dart';
import '../provider/quick_tech_report_provider.dart';

class ReportFilterChips extends ConsumerWidget {
  const ReportFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechReportProvider);
    final notifier = ref.read(quickTechReportProvider.notifier);

    final filters = ReportTabFilter.values;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: filters.map((tab) {
          final isSelected = state.selectedTab == tab;

          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: AppFilterChip(
              label: tab.label,
              isSelected: isSelected,
              onTap: () => notifier.setTab(tab),
            ),
          );
        }).toList(),
      ),
    );
  }
}

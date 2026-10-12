import '../../../../core/constant/const.dart';
import '../provider/lead_provider.dart';

class LeadFilterChips extends ConsumerWidget {
  const LeadFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechLeadProvider);
    final notifier = ref.read(quickTechLeadProvider.notifier);

    final tabs = [
      'All Leads (${state.totalLeadsCount})',
      'New (${state.newInquiriesCount})',
      'Contacted (${state.contactedCount})',
      'Interested (${state.interestedCount})',
      'Follow-up (${state.followUpsDueCount})',
      'Converted (${state.convertedCount})',
      'Not Interested (${state.notInterestCount})',
      'Not Reachable (${state.notReachableCount})',
      'Lost (${state.lostCount})',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: tabs.map((tab) {
          final cleanSelected = state.selectedStatusTab.contains(' (')
              ? state.selectedStatusTab.split(' (').first
              : state.selectedStatusTab;
          final cleanTab = tab.contains(' (') ? tab.split(' (').first : tab;
          final isSelected = cleanSelected == cleanTab;

          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: AppFilterChip(
              label: tab,
              isSelected: isSelected,
              onTap: () => notifier.setSelectedStatusTab(tab),
            ),
          );
        }).toList(),
      ),
    );
  }
}

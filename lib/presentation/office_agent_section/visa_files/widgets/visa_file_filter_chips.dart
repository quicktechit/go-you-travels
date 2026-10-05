import '../../../../core/constant/const.dart';
import '../provider/visa_file_provider.dart';

class VisaFileFilterChips extends ConsumerWidget {
  const VisaFileFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechVisaFilesProvider);
    final notifier = ref.read(quickTechVisaFilesProvider.notifier);

    final rawTabs = ['All', 'Approved', 'Processing', 'Rejected', 'Completed', 'Cancelled'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: rawTabs.map((tab) {
          final count = state.countForTab(tab);
          final label = '$tab ($count)';

          final cleanSelected = state.selectedTab.contains(' (')
              ? state.selectedTab.split(' (').first.trim()
              : state.selectedTab.trim();
          final isSelected = cleanSelected == tab;

          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: AppFilterChip(
              label: label,
              isSelected: isSelected,
              onTap: () => notifier.setSelectedTab(label),
            ),
          );
        }).toList(),
      ),
    );
  }
}

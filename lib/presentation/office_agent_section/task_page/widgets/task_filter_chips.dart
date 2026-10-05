import '../../../../core/constant/const.dart';
import '../provider/task_provider.dart';

class TaskFilterChips extends ConsumerWidget {
  const TaskFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechTaskProvider);
    final notifier = ref.read(quickTechTaskProvider.notifier);

    final rawTabs = ['All', 'Pending', 'In Progress', 'Completed', 'Urgent'];

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

import '../../../../core/constant/const.dart';
import '../model/quick_tech_followup_model.dart';
import '../provider/quick_tech_followup_provider.dart';

class FollowupFilterChips extends ConsumerWidget {
  const FollowupFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quickTechFollowupProvider);
    final notifier = ref.read(quickTechFollowupProvider.notifier);

    final categories = [
      FollowupCategoryFilter.today,
      FollowupCategoryFilter.upcoming,
      FollowupCategoryFilter.missedOverdue,
      FollowupCategoryFilter.completed,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: categories.map((filter) {
          final isSelected = state.selectedFilter == filter;
          final count = state.countForFilter(filter);
          final labelText = '${filter.label} ($count)';

          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: AppFilterChip(
              label: labelText,
              isSelected: isSelected,
              onTap: () => notifier.setFilter(filter),
            ),
          );
        }).toList(),
      ),
    );
  }
}

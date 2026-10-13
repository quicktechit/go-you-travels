import '../../../../core/constant/const.dart';
import '../model/ledger_state.dart';

class LedgerFilterChips extends StatelessWidget {
  final LedgerFilter selectedFilter;
  final ValueChanged<LedgerFilter> onSelectFilter;

  const LedgerFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onSelectFilter,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: LedgerFilter.values.map((filter) {
          final isSelected = filter == selectedFilter;

          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: AppFilterChip(
              label: filter.label,
              isSelected: isSelected,
              onTap: () => onSelectFilter(filter),
            ),
          );
        }).toList(),
      ),
    );
  }
}

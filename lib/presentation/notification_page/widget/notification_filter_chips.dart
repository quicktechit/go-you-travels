import '../../../../core/constant/const.dart';
import '../provider/notification_provider.dart';

class NotificationFilterChips extends ConsumerWidget {
  const NotificationFilterChips({super.key});

  static const List<String> categories = [
    'All',
    'Unread',
    'Visa',
    'Leads',
    'Financials',
    'Alerts',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationProvider);
    final notifier = ref.read(notificationProvider.notifier);
    final selectedCategory = state.selectedCategory;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: categories.map((category) {
          final isSelected = selectedCategory == category;
          final count = state.getCategoryCount(category);
          final label = count > 0 ? '$category ($count)' : category;

          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: AppFilterChip(
              label: label,
              isSelected: isSelected,
              onTap: () => notifier.filterByCategory(category),
            ),
          );
        }).toList(),
      ),
    );
  }
}

import '../../../../core/constant/const.dart';
import '../model/quick_tech_followup_model.dart';

class FollowupState {
  final FollowupCategoryFilter selectedFilter;
  final List<FollowupItem> items;
  final String searchQuery;

  const FollowupState({
    this.selectedFilter = FollowupCategoryFilter.upcoming,
    this.items = const [],
    this.searchQuery = '',
  });

  int countForFilter(FollowupCategoryFilter filter) {
    if (filter == FollowupCategoryFilter.all) return items.length;
    return items.where((item) => item.category == filter).length;
  }

  List<FollowupItem> get filteredItems {
    return items.where((item) {
      if (selectedFilter != FollowupCategoryFilter.all &&
          item.category != selectedFilter) {
        return false;
      }
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        return item.name.toLowerCase().contains(query) ||
            item.phone.toLowerCase().contains(query) ||
            item.visaType.toLowerCase().contains(query) ||
            item.notes.toLowerCase().contains(query) ||
            item.assignedAgent.toLowerCase().contains(query);
      }
      return true;
    }).toList();
  }

  FollowupState copyWith({
    FollowupCategoryFilter? selectedFilter,
    List<FollowupItem>? items,
    String? searchQuery,
  }) {
    return FollowupState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      items: items ?? this.items,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

final quickTechFollowupProvider =
    StateNotifierProvider<QuickTechFollowupNotifier, FollowupState>((ref) {
  return QuickTechFollowupNotifier();
});

class QuickTechFollowupNotifier extends StateNotifier<FollowupState> {
  QuickTechFollowupNotifier()
      : super(const FollowupState(
          selectedFilter: FollowupCategoryFilter.upcoming,
          items: [
            FollowupItem(
              id: '1',
              name: 'Nusrat Jahan',
              phone: '+1 (212) 555-0143',
              visaType: 'USA B1/B2',
              timeTag: 'Sep 30, 02:00 PM',
              notes: 'Second call after sending visa eligibility pack.',
              assignedAgent: 'Tariqul Islam',
              category: FollowupCategoryFilter.upcoming,
            ),
            FollowupItem(
              id: '2',
              name: 'Farhana Akter',
              phone: '+44 7911 123456',
              visaType: 'UK Skilled Worker',
              timeTag: 'Tomorrow, 11:30 AM',
              notes: 'Check UK employer sponsorship certificate reference.',
              assignedAgent: 'Tariqul Islam',
              category: FollowupCategoryFilter.upcoming,
            ),
            FollowupItem(
              id: '3',
              name: 'Arifur Rahman',
              phone: '+1 (416) 782-9011',
              visaType: 'Canada PR',
              timeTag: 'Today, 04:00 PM',
              notes: 'Confirm WES ECA report readiness for Canadian PR entry.',
              assignedAgent: 'Tariqul Islam',
              category: FollowupCategoryFilter.today,
            ),
            FollowupItem(
              id: '4',
              name: 'Mahfuz Alam',
              phone: '+1 (312) 555-0188',
              visaType: 'USA F1 Visa',
              timeTag: 'Sep 28, 10:00 AM',
              notes: 'DS-160 form submitted and embassy interview scheduled.',
              assignedAgent: 'Tariqul Islam',
              category: FollowupCategoryFilter.completed,
              isDone: true,
            ),
          ],
        ));

  void setFilter(FollowupCategoryFilter filter) {
    state = state.copyWith(selectedFilter: filter);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void markDone(String id) {
    final updatedItems = state.items.map((item) {
      if (item.id == id) {
        final newDone = !item.isDone;
        Fluttertoast.showToast(
          msg: newDone
              ? "Follow-up marked as Done for ${item.name}"
              : "Follow-up marked as Pending for ${item.name}",
        );
        return item.copyWith(
          isDone: newDone,
          category: newDone ? FollowupCategoryFilter.completed : FollowupCategoryFilter.upcoming,
        );
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }

  void callNow(FollowupItem item) {
    Fluttertoast.showToast(
      msg: "Calling ${item.name} (${item.phone})...",
    );
  }
}

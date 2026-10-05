import '../../../../core/constant/const.dart';
import '../model/task_model.dart';

class TaskState {
  final String selectedTab;
  final String searchQuery;
  final List<TaskItem> tasks;

  const TaskState({
    this.selectedTab = 'All',
    this.searchQuery = '',
    this.tasks = const [],
  });

  int countForTab(String tab) {
    if (tab.startsWith('All')) return tasks.length;
    final clean = tab.split(' (').first.trim().toLowerCase();
    if (clean == 'urgent') {
      return tasks.where((t) => t.priority == TaskPriority.urgent).length;
    }
    return tasks.where((t) => t.status.label.toLowerCase() == clean).length;
  }

  List<TaskItem> get filteredTasks {
    return tasks.where((item) {
      if (selectedTab != 'All' && !selectedTab.startsWith('All')) {
        final cleanTab = selectedTab.split(' (').first.trim().toLowerCase();
        if (cleanTab == 'urgent') {
          if (item.priority != TaskPriority.urgent) return false;
        } else if (item.status.label.toLowerCase() != cleanTab) {
          return false;
        }
      }
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        return item.title.toLowerCase().contains(query) ||
            item.description.toLowerCase().contains(query) ||
            item.category.toLowerCase().contains(query);
      }
      return true;
    }).toList();
  }

  TaskState copyWith({
    String? selectedTab,
    String? searchQuery,
    List<TaskItem>? tasks,
  }) {
    return TaskState(
      selectedTab: selectedTab ?? this.selectedTab,
      searchQuery: searchQuery ?? this.searchQuery,
      tasks: tasks ?? this.tasks,
    );
  }
}

final quickTechTaskProvider =
    StateNotifierProvider<QuickTechTaskNotifier, TaskState>((ref) {
  return QuickTechTaskNotifier();
});

class QuickTechTaskNotifier extends StateNotifier<TaskState> {
  QuickTechTaskNotifier()
      : super(const TaskState(
          selectedTab: 'All',
          tasks: [
            TaskItem(
              id: '1',
              title: 'Submit Biometrics Booking for Dr. Sabrina',
              description: 'Book Canada VFS appointment slot for passport dispatch and sticker.',
              category: 'Embassy Submission',
              priority: TaskPriority.urgent,
              status: TaskStatus.completed,
              dueDate: 'Today',
              dueTime: '05:00 PM',
            ),

            TaskItem(
              id: '2',
              title: 'Follow-up with Paid Leads from Eid Campaign',
              description: 'Call 15 leads from Meta campaign ad set 2.',
              category: 'CRM Calling',
              priority: TaskPriority.medium,
              status: TaskStatus.inProgress,
              dueDate: 'Today',
              dueTime: '06:30 PM',
            ),
            TaskItem(
              id: '3',
              title: 'Verify Bank Solvency Statement for Mahmudul Hasan',
              description: 'Check 6-month transaction history and bank seal.',
              category: 'Solvency & Bank',
              priority: TaskPriority.low,
              status: TaskStatus.completed,
              dueDate: 'Today',
              dueTime: '04:30 PM',
            ),
            TaskItem(
              id: '4',
              title: 'Review Schengen Appointment Confirmation',
              description: 'Confirm appointment slot and email checklist to client.',
              category: 'Visa Processing',
              priority: TaskPriority.medium,
              status: TaskStatus.completed,
              dueDate: 'Today',
              dueTime: '03:00 PM',
            ),
          ],
        ));

  void setSelectedTab(String tab) {
    state = state.copyWith(selectedTab: tab);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void addTask({
    required String title,
    required String description,
    required String category,
    required TaskPriority priority,
    required String dueDate,
    required String dueTime,
  }) {
    final newTask = TaskItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      category: category.isEmpty ? 'General' : category,
      priority: priority,
      status: TaskStatus.pending,
      dueDate: dueDate,
      dueTime: dueTime,
    );

    state = state.copyWith(tasks: [newTask, ...state.tasks]);
    Fluttertoast.showToast(msg: "Task created successfully!");
  }

  void startTask(String id) {
    final updatedList = state.tasks.map((task) {
      if (task.id == id) {
        Fluttertoast.showToast(msg: "Task '${task.title}' marked as In Progress");
        return task.copyWith(status: TaskStatus.inProgress);
      }
      return task;
    }).toList();

    state = state.copyWith(tasks: updatedList);
  }

  void completeTask(String id) {
    final updatedList = state.tasks.map((task) {
      if (task.id == id) {
        Fluttertoast.showToast(msg: "Task '${task.title}' marked as Completed!");
        return task.copyWith(status: TaskStatus.completed);
      }
      return task;
    }).toList();

    state = state.copyWith(tasks: updatedList);
  }
}

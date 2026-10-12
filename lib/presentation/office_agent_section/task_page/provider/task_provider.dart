import '../../../../core/constant/const.dart';
import '../model/task_model.dart';

class TaskState {
  final String selectedTab;
  final String searchQuery;
  final List<TaskItem> tasks;
  final List<TaskItem> requestedTasks;

  const TaskState({
    this.selectedTab = 'All',
    this.searchQuery = '',
    this.tasks = const [],
    this.requestedTasks = const [],
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
            item.category.toLowerCase().contains(query) ||
            item.requestedBy.toLowerCase().contains(query);
      }
      return true;
    }).toList();
  }

  TaskState copyWith({
    String? selectedTab,
    String? searchQuery,
    List<TaskItem>? tasks,
    List<TaskItem>? requestedTasks,
  }) {
    return TaskState(
      selectedTab: selectedTab ?? this.selectedTab,
      searchQuery: searchQuery ?? this.searchQuery,
      tasks: tasks ?? this.tasks,
      requestedTasks: requestedTasks ?? this.requestedTasks,
    );
  }
}

final quickTechTaskProvider =
    StateNotifierProvider<QuickTechTaskNotifier, TaskState>((ref) {
  return QuickTechTaskNotifier();
});

class QuickTechTaskNotifier extends StateNotifier<TaskState> {
  QuickTechTaskNotifier()
      : super(TaskState(
          selectedTab: 'All',
          tasks: [
            const TaskItem(
              id: '1',
              title: 'Submit Biometrics Booking for Dr. Sabrina',
              description: 'Book Canada VFS appointment slot for passport dispatch and sticker.',
              category: 'Embassy Submission',
              priority: TaskPriority.urgent,
              status: TaskStatus.completed,
              dueDate: 'Today',
              dueTime: '05:00 PM',
              requestedBy: 'Sunny',
              facebookDone: true,
            ),
            const TaskItem(
              id: '2',
              title: 'Follow-up with Paid Leads from Eid Campaign',
              description: 'Call 15 leads from Meta campaign ad set 2.',
              category: 'CRM Calling',
              priority: TaskPriority.medium,
              status: TaskStatus.inProgress,
              dueDate: 'Today',
              dueTime: '06:30 PM',
              requestedBy: 'Nasir khan',
              facebookDone: false,
            ),
            const TaskItem(
              id: '3',
              title: 'Verify Bank Solvency Statement for Mahmudul Hasan',
              description: 'Check 6-month transaction history and bank seal.',
              category: 'Solvency & Bank',
              priority: TaskPriority.low,
              status: TaskStatus.completed,
              dueDate: 'Today',
              dueTime: '04:30 PM',
              requestedBy: 'Mahmudul Hasan',
              facebookDone: false,
            ),
            const TaskItem(
              id: '4',
              title: 'Review Schengen Appointment Confirmation',
              description: 'Confirm appointment slot and email checklist to client.',
              category: 'Visa Processing',
              priority: TaskPriority.medium,
              status: TaskStatus.completed,
              dueDate: 'Today',
              dueTime: '03:00 PM',
              requestedBy: 'Rezaul Korim',
              facebookDone: false,
            ),
          ],
          requestedTasks: [
            const TaskItem(
              id: 'r1',
              title: 'Prepare US B1/B2 Visa Mock Interview',
              description: 'Conduct 30-minute visa mock interview session for Mr. Rahim.',
              category: 'Visa Processing',
              priority: TaskPriority.urgent,
              status: TaskStatus.pending,
              dueDate: 'Tomorrow',
              dueTime: '11:00 AM',
              requestedBy: 'Mahim Pramanik',
            ),
            const TaskItem(
              id: 'r2',
              title: 'Collect Attested Educational Certificates',
              description: 'Receive attested degree and transcripts from Education Board.',
              category: 'Documentation',
              priority: TaskPriority.high,
              status: TaskStatus.pending,
              dueDate: 'Tomorrow',
              dueTime: '03:00 PM',
              requestedBy: 'MD Rezwan',
            ),
            const TaskItem(
              id: 'r3',
              title: 'Dispatch Courier Package for UK Student Visa',
              description: 'Send original passport and CAS letter via DHL Express.',
              category: 'Courier & Dispatch',
              priority: TaskPriority.medium,
              status: TaskStatus.pending,
              dueDate: 'In 2 Days',
              dueTime: '02:00 PM',
              requestedBy: 'Mahim Ul Islam',
            ),
          ],
        ));

  void setSelectedTab(String tab) {
    state = state.copyWith(selectedTab: tab);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void acceptRequestedTask(TaskItem task) {
    final updatedRequested = state.requestedTasks.where((t) => t.id != task.id).toList();
    final updatedTasks = [task.copyWith(status: TaskStatus.pending, facebookDone: false), ...state.tasks];

    state = state.copyWith(
      requestedTasks: updatedRequested,
      tasks: updatedTasks,
    );
    Fluttertoast.showToast(msg: "Task '${task.title}' accepted successfully!");
  }

  void toggleFacebookDone(String id) {
    final updatedList = state.tasks.map((task) {
      if (task.id == id) {
        final newValue = !task.facebookDone;
        Fluttertoast.showToast(
          msg: newValue ? "Facebook action marked as done!" : "Facebook action unmarked",
        );
        return task.copyWith(facebookDone: newValue);
      }
      return task;
    }).toList();

    state = state.copyWith(tasks: updatedList);
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

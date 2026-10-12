enum FollowupCategoryFilter {
  today('Today'),
  upcoming('Upcoming'),
  missedOverdue('Missed / Overdue'),
  completed('Completed'),
  all('All');

  final String label;
  const FollowupCategoryFilter(this.label);
}

class FollowupItem {
  final String id;
  final String name;
  final String phone;
  final String visaType;
  final String timeTag;
  final String notes;
  final String assignedAgent;
  final FollowupCategoryFilter category;
  final bool isDone;

  const FollowupItem({
    required this.id,
    required this.name,
    required this.phone,
    required this.visaType,
    required this.timeTag,
    required this.notes,
    required this.assignedAgent,
    required this.category,
    this.isDone = false,
  });

  FollowupItem copyWith({
    String? id,
    String? name,
    String? phone,
    String? visaType,
    String? timeTag,
    String? notes,
    String? assignedAgent,
    FollowupCategoryFilter? category,
    bool? isDone,
  }) {
    return FollowupItem(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      visaType: visaType ?? this.visaType,
      timeTag: timeTag ?? this.timeTag,
      notes: notes ?? this.notes,
      assignedAgent: assignedAgent ?? this.assignedAgent,
      category: category ?? this.category,
      isDone: isDone ?? this.isDone,
    );
  }
}

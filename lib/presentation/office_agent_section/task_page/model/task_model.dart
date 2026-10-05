import 'package:flutter/material.dart';

enum TaskPriority {
  urgent('Urgent', Color(0xFFDC2626), Color(0xFFFEE2E2)),
  high('High', Color(0xFFC2410C), Color(0xFFFFEDD5)),
  medium('Medium', Color(0xFF1D4ED8), Color(0xFFEFF6FF)),
  low('Low', Color(0xFF047857), Color(0xFFECFDF5));

  final String label;
  final Color textColor;
  final Color bgColor;

  const TaskPriority(this.label, this.textColor, this.bgColor);
}

enum TaskStatus {
  pending('Pending'),
  inProgress('In Progress'),
  completed('Completed');

  final String label;
  const TaskStatus(this.label);
}

class TaskItem {
  final String id;
  final String title;
  final String description;
  final String category;
  final TaskPriority priority;
  final TaskStatus status;
  final String dueDate;
  final String dueTime;

  const TaskItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.status,
    required this.dueDate,
    required this.dueTime,
  });

  TaskItem copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    TaskPriority? priority,
    TaskStatus? status,
    String? dueDate,
    String? dueTime,
  }) {
    return TaskItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      dueTime: dueTime ?? this.dueTime,
    );
  }
}

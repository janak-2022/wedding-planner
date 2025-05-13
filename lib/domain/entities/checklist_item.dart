enum ChecklistItemStatus { pending, inProgress, completed, overdue }

class ChecklistCategory {
  final String id;
  final String weddingId;
  final String name;
  final int order;
  final String? description;

  ChecklistCategory({
    required this.id,
    required this.weddingId,
    required this.name,
    required this.order,
    this.description,
  });
}

class ChecklistItem {
  final String id;
  final String weddingId;
  final String categoryId;
  final String title;
  final DateTime dueDate;
  final ChecklistItemStatus status;
  final String? assigneeId;
  final String? notes;
  final bool isHighPriority;
  final int order;

  ChecklistItem({
    required this.id,
    required this.weddingId,
    required this.categoryId,
    required this.title,
    required this.dueDate,
    required this.status,
    required this.order,
    this.assigneeId,
    this.notes,
    this.isHighPriority = false,
  });
}

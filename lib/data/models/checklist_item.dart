import '../../domain/entities/checklist_item.dart';

class ChecklistCategoryModel extends ChecklistCategory {
  ChecklistCategoryModel({
    required String id,
    required String weddingId,
    required String name,
    required int order,
    String? description,
  }) : super(
          id: id,
          weddingId: weddingId,
          name: name,
          order: order,
          description: description,
        );

  factory ChecklistCategoryModel.fromJson(Map<String, dynamic> json) {
    return ChecklistCategoryModel(
      id: json['id'],
      weddingId: json['weddingId'],
      name: json['name'],
      order: json['order'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weddingId': weddingId,
      'name': name,
      'order': order,
      'description': description,
    };
  }
}

class ChecklistItemModel extends ChecklistItem {
  ChecklistItemModel({
    required String id,
    required String weddingId,
    required String categoryId,
    required String title,
    required DateTime dueDate,
    required ChecklistItemStatus status,
    required int order,
    String? assigneeId,
    String? notes,
    bool isHighPriority = false,
  }) : super(
          id: id,
          weddingId: weddingId,
          categoryId: categoryId,
          title: title,
          dueDate: dueDate,
          status: status,
          order: order,
          assigneeId: assigneeId,
          notes: notes,
          isHighPriority: isHighPriority,
        );

  factory ChecklistItemModel.fromJson(Map<String, dynamic> json) {
    return ChecklistItemModel(
      id: json['id'],
      weddingId: json['weddingId'],
      categoryId: json['categoryId'],
      title: json['title'],
      dueDate: DateTime.parse(json['dueDate']),
      status: ChecklistItemStatus.values.byName(json['status']),
      order: json['order'],
      assigneeId: json['assigneeId'],
      notes: json['notes'],
      isHighPriority: json['isHighPriority'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weddingId': weddingId,
      'categoryId': categoryId,
      'title': title,
      'dueDate': dueDate.toIso8601String(),
      'status': status.name,
      'order': order,
      'assigneeId': assigneeId,
      'notes': notes,
      'isHighPriority': isHighPriority,
    };
  }
}

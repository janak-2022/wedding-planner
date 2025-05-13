import '../../domain/entities/budget.dart';

class BudgetCategoryModel extends BudgetCategory {
  BudgetCategoryModel({
    required String id,
    required String weddingId,
    required String name,
    required double limit,
    required int order,
    String? description,
  }) : super(
          id: id,
          weddingId: weddingId,
          name: name,
          limit: limit,
          order: order,
          description: description,
        );

  factory BudgetCategoryModel.fromJson(Map<String, dynamic> json) {
    return BudgetCategoryModel(
      id: json['id'],
      weddingId: json['weddingId'],
      name: json['name'],
      limit: json['limit'].toDouble(),
      order: json['order'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weddingId': weddingId,
      'name': name,
      'limit': limit,
      'order': order,
      'description': description,
    };
  }
}

class BudgetItemModel extends BudgetItem {
  BudgetItemModel({
    required String id,
    required String categoryId,
    required String description,
    required double amount,
    required bool isPaid,
    DateTime? paymentDate,
    String? vendorId,
    String? notes,
    List<String>? attachments,
  }) : super(
          id: id,
          categoryId: categoryId,
          description: description,
          amount: amount,
          isPaid: isPaid,
          paymentDate: paymentDate,
          vendorId: vendorId,
          notes: notes,
          attachments: attachments,
        );

  factory BudgetItemModel.fromJson(Map<String, dynamic> json) {
    return BudgetItemModel(
      id: json['id'],
      categoryId: json['categoryId'],
      description: json['description'],
      amount: json['amount'].toDouble(),
      isPaid: json['isPaid'],
      paymentDate: json['paymentDate'] != null ? DateTime.parse(json['paymentDate']) : null,
      vendorId: json['vendorId'],
      notes: json['notes'],
      attachments: List<String>.from(json['attachments'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'description': description,
      'amount': amount,
      'isPaid': isPaid,
      'paymentDate': paymentDate?.toIso8601String(),
      'vendorId': vendorId,
      'notes': notes,
      'attachments': attachments,
    };
  }
}

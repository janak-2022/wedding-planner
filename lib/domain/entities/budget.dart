class BudgetCategory {
  final String id;
  final String weddingId;
  final String name;
  final double limit;
  final int order;
  final String? description;

  BudgetCategory({
    required this.id,
    required this.weddingId,
    required this.name,
    required this.limit,
    required this.order,
    this.description,
  });
}

class BudgetItem {
  final String id;
  final String categoryId;
  final String description;
  final double amount;
  final bool isPaid;
  final DateTime? paymentDate;
  final String? vendorId;
  final String? notes;
  final List<String>? attachments;

  BudgetItem({
    required this.id,
    required this.categoryId,
    required this.description,
    required this.amount,
    required this.isPaid,
    this.paymentDate,
    this.vendorId,
    this.notes,
    this.attachments,
  });
}

enum ExpenseStatus { pending, paid, overdue, cancelled }

enum ExpenseCategory {
  venue,
  catering,
  decoration,
  photography,
  entertainment,
  attire,
  transportation,
  accommodation,
  other
}

class Expense {
  final String id;
  final String weddingId;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final ExpenseStatus status;
  final DateTime dueDate;
  final String? vendorId;
  final String? notes;
  final List<String>? attachments;
  final DateTime? paymentDate;

  Expense({
    required this.id,
    required this.weddingId,
    required this.title,
    required this.amount,
    required this.category,
    required this.status,
    required this.dueDate,
    this.vendorId,
    this.notes,
    this.attachments,
    this.paymentDate,
  });
}

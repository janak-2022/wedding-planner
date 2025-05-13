import '../../domain/entities/expense.dart';

class ExpenseModel extends Expense {
  ExpenseModel({
    required String id,
    required String weddingId,
    required String title,
    required double amount,
    required ExpenseCategory category,
    required ExpenseStatus status,
    required DateTime dueDate,
    String? vendorId,
    String? notes,
    List<String>? attachments,
    DateTime? paymentDate,
  }) : super(
          id: id,
          weddingId: weddingId,
          title: title,
          amount: amount,
          category: category,
          status: status,
          dueDate: dueDate,
          vendorId: vendorId,
          notes: notes,
          attachments: attachments,
          paymentDate: paymentDate,
        );

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      weddingId: json['weddingId'],
      title: json['title'],
      amount: json['amount'].toDouble(),
      category: ExpenseCategory.values.byName(json['category']),
      status: ExpenseStatus.values.byName(json['status']),
      dueDate: DateTime.parse(json['dueDate']),
      vendorId: json['vendorId'],
      notes: json['notes'],
      attachments: json['attachments'] != null 
          ? List<String>.from(json['attachments'])
          : null,
      paymentDate: json['paymentDate'] != null 
          ? DateTime.parse(json['paymentDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weddingId': weddingId,
      'title': title,
      'amount': amount,
      'category': category.name,
      'status': status.name,
      'dueDate': dueDate.toIso8601String(),
      'vendorId': vendorId,
      'notes': notes,
      'attachments': attachments,
      'paymentDate': paymentDate?.toIso8601String(),
    };
  }
}

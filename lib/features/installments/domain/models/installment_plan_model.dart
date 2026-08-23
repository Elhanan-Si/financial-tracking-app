/// Installment Plan Domain Model
class InstallmentPlanModel {
  final String id;
  final String accountId;
  final String? accountName;
  final String? categoryId;
  final String? categoryName;
  final String? merchantId;
  final String? merchantName;
  final double totalAmount;
  final double? firstInstallmentAmount;
  final int numberOfInstallments;
  final DateTime firstDueDate;
  final String? note;
  final List<InstallmentItemModel> items;
  final DateTime createdAt;

  const InstallmentPlanModel({
    required this.id,
    required this.accountId,
    this.accountName,
    this.categoryId,
    this.categoryName,
    this.merchantId,
    this.merchantName,
    required this.totalAmount,
    this.firstInstallmentAmount,
    required this.numberOfInstallments,
    required this.firstDueDate,
    this.note,
    this.items = const [],
    required this.createdAt,
  });

  double get monthlyAmount => (totalAmount / numberOfInstallments);
  int get paidCount => items.where((i) => i.isPaid).length;
  double get paidAmount => items.where((i) => i.isPaid).fold(0.0, (sum, i) => sum + i.amount);
  double get remainingAmount => totalAmount - paidAmount;
  bool get isCompleted => paidCount >= numberOfInstallments;
}

/// Single Installment Item Domain Model
class InstallmentItemModel {
  final String id;
  final String installmentPlanId;
  final String? transactionId;
  final int installmentNumber;
  final double amount;
  final DateTime dueDate;
  final bool isPaid;
  final DateTime createdAt;

  const InstallmentItemModel({
    required this.id,
    required this.installmentPlanId,
    this.transactionId,
    required this.installmentNumber,
    required this.amount,
    required this.dueDate,
    this.isPaid = false,
    required this.createdAt,
  });
}

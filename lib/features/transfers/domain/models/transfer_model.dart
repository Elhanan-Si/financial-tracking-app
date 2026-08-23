/// Internal Transfer Domain Model
class TransferModel {
  final String id;
  final String sourceTransactionId;
  final String destinationTransactionId;
  final String sourceAccountId;
  final String? sourceAccountName;
  final String destinationAccountId;
  final String? destinationAccountName;
  final double amount;
  final double destinationAmount;
  final double exchangeRate;
  final DateTime date;
  final String? note;
  final DateTime createdAt;

  const TransferModel({
    required this.id,
    required this.sourceTransactionId,
    required this.destinationTransactionId,
    required this.sourceAccountId,
    this.sourceAccountName,
    required this.destinationAccountId,
    this.destinationAccountName,
    required this.amount,
    required this.destinationAmount,
    this.exchangeRate = 1.0,
    required this.date,
    this.note,
    required this.createdAt,
  });
}

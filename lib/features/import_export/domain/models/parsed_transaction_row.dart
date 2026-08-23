/// Single raw or mapped row parsed from an uploaded CSV/Excel bank or card statement
class ParsedTransactionRow {
  final int rowIndex;
  final DateTime date;
  final String rawDescription;
  final String? merchantName;
  final double amount; // Positive = Income, Negative = Expense (or standard signed format)
  final String? categoryId;
  final String? categoryName;
  final String? referenceNumber;
  final String? originalCurrency;
  final double? originalAmount;
  final String? notes;
  final bool isValid;
  final String? validationError;

  const ParsedTransactionRow({
    required this.rowIndex,
    required this.date,
    required this.rawDescription,
    this.merchantName,
    required this.amount,
    this.categoryId,
    this.categoryName,
    this.referenceNumber,
    this.originalCurrency,
    this.originalAmount,
    this.notes,
    this.isValid = true,
    this.validationError,
  });

  bool get isExpense => amount < 0 || (amount > 0 && !isIncome);
  bool get isIncome => false; // Resolved based on column mapping / sign

  ParsedTransactionRow copyWith({
    int? rowIndex,
    DateTime? date,
    String? rawDescription,
    String? merchantName,
    double? amount,
    String? categoryId,
    String? categoryName,
    String? referenceNumber,
    String? originalCurrency,
    double? originalAmount,
    String? notes,
    bool? isValid,
    String? validationError,
  }) {
    return ParsedTransactionRow(
      rowIndex: rowIndex ?? this.rowIndex,
      date: date ?? this.date,
      rawDescription: rawDescription ?? this.rawDescription,
      merchantName: merchantName ?? this.merchantName,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      originalCurrency: originalCurrency ?? this.originalCurrency,
      originalAmount: originalAmount ?? this.originalAmount,
      notes: notes ?? this.notes,
      isValid: isValid ?? this.isValid,
      validationError: validationError ?? this.validationError,
    );
  }
}

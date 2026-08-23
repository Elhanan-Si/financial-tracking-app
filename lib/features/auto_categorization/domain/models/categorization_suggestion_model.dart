/// Represents an uncategorized transaction along with the system's smart suggestion
class CategorizationSuggestionModel {
  final String transactionId;
  final String description;
  final double amount;
  final DateTime date;
  final String accountId;
  final String? accountName;
  final String? suggestedCategoryId;
  final String? suggestedCategoryName;
  final int? suggestedCategoryColor;
  final String? suggestedCategoryIcon;
  final double confidenceScore; // 0.0 to 1.0
  final String reason; // 'כלל ידני', 'היסטוריית סיווג (90%+)', 'בית עסק מוכר'

  const CategorizationSuggestionModel({
    required this.transactionId,
    required this.description,
    required this.amount,
    required this.date,
    required this.accountId,
    this.accountName,
    this.suggestedCategoryId,
    this.suggestedCategoryName,
    this.suggestedCategoryColor,
    this.suggestedCategoryIcon,
    required this.confidenceScore,
    required this.reason,
  });

  bool get hasSuggestion => suggestedCategoryId != null && suggestedCategoryId!.isNotEmpty;

  CategorizationSuggestionModel copyWith({
    String? transactionId,
    String? description,
    double? amount,
    DateTime? date,
    String? accountId,
    String? accountName,
    String? suggestedCategoryId,
    String? suggestedCategoryName,
    int? suggestedCategoryColor,
    String? suggestedCategoryIcon,
    double? confidenceScore,
    String? reason,
  }) {
    return CategorizationSuggestionModel(
      transactionId: transactionId ?? this.transactionId,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      accountId: accountId ?? this.accountId,
      accountName: accountName ?? this.accountName,
      suggestedCategoryId: suggestedCategoryId ?? this.suggestedCategoryId,
      suggestedCategoryName: suggestedCategoryName ?? this.suggestedCategoryName,
      suggestedCategoryColor: suggestedCategoryColor ?? this.suggestedCategoryColor,
      suggestedCategoryIcon: suggestedCategoryIcon ?? this.suggestedCategoryIcon,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      reason: reason ?? this.reason,
    );
  }
}

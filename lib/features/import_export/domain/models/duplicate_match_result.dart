import '../../../transactions/domain/models/transaction_model.dart';
import 'parsed_transaction_row.dart';

enum DuplicateConfidenceLevel {
  /// Exact match: same account, same amount, same date, high description similarity
  exact,

  /// Fuzzy match: same amount, date within +/- 2 days, partial description similarity
  fuzzy,

  /// No match found: fresh new transaction
  none;

  String get labelHebrew {
    switch (this) {
      case DuplicateConfidenceLevel.exact:
        return 'התאמה ודאית (איחוד אוטומטי)';
      case DuplicateConfidenceLevel.fuzzy:
        return 'התאמה סבירה (דורש אישור)';
      case DuplicateConfidenceLevel.none:
        return 'תנועה חדשה';
    }
  }
}

enum DuplicateResolutionAction {
  merge, // Merge with existing transaction
  importAsNew, // Import as separate new transaction
  skip, // Do not import this row
}

/// Result of evaluating a single parsed row against database for duplicates
class DuplicateMatchResult {
  final ParsedTransactionRow parsedRow;
  final DuplicateConfidenceLevel confidence;
  final TransactionModel? matchedTransaction;
  final double similarityScore; // 0.0 to 1.0
  final DuplicateResolutionAction resolution;

  const DuplicateMatchResult({
    required this.parsedRow,
    required this.confidence,
    this.matchedTransaction,
    this.similarityScore = 0.0,
    this.resolution = DuplicateResolutionAction.importAsNew,
  });

  DuplicateMatchResult copyWith({
    ParsedTransactionRow? parsedRow,
    DuplicateConfidenceLevel? confidence,
    TransactionModel? matchedTransaction,
    double? similarityScore,
    DuplicateResolutionAction? resolution,
  }) {
    return DuplicateMatchResult(
      parsedRow: parsedRow ?? this.parsedRow,
      confidence: confidence ?? this.confidence,
      matchedTransaction: matchedTransaction ?? this.matchedTransaction,
      similarityScore: similarityScore ?? this.similarityScore,
      resolution: resolution ?? this.resolution,
    );
  }
}

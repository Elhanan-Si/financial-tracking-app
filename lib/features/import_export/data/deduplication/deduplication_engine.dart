import 'dart:math';
import '../../../transactions/domain/models/transaction_model.dart';
import '../../domain/models/duplicate_match_result.dart';
import '../../domain/models/parsed_transaction_row.dart';

/// Intelligent Deduplication and Merge Evaluation Engine
class DeduplicationEngine {
  /// Evaluates a list of parsed rows against existing account transactions
  static List<DuplicateMatchResult> evaluateDuplicates({
    required List<ParsedTransactionRow> parsedRows,
    required List<TransactionModel> existingTransactions,
    required String accountId,
  }) {
    final results = <DuplicateMatchResult>[];

    // Filter existing to this account
    final accountTx = existingTransactions.where((tx) => tx.accountId == accountId).toList();

    for (final row in parsedRows) {
      if (!row.isValid) {
        results.add(
          DuplicateMatchResult(
            parsedRow: row,
            confidence: DuplicateConfidenceLevel.none,
            resolution: DuplicateResolutionAction.skip,
          ),
        );
        continue;
      }

      TransactionModel? bestMatch;
      DuplicateConfidenceLevel bestConfidence = DuplicateConfidenceLevel.none;
      double highestScore = 0.0;

      for (final tx in accountTx) {
        // Compare amounts (ignoring sign if necessary)
        final rowAbs = row.amount.abs();
        final txAbs = tx.amount.abs();
        final amountDiff = (rowAbs - txAbs).abs();
        if (amountDiff > 0.01) continue;

        // Check reference number match
        if (row.referenceNumber != null &&
            row.referenceNumber!.isNotEmpty &&
            tx.transferLinkId == row.referenceNumber) {
          bestMatch = tx;
          bestConfidence = DuplicateConfidenceLevel.exact;
          highestScore = 1.0;
          break;
        }

        // Compare dates
        final daysDiff = row.date.difference(tx.date).inDays.abs();

        // Calculate string similarity between descriptions
        final simScore = _calculateStringSimilarity(
          row.merchantName ?? row.rawDescription,
          tx.merchantName ?? tx.note ?? '',
        );

        if (daysDiff == 0 && simScore >= 0.7) {
          bestMatch = tx;
          bestConfidence = DuplicateConfidenceLevel.exact;
          highestScore = simScore;
          break;
        } else if (daysDiff <= 2 && simScore >= 0.4) {
          if (simScore > highestScore) {
            highestScore = simScore;
            bestMatch = tx;
            bestConfidence = DuplicateConfidenceLevel.fuzzy;
          }
        }
      }

      final resolution = bestConfidence == DuplicateConfidenceLevel.exact
          ? DuplicateResolutionAction.merge
          : (bestConfidence == DuplicateConfidenceLevel.fuzzy
              ? DuplicateResolutionAction.merge
              : DuplicateResolutionAction.importAsNew);

      results.add(
        DuplicateMatchResult(
          parsedRow: row,
          confidence: bestConfidence,
          matchedTransaction: bestMatch,
          similarityScore: highestScore,
          resolution: resolution,
        ),
      );
    }

    return results;
  }

  /// Calculates text similarity between 0.0 (completely different) and 1.0 (identical)
  static double _calculateStringSimilarity(String s1, String s2) {
    final str1 = _normalize(s1);
    final str2 = _normalize(s2);

    if (str1.isEmpty || str2.isEmpty) return 0.0;
    if (str1 == str2) return 1.0;
    if (str1.contains(str2) || str2.contains(str1)) return 0.85;

    // Token-based Jaccard similarity
    final tokens1 = str1.split(' ').where((t) => t.isNotEmpty).toSet();
    final tokens2 = str2.split(' ').where((t) => t.isNotEmpty).toSet();

    final intersection = tokens1.intersection(tokens2).length;
    final union = tokens1.union(tokens2).length;

    if (union == 0) return 0.0;
    final jaccard = intersection / union;

    // Levenshtein distance similarity
    final lev = _levenshteinDistance(str1, str2);
    final maxLen = max(str1.length, str2.length);
    final levSim = maxLen > 0 ? (1.0 - (lev / maxLen)) : 0.0;

    return (jaccard * 0.5) + (levSim * 0.5);
  }

  static String _normalize(String s) {
    return s
        .toLowerCase()
        .replaceAll(RegExp(r'בע"מ|בעמ|שיווק|סניף.*|בע״מ|\bLTD\b|\bINC\b', caseSensitive: false), '')
        .replaceAll(RegExp(r'[\*\#\-\_\d]'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static int _levenshteinDistance(String s, String t) {
    if (s == t) return 0;
    if (s.isEmpty) return t.length;
    if (t.isEmpty) return s.length;

    final v0 = List<int>.filled(t.length + 1, 0);
    final v1 = List<int>.filled(t.length + 1, 0);

    for (int i = 0; i <= t.length; i++) {
      v0[i] = i;
    }

    for (int i = 0; i < s.length; i++) {
      v1[0] = i + 1;

      for (int j = 0; j < t.length; j++) {
        final cost = (s.codeUnitAt(i) == t.codeUnitAt(j)) ? 0 : 1;
        v1[j + 1] = min(v1[j] + 1, min(v0[j + 1] + 1, v0[j] + cost));
      }

      for (int j = 0; j <= t.length; j++) {
        v0[j] = v1[j];
      }
    }

    return v1[t.length];
  }
}

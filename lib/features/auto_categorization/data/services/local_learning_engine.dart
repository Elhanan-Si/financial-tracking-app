import '../../domain/models/category_rule_model.dart';

class LocalLearningEngine {
  /// Resolves the best category suggestion for a transaction description
  static ({
    String? categoryId,
    double confidence,
    String reason,
  }) evaluateSuggestion({
    required String rawDescription,
    String? merchantDefaultCategoryId,
    required List<CategoryRuleModel> activeRules,
    required Map<String, Map<String, int>> merchantCategoryFrequency,
  }) {
    final normalized = _normalize(rawDescription);

    // 1. Check user-defined rules (highest priority)
    for (final rule in activeRules) {
      if (rule.matches(rawDescription) || rule.matches(normalized)) {
        return (
          categoryId: rule.categoryId,
          confidence: 1.0,
          reason: 'כלל ידני: "${rule.pattern}"',
        );
      }
    }

    // 2. Check statistical learning (90%+ past consistency)
    if (merchantCategoryFrequency.containsKey(normalized)) {
      final categoryCounts = merchantCategoryFrequency[normalized]!;
      int total = 0;
      String? topCat;
      int topCount = 0;

      categoryCounts.forEach((catId, count) {
        total += count;
        if (count > topCount) {
          topCount = count;
          topCat = catId;
        }
      });

      if (total >= 2 && topCat != null) {
        final ratio = topCount / total;
        if (ratio >= 0.90) {
          final pct = (ratio * 100).toInt();
          return (
            categoryId: topCat,
            confidence: ratio,
            reason: 'היסטוריית סיווג ($pct%)',
          );
        }
      }
    }

    // 3. Check merchant default
    if (merchantDefaultCategoryId != null && merchantDefaultCategoryId.isNotEmpty) {
      return (
        categoryId: merchantDefaultCategoryId,
        confidence: 0.85,
        reason: 'בית עסק מוכר',
      );
    }

    return (
      categoryId: null,
      confidence: 0.0,
      reason: 'ללא הצעה',
    );
  }

  static String _normalize(String s) {
    return s
        .toLowerCase()
        .replaceAll(RegExp(r'בע"מ|בעמ|שיווק|סניף.*|בע״מ|\bLTD\b|\bINC\b', caseSensitive: false), '')
        .replaceAll(RegExp(r'[\*\#\-\_\d]'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}

import 'dart:convert';

enum RuleMatchType {
  contains,
  exact,
  startsWith;

  String get labelHebrew {
    switch (this) {
      case RuleMatchType.contains:
        return 'מכיל את הטקסט';
      case RuleMatchType.exact:
        return 'זהה בדיוק';
      case RuleMatchType.startsWith:
        return 'מתחיל ב-';
    }
  }
}

/// Custom user-defined categorization rule (e.g., Description contains 'פז' -> Category 'רכב ודלק')
class CategoryRuleModel {
  final String id;
  final String pattern;
  final RuleMatchType matchType;
  final String categoryId;
  final String? categoryName;
  final int? categoryColor;
  final String? categoryIcon;
  final bool isEnabled;
  final int priority;
  final DateTime createdAt;

  const CategoryRuleModel({
    required this.id,
    required this.pattern,
    this.matchType = RuleMatchType.contains,
    required this.categoryId,
    this.categoryName,
    this.categoryColor,
    this.categoryIcon,
    this.isEnabled = true,
    this.priority = 0,
    required this.createdAt,
  });

  bool matches(String text) {
    if (!isEnabled || text.trim().isEmpty) return false;
    final normalizedText = text.trim().toLowerCase();
    final normalizedPattern = pattern.trim().toLowerCase();

    switch (matchType) {
      case RuleMatchType.contains:
        return normalizedText.contains(normalizedPattern);
      case RuleMatchType.exact:
        return normalizedText == normalizedPattern;
      case RuleMatchType.startsWith:
        return normalizedText.startsWith(normalizedPattern);
    }
  }

  Map<String, dynamic> toJsonMap() {
    return {
      'id': id,
      'pattern': pattern,
      'matchType': matchType.name,
      'categoryId': categoryId,
      'isEnabled': isEnabled,
      'priority': priority,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String toJsonString() => jsonEncode(toJsonMap());

  factory CategoryRuleModel.fromJsonMap(Map<String, dynamic> map, {String? categoryName, int? categoryColor, String? categoryIcon}) {
    return CategoryRuleModel(
      id: map['id'] as String,
      pattern: map['pattern'] as String,
      matchType: RuleMatchType.values.firstWhere(
        (m) => m.name == map['matchType'],
        orElse: () => RuleMatchType.contains,
      ),
      categoryId: map['categoryId'] as String,
      categoryName: categoryName,
      categoryColor: categoryColor,
      categoryIcon: categoryIcon,
      isEnabled: map['isEnabled'] as bool? ?? true,
      priority: map['priority'] as int? ?? 0,
      createdAt: DateTime.tryParse(map['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

import '../models/categorization_suggestion_model.dart';
import '../models/category_rule_model.dart';

abstract class AutoCategorizationRepository {
  Stream<List<CategoryRuleModel>> watchCategoryRules();
  Future<List<CategoryRuleModel>> getCategoryRules();
  Future<void> saveCategoryRule(CategoryRuleModel rule);
  Future<void> deleteCategoryRule(String ruleId);

  /// Retrieves uncategorized transactions with smart category suggestions
  Future<List<CategorizationSuggestionModel>> getUncategorizedTransactionsWithSuggestions();

  /// Applies category assignments in a single atomic transaction
  Future<void> batchApplySuggestions(List<CategorizationSuggestionModel> assignments);

  /// Applies a specific rule retroactively to past uncategorized transactions
  Future<int> applyRuleRetroactively(CategoryRuleModel rule);
}

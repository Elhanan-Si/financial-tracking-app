import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../data/repositories/auto_categorization_repository_impl.dart';
import '../../domain/models/categorization_suggestion_model.dart';
import '../../domain/models/category_rule_model.dart';
import '../../domain/repositories/auto_categorization_repository.dart';

final autoCategorizationRepositoryProvider = Provider<AutoCategorizationRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return AutoCategorizationRepositoryImpl(db);
});

final categoryRulesStreamProvider = StreamProvider<List<CategoryRuleModel>>((ref) {
  final repo = ref.watch(autoCategorizationRepositoryProvider);
  return repo.watchCategoryRules();
});

final uncategorizedSuggestionsProvider =
    StateNotifierProvider<UncategorizedSuggestionsNotifier, AsyncValue<List<CategorizationSuggestionModel>>>((ref) {
  final repo = ref.watch(autoCategorizationRepositoryProvider);
  return UncategorizedSuggestionsNotifier(repo);
});

class UncategorizedSuggestionsNotifier extends StateNotifier<AsyncValue<List<CategorizationSuggestionModel>>> {
  final AutoCategorizationRepository _repo;

  UncategorizedSuggestionsNotifier(this._repo) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final list = await _repo.getUncategorizedTransactionsWithSuggestions();
      state = AsyncValue.data(list);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void updateCategory(String transactionId, String categoryId, String categoryName, int categoryColor, String categoryIcon) {
    state.whenData((list) {
      final updated = list.map((item) {
        if (item.transactionId == transactionId) {
          return item.copyWith(
            suggestedCategoryId: categoryId,
            suggestedCategoryName: categoryName,
            suggestedCategoryColor: categoryColor,
            suggestedCategoryIcon: categoryIcon,
            confidenceScore: 1.0,
            reason: 'בחירה ידנית',
          );
        }
        return item;
      }).toList();
      state = AsyncValue.data(updated);
    });
  }

  Future<void> applyAll() async {
    final currentList = state.value ?? [];
    final toApply = currentList.where((i) => i.hasSuggestion).toList();
    if (toApply.isEmpty) return;

    await _repo.batchApplySuggestions(toApply);
    await refresh();
  }
}

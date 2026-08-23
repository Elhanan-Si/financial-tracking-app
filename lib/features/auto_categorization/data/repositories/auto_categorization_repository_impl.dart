import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/models/categorization_suggestion_model.dart';
import '../../domain/models/category_rule_model.dart';
import '../../domain/repositories/auto_categorization_repository.dart';
import '../services/local_learning_engine.dart';

class AutoCategorizationRepositoryImpl implements AutoCategorizationRepository {
  final AppDatabase _db;

  AutoCategorizationRepositoryImpl(this._db);

  @override
  Stream<List<CategoryRuleModel>> watchCategoryRules() {
    final query = _db.select(_db.importMappingsTable)
      ..where((tbl) => tbl.sourceName.equals('category_rule'))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)]);

    return query.watch().asyncMap((rows) async {
      return await _mapRuleRows(rows);
    });
  }

  @override
  Future<List<CategoryRuleModel>> getCategoryRules() async {
    final rows = await (_db.select(_db.importMappingsTable)
          ..where((tbl) => tbl.sourceName.equals('category_rule'))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)]))
        .get();

    return await _mapRuleRows(rows);
  }

  Future<List<CategoryRuleModel>> _mapRuleRows(List<ImportMappingEntry> rows) async {
    final rules = <CategoryRuleModel>[];
    final categories = await _db.select(_db.categoriesTable).get();
    final catMap = {for (var c in categories) c.id: c};

    for (final row in rows) {
      try {
        final map = jsonDecode(row.mappingConfigJson) as Map<String, dynamic>;
        final catId = map['categoryId'] as String;
        final cat = catMap[catId];

        rules.add(
          CategoryRuleModel.fromJsonMap(
            map,
            categoryName: cat?.name,
            categoryColor: cat?.colorValue,
            categoryIcon: cat?.iconName,
          ),
        );
      } catch (_) {}
    }
    return rules;
  }

  @override
  Future<void> saveCategoryRule(CategoryRuleModel rule) async {
    final now = DateTime.now();
    final existing = await (_db.select(_db.importMappingsTable)
          ..where((tbl) => tbl.id.equals(rule.id) & tbl.sourceName.equals('category_rule')))
        .getSingleOrNull();

    if (existing != null) {
      await (_db.update(_db.importMappingsTable)..where((tbl) => tbl.id.equals(existing.id))).write(
        ImportMappingsTableCompanion(
          mappingConfigJson: Value(rule.toJsonString()),
          updatedAt: Value(now),
        ),
      );
    } else {
      await _db.into(_db.importMappingsTable).insert(
            ImportMappingsTableCompanion.insert(
              id: rule.id.isNotEmpty ? rule.id : 'rule_${DateTime.now().millisecondsSinceEpoch}',
              sourceName: 'category_rule',
              mappingConfigJson: rule.toJsonString(),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
    }
  }

  @override
  Future<void> deleteCategoryRule(String ruleId) async {
    await (_db.delete(_db.importMappingsTable)..where((tbl) => tbl.id.equals(ruleId))).go();
  }

  @override
  Future<List<CategorizationSuggestionModel>> getUncategorizedTransactionsWithSuggestions() async {
    // 1. Get all uncategorized transactions
    final query = _db.select(_db.transactionsTable).join([
      innerJoin(_db.accountsTable, _db.accountsTable.id.equalsExp(_db.transactionsTable.accountId)),
      leftOuterJoin(_db.merchantsTable, _db.merchantsTable.id.equalsExp(_db.transactionsTable.merchantId)),
    ]);
    query.where(_db.transactionsTable.categoryId.isNull());
    query.orderBy([OrderingTerm(expression: _db.transactionsTable.date, mode: OrderingMode.desc)]);

    final rows = await query.get();
    if (rows.isEmpty) return [];

    // 2. Load active rules
    final rules = await getCategoryRules();

    // 3. Load all historical categorized transactions to build statistical frequencies
    final pastCategorized = await (_db.select(_db.transactionsTable)
          ..where((tbl) => tbl.categoryId.isNotNull()))
        .get();

    final frequencies = <String, Map<String, int>>{};
    for (final tx in pastCategorized) {
      final desc = (tx.note ?? '').toLowerCase().trim();
      final catId = tx.categoryId!;
      if (desc.isEmpty) continue;

      frequencies.putIfAbsent(desc, () => {});
      frequencies[desc]![catId] = (frequencies[desc]![catId] ?? 0) + 1;
    }

    // 4. Load all categories for lookups
    final allCats = await _db.select(_db.categoriesTable).get();
    final catMap = {for (var c in allCats) c.id: c};

    final suggestions = <CategorizationSuggestionModel>[];

    for (final row in rows) {
      final tx = row.readTable(_db.transactionsTable);
      final acc = row.readTable(_db.accountsTable);
      final merchant = row.readTableOrNull(_db.merchantsTable);

      final eval = LocalLearningEngine.evaluateSuggestion(
        rawDescription: tx.note ?? '',
        merchantDefaultCategoryId: merchant?.defaultCategoryId,
        activeRules: rules,
        merchantCategoryFrequency: frequencies,
      );

      final cat = eval.categoryId != null ? catMap[eval.categoryId] : null;

      suggestions.add(
        CategorizationSuggestionModel(
          transactionId: tx.id,
          description: tx.note ?? 'תנועה ללא תיאור',
          amount: tx.amount,
          date: tx.date,
          accountId: acc.id,
          accountName: acc.name,
          suggestedCategoryId: eval.categoryId,
          suggestedCategoryName: cat?.name,
          suggestedCategoryColor: cat?.colorValue,
          suggestedCategoryIcon: cat?.iconName,
          confidenceScore: eval.confidence,
          reason: eval.reason,
        ),
      );
    }

    return suggestions;
  }

  @override
  Future<void> batchApplySuggestions(List<CategorizationSuggestionModel> assignments) async {
    await _db.transaction(() async {
      final now = DateTime.now();

      for (final item in assignments) {
        if (item.suggestedCategoryId == null) continue;

        await (_db.update(_db.transactionsTable)..where((tbl) => tbl.id.equals(item.transactionId))).write(
          TransactionsTableCompanion(
            categoryId: Value(item.suggestedCategoryId),
            isAutoCategorized: const Value(true),
            updatedAt: Value(now),
          ),
        );
      }
    });
  }

  @override
  Future<int> applyRuleRetroactively(CategoryRuleModel rule) async {
    return await _db.transaction(() async {
      final uncategorized = await (_db.select(_db.transactionsTable)
            ..where((tbl) => tbl.categoryId.isNull()))
          .get();

      int appliedCount = 0;
      final now = DateTime.now();

      for (final tx in uncategorized) {
        final desc = tx.note ?? '';
        if (rule.matches(desc)) {
          await (_db.update(_db.transactionsTable)..where((tbl) => tbl.id.equals(tx.id))).write(
            TransactionsTableCompanion(
              categoryId: Value(rule.categoryId),
              isAutoCategorized: const Value(true),
              updatedAt: Value(now),
            ),
          );
          appliedCount++;
        }
      }

      return appliedCount;
    });
  }
}

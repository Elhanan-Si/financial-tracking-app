import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/merchant_model.dart';
import '../../domain/models/tag_model.dart';
import '../../domain/repositories/categories_repository.dart';

/// Concrete implementation of CategoriesRepository using Drift Database
class CategoriesRepositoryImpl implements CategoriesRepository {
  final AppDatabase _db;

  CategoriesRepositoryImpl(this._db);

  @override
  Stream<List<CategoryModel>> watchCategoryTree({String? type}) {
    return _db.watchAllCategories().map((allEntries) {
      final entries = type != null
          ? allEntries.where((c) => c.type == type).toList()
          : allEntries;

      final parents = entries.where((c) => c.parentId == null).toList();
      final children = entries.where((c) => c.parentId != null).toList();

      return parents.map((parent) {
        final subcats = children
            .where((child) => child.parentId == parent.id)
            .map(_entryToModel)
            .toList();

        return _entryToModel(parent, subcategories: subcats);
      }).toList();
    });
  }

  @override
  Stream<List<CategoryModel>> watchAllCategories({String? type}) {
    return _db.watchAllCategories().map((entries) {
      var list = entries;
      if (type != null) {
        list = list.where((c) => c.type == type).toList();
      }
      return list.map((e) => _entryToModel(e)).toList();
    });
  }

  @override
  Future<CategoryModel?> getCategoryById(String id) async {
    final query = _db.select(_db.categoriesTable)..where((tbl) => tbl.id.equals(id));
    final entry = await query.getSingleOrNull();
    if (entry == null) return null;
    return _entryToModel(entry);
  }

  @override
  Future<String> createCategory(CategoryModel category) async {
    final id = category.id.isNotEmpty ? category.id : 'cat_${DateTime.now().millisecondsSinceEpoch}';
    final companion = CategoriesTableCompanion.insert(
      id: id,
      parentId: Value(category.parentId),
      name: category.name,
      type: category.type,
      spendingClassification: Value(category.spendingClassification.name),
      flexibility: Value(category.flexibility.name),
      colorValue: Value(category.colorValue),
      iconName: Value(category.iconName),
      isDefault: Value(category.isDefault),
      isArchived: Value(category.isArchived),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );
    await _db.into(_db.categoriesTable).insert(companion);
    return id;
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    final companion = CategoriesTableCompanion(
      name: Value(category.name),
      parentId: Value(category.parentId),
      type: Value(category.type),
      spendingClassification: Value(category.spendingClassification.name),
      flexibility: Value(category.flexibility.name),
      colorValue: Value(category.colorValue),
      iconName: Value(category.iconName),
      isArchived: Value(category.isArchived),
      updatedAt: Value(DateTime.now()),
    );
    await (_db.update(_db.categoriesTable)..where((tbl) => tbl.id.equals(category.id))).write(companion);
  }

  @override
  Future<void> deleteCategory(String categoryId, {String? replacementCategoryId}) async {
    await _db.transaction(() async {
      if (replacementCategoryId != null && replacementCategoryId.isNotEmpty) {
        // Re-assign transactions
        await (_db.update(_db.transactionsTable)..where((tbl) => tbl.categoryId.equals(categoryId)))
            .write(TransactionsTableCompanion(categoryId: Value(replacementCategoryId)));

        // Re-assign splits
        await (_db.update(_db.transactionSplitsTable)..where((tbl) => tbl.categoryId.equals(categoryId)))
            .write(TransactionSplitsTableCompanion(categoryId: Value(replacementCategoryId)));

        // Re-assign child categories
        await (_db.update(_db.categoriesTable)..where((tbl) => tbl.parentId.equals(categoryId)))
            .write(CategoriesTableCompanion(parentId: Value(replacementCategoryId)));
      } else {
        // Nullify transactions
        await (_db.update(_db.transactionsTable)..where((tbl) => tbl.categoryId.equals(categoryId)))
            .write(const TransactionsTableCompanion(categoryId: Value(null)));

        // Delete child categories
        await (_db.delete(_db.categoriesTable)..where((tbl) => tbl.parentId.equals(categoryId))).go();
      }

      // Delete the category itself
      await (_db.delete(_db.categoriesTable)..where((tbl) => tbl.id.equals(categoryId))).go();
    });
  }

  // === TAGS ===

  @override
  Stream<List<TagModel>> watchAllTags() {
    return (_db.select(_db.tagsTable)..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .watch()
        .map((entries) => entries.map((e) => TagModel(id: e.id, name: e.name, colorValue: e.colorValue, createdAt: e.createdAt)).toList());
  }

  @override
  Future<String> createTag(String name, int colorValue) async {
    final id = 'tag_${DateTime.now().millisecondsSinceEpoch}';
    await _db.into(_db.tagsTable).insert(
          TagsTableCompanion.insert(
            id: id,
            name: name,
            colorValue: Value(colorValue),
            createdAt: Value(DateTime.now()),
          ),
        );
    return id;
  }

  @override
  Future<void> deleteTag(String id) async {
    await (_db.delete(_db.tagsTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  // === MERCHANTS ===

  @override
  Stream<List<MerchantModel>> watchAllMerchants() {
    final query = _db.select(_db.merchantsTable).join([
      leftOuterJoin(_db.categoriesTable, _db.categoriesTable.id.equalsExp(_db.merchantsTable.defaultCategoryId)),
    ]);
    query.orderBy([OrderingTerm(expression: _db.merchantsTable.name)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final merchant = row.readTable(_db.merchantsTable);
        final category = row.readTableOrNull(_db.categoriesTable);
        return MerchantModel(
          id: merchant.id,
          name: merchant.name,
          defaultCategoryId: merchant.defaultCategoryId,
          defaultCategoryName: category?.name,
          isAutoLearned: merchant.isAutoLearned,
          usageCount: merchant.usageCount,
          createdAt: merchant.createdAt,
          updatedAt: merchant.updatedAt,
        );
      }).toList();
    });
  }

  @override
  Future<List<MerchantModel>> searchMerchants(String query) async {
    if (query.isEmpty) return [];
    final matches = await (_db.select(_db.merchantsTable)
          ..where((tbl) => tbl.name.like('%$query%'))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.usageCount, mode: OrderingMode.desc)])
          ..limit(10))
        .get();

    return matches
        .map((m) => MerchantModel(
              id: m.id,
              name: m.name,
              defaultCategoryId: m.defaultCategoryId,
              isAutoLearned: m.isAutoLearned,
              usageCount: m.usageCount,
              createdAt: m.createdAt,
              updatedAt: m.updatedAt,
            ))
        .toList();
  }

  @override
  Future<MerchantModel> findOrCreateMerchant(String name, {String? defaultCategoryId}) async {
    final trimmedName = name.trim();
    final existing = await (_db.select(_db.merchantsTable)
          ..where((tbl) => tbl.name.equals(trimmedName)))
        .getSingleOrNull();

    if (existing != null) {
      // Increment usage count
      await (_db.update(_db.merchantsTable)..where((tbl) => tbl.id.equals(existing.id))).write(
        MerchantsTableCompanion(
          usageCount: Value(existing.usageCount + 1),
          defaultCategoryId: defaultCategoryId != null ? Value(defaultCategoryId) : const Value.absent(),
          updatedAt: Value(DateTime.now()),
        ),
      );

      return MerchantModel(
        id: existing.id,
        name: existing.name,
        defaultCategoryId: defaultCategoryId ?? existing.defaultCategoryId,
        isAutoLearned: existing.isAutoLearned,
        usageCount: existing.usageCount + 1,
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
      );
    } else {
      final newId = 'mer_${DateTime.now().millisecondsSinceEpoch}';
      final now = DateTime.now();
      await _db.into(_db.merchantsTable).insert(
            MerchantsTableCompanion.insert(
              id: newId,
              name: trimmedName,
              defaultCategoryId: Value(defaultCategoryId),
              isAutoLearned: const Value(true),
              usageCount: const Value(1),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );

      return MerchantModel(
        id: newId,
        name: trimmedName,
        defaultCategoryId: defaultCategoryId,
        isAutoLearned: true,
        usageCount: 1,
        createdAt: now,
        updatedAt: now,
      );
    }
  }

  @override
  Future<void> updateMerchantDefaultCategory(String merchantId, String? defaultCategoryId) async {
    await (_db.update(_db.merchantsTable)..where((tbl) => tbl.id.equals(merchantId))).write(
      MerchantsTableCompanion(
        defaultCategoryId: Value(defaultCategoryId),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> mergeMerchants({required String sourceMerchantId, required String targetMerchantId}) async {
    await _db.transaction(() async {
      // Transfer all transactions from source to target
      await (_db.update(_db.transactionsTable)..where((tbl) => tbl.merchantId.equals(sourceMerchantId)))
          .write(TransactionsTableCompanion(merchantId: Value(targetMerchantId)));

      // Delete source merchant
      await (_db.delete(_db.merchantsTable)..where((tbl) => tbl.id.equals(sourceMerchantId))).go();
    });
  }

  @override
  Future<void> deleteMerchant(String id) async {
    await (_db.delete(_db.merchantsTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  CategoryModel _entryToModel(CategoryEntry entry, {List<CategoryModel> subcategories = const []}) {
    return CategoryModel(
      id: entry.id,
      parentId: entry.parentId,
      name: entry.name,
      type: entry.type,
      spendingClassification: SpendingClassification.fromString(entry.spendingClassification),
      flexibility: CategoryFlexibility.fromString(entry.flexibility),
      colorValue: entry.colorValue,
      iconName: entry.iconName,
      isDefault: entry.isDefault,
      isArchived: entry.isArchived,
      subcategories: subcategories,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
    );
  }
}

import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/categories_tags/data/repositories/categories_repository_impl.dart';
import 'package:financial_tracking/features/categories_tags/domain/models/category_model.dart';

void main() {
  late AppDatabase db;
  late CategoriesRepositoryImpl repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = CategoriesRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('CategoriesRepository Tests', () {
    test('Can watch and retrieve seeded category tree', () async {
      final tree = await repo.watchCategoryTree(type: 'expense').first;
      expect(tree.isNotEmpty, isTrue);

      final housing = tree.firstWhere((c) => c.name == 'דיור ומגורים');
      expect(housing.subcategories.isNotEmpty, isTrue);
      expect(housing.subcategories.any((sub) => sub.name == 'שכר דירה / משכנתא'), isTrue);
    });

    test('Can create a new parent category and child subcategory', () async {
      final parentId = await repo.createCategory(
        CategoryModel(
          id: 'test_parent',
          name: 'קטגוריה ראשית בדיקה',
          type: 'expense',
          spendingClassification: SpendingClassification.wants,
          flexibility: CategoryFlexibility.variable,
          colorValue: 0xFFF59E0B,
          iconName: 'gift',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final childId = await repo.createCategory(
        CategoryModel(
          id: 'test_child',
          parentId: parentId,
          name: 'תת קטגוריה בדיקה',
          type: 'expense',
          spendingClassification: SpendingClassification.wants,
          flexibility: CategoryFlexibility.variable,
          colorValue: 0xFFF59E0B,
          iconName: 'gift',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final tree = await repo.watchCategoryTree(type: 'expense').first;
      final createdParent = tree.firstWhere((c) => c.id == parentId);
      expect(createdParent.name, equals('קטגוריה ראשית בדיקה'));
      expect(createdParent.subcategories.any((c) => c.id == childId), isTrue);
    });

    test('Deleting category with replacement category migrates transactions', () async {
      // Create source category & replacement category
      final sourceCatId = await repo.createCategory(
        CategoryModel(
          id: 'cat_source',
          name: 'מקור למחיקה',
          type: 'expense',
          colorValue: 0xFFE11D48,
          iconName: 'foodDining',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final targetCatId = await repo.createCategory(
        CategoryModel(
          id: 'cat_target',
          name: 'יעד להעברה',
          type: 'expense',
          colorValue: 0xFF10B981,
          iconName: 'groceries',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Insert transaction pointing to source category
      await db.into(db.transactionsTable).insert(
            TransactionsTableCompanion.insert(
              id: 'tx_mig_1',
              accountId: 'acc_main_checking',
              categoryId: Value(sourceCatId),
              amount: 150.0,
              type: 'expense',
              date: DateTime.now(),
            ),
          );

      // Delete source with replacement target
      await repo.deleteCategory(sourceCatId, replacementCategoryId: targetCatId);

      // Verify source category is deleted
      final sourceDeleted = await repo.getCategoryById(sourceCatId);
      expect(sourceDeleted, isNull);

      // Verify transaction was migrated to target category
      final tx = await (db.select(db.transactionsTable)..where((tbl) => tbl.id.equals('tx_mig_1'))).getSingle();
      expect(tx.categoryId, equals(targetCatId));
    });

    test('Merchant auto-learning and merging duplicate merchants', () async {
      // Find or create merchant
      final m1 = await repo.findOrCreateMerchant('שופרסל שלי', defaultCategoryId: 'cat_food');
      expect(m1.usageCount, equals(1));

      // Call again - usage count increments
      final m1Again = await repo.findOrCreateMerchant('שופרסל שלי');
      expect(m1Again.usageCount, equals(2));

      // Create duplicate merchant
      final m2 = await repo.findOrCreateMerchant('שופרסל אונליין', defaultCategoryId: 'cat_food');

      // Create transaction for m2
      await db.into(db.transactionsTable).insert(
            TransactionsTableCompanion.insert(
              id: 'tx_mer_1',
              accountId: 'acc_main_checking',
              merchantId: Value(m2.id),
              amount: 200.0,
              type: 'expense',
              date: DateTime.now(),
            ),
          );

      // Merge m2 into m1
      await repo.mergeMerchants(sourceMerchantId: m2.id, targetMerchantId: m1.id);

      // Verify transaction now references m1
      final tx = await (db.select(db.transactionsTable)..where((tbl) => tbl.id.equals('tx_mer_1'))).getSingle();
      expect(tx.merchantId, equals(m1.id));
    });

    test('Can create and delete tags', () async {
      final tagId = await repo.createTag('חופשה באילת', 0xFF3B82F6);
      var tags = await repo.watchAllTags().first;
      expect(tags.any((t) => t.id == tagId && t.name == 'חופשה באילת'), isTrue);

      await repo.deleteTag(tagId);
      tags = await repo.watchAllTags().first;
      expect(tags.any((t) => t.id == tagId), isFalse);
    });
  });
}

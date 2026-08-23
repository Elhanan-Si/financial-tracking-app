import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financial_tracking/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    // In-memory Drift database for testing
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('Database & Seed Tests', () {
    test('Database tables are created and seed data is populated', () async {
      // Query categories
      final categories = await db.select(db.categoriesTable).get();
      expect(categories.isNotEmpty, isTrue);

      // Verify Hebrew parent categories exist
      final housingCat = categories.where((c) => c.name == 'דיור ומגורים').toList();
      expect(housingCat.isNotEmpty, isTrue);
      expect(housingCat.first.type, equals('expense'));
      expect(housingCat.first.spendingClassification, equals('needs'));

      final foodCat = categories.where((c) => c.name == 'מזון ומצרכים').toList();
      expect(foodCat.isNotEmpty, isTrue);

      final salaryCat = categories.where((c) => c.name == 'הכנסה מעבודה').toList();
      expect(salaryCat.isNotEmpty, isTrue);
      expect(salaryCat.first.type, equals('income'));

      // Query accounts
      final accounts = await db.select(db.accountsTable).get();
      expect(accounts.length, greaterThanOrEqualTo(3));

      final checking = accounts.where((a) => a.type == 'bank').toList();
      expect(checking.isNotEmpty, isTrue);
      expect(checking.first.name, equals('חשבון עו"ש ראשי'));

      final creditCard = accounts.where((a) => a.type == 'creditCard').toList();
      expect(creditCard.isNotEmpty, isTrue);
      expect(creditCard.first.billingDayOfMonth, equals(10));
    });

    test('Can insert and retrieve transactions with categories', () async {
      final accounts = await db.select(db.accountsTable).get();
      final categories = await db.select(db.categoriesTable).get();

      final accountId = accounts.first.id;
      final categoryId = categories.first.id;

      // Insert transaction
      await db.into(db.transactionsTable).insert(
        TransactionsTableCompanion.insert(
          id: 'tx_test_1',
          accountId: accountId,
          categoryId: Value(categoryId),
          amount: 250.0,
          type: 'expense',
          date: DateTime.now(),
          note: const Value('קנייה בסופר'),
        ),
      );

      final txList = await db.select(db.transactionsTable).get();
      expect(txList.length, equals(1));
      expect(txList.first.amount, equals(250.0));
      expect(txList.first.note, equals('קנייה בסופר'));
    });
  });
}

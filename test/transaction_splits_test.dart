import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/categories_tags/data/repositories/categories_repository_impl.dart';
import 'package:financial_tracking/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:financial_tracking/features/transactions/domain/models/transaction_model.dart';
import 'package:financial_tracking/features/transactions/domain/models/transaction_split_model.dart';
import 'package:financial_tracking/features/transactions/presentation/controllers/transactions_controller.dart';

void main() {
  late AppDatabase db;
  late AccountsRepositoryImpl accountsRepo;
  late CategoriesRepositoryImpl categoriesRepo;
  late TransactionsRepositoryImpl txRepo;
  late TransactionsController controller;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    accountsRepo = AccountsRepositoryImpl(db);
    categoriesRepo = CategoriesRepositoryImpl(db);
    txRepo = TransactionsRepositoryImpl(db, accountsRepo);
    controller = TransactionsController(txRepo, categoriesRepo);
  });

  tearDown(() async {
    await db.close();
  });

  group('TASK-08: Transaction Splits Tests', () {
    test('Can create a transaction with multiple category splits', () async {
      final splits = [
        TransactionSplitModel(
          id: '',
          transactionId: '',
          categoryId: 'cat_food_groceries',
          amount: 250.0,
          note: 'מצרכים לסופ"ש',
          createdAt: DateTime.now(),
        ),
        TransactionSplitModel(
          id: '',
          transactionId: '',
          categoryId: 'cat_shopping_clothes',
          amount: 150.0,
          note: 'חולצה',
          createdAt: DateTime.now(),
        ),
      ];

      final txId = await controller.addTransaction(
        accountId: 'acc_main_checking',
        amount: 400.0,
        type: TransactionType.expense,
        date: DateTime.now(),
        merchantName: 'שופרסל ביג',
        splits: splits,
      );

      expect(txId.isNotEmpty, isTrue);

      final tx = await txRepo.getTransactionById(txId);
      expect(tx, isNotNull);
      expect(tx!.hasSplits, isTrue);
      expect(tx.amount, equals(400.0));

      final retrievedSplits = await txRepo.getSplitsForTransaction(txId);
      expect(retrievedSplits.length, equals(2));
      expect(retrievedSplits.first.categoryId, equals('cat_food_groceries'));
      expect(retrievedSplits.first.amount, equals(250.0));
      expect(retrievedSplits.last.categoryId, equals('cat_shopping_clothes'));
      expect(retrievedSplits.last.amount, equals(150.0));
    });

    test('addTransaction throws when split sum does not equal transaction amount', () async {
      final invalidSplits = [
        TransactionSplitModel(
          id: '',
          transactionId: '',
          categoryId: 'cat_food_groceries',
          amount: 200.0,
          createdAt: DateTime.now(),
        ),
        TransactionSplitModel(
          id: '',
          transactionId: '',
          categoryId: 'cat_shopping_clothes',
          amount: 100.0,
          createdAt: DateTime.now(),
        ),
      ];

      expect(
        () => controller.addTransaction(
          accountId: 'acc_main_checking',
          amount: 500.0, // Mismatch (300 vs 500)
          type: TransactionType.expense,
          date: DateTime.now(),
          splits: invalidSplits,
        ),
        throwsException,
      );
    });

    test('Deleting parent transaction cascades and deletes all splits', () async {
      final splits = [
        TransactionSplitModel(
          id: '',
          transactionId: '',
          categoryId: 'cat_food_groceries',
          amount: 100.0,
          createdAt: DateTime.now(),
        ),
        TransactionSplitModel(
          id: '',
          transactionId: '',
          categoryId: 'cat_shopping_clothes',
          amount: 200.0,
          createdAt: DateTime.now(),
        ),
      ];

      final txId = await controller.addTransaction(
        accountId: 'acc_main_checking',
        amount: 300.0,
        type: TransactionType.expense,
        date: DateTime.now(),
        splits: splits,
      );

      var retrievedSplits = await txRepo.getSplitsForTransaction(txId);
      expect(retrievedSplits.length, equals(2));

      // Delete parent transaction
      await controller.deleteTransaction(txId);

      // Verify transaction deleted
      final deletedTx = await txRepo.getTransactionById(txId);
      expect(deletedTx, isNull);

      // Verify splits deleted
      retrievedSplits = await txRepo.getSplitsForTransaction(txId);
      expect(retrievedSplits.isEmpty, isTrue);
    });
  });
}

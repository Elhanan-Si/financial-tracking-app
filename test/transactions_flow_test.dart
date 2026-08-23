import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/categories_tags/data/repositories/categories_repository_impl.dart';
import 'package:financial_tracking/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:financial_tracking/features/transactions/domain/models/transaction_model.dart';
import 'package:financial_tracking/features/transactions/presentation/controllers/transactions_controller.dart';

void main() {
  late AppDatabase db;
  late AccountsRepositoryImpl accountsRepo;
  late CategoriesRepositoryImpl categoriesRepo;
  late TransactionsRepositoryImpl transactionsRepo;
  late TransactionsController controller;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    accountsRepo = AccountsRepositoryImpl(db);
    categoriesRepo = CategoriesRepositoryImpl(db);
    transactionsRepo = TransactionsRepositoryImpl(db, accountsRepo);
    controller = TransactionsController(transactionsRepo, categoriesRepo);
  });

  tearDown(() async {
    await db.close();
  });

  group('Transactions Flow & Optimistic UI Tests', () {
    test('addTransaction validates positive amount and account presence', () async {
      // Expect throw on 0 amount
      expect(
        () => controller.addTransaction(
          accountId: 'acc_main_checking',
          amount: 0.0,
          type: TransactionType.expense,
          date: DateTime.now(),
        ),
        throwsException,
      );

      // Expect throw on negative amount
      expect(
        () => controller.addTransaction(
          accountId: 'acc_main_checking',
          amount: -50.0,
          type: TransactionType.expense,
          date: DateTime.now(),
        ),
        throwsException,
      );

      // Expect throw on empty accountId
      expect(
        () => controller.addTransaction(
          accountId: '',
          amount: 100.0,
          type: TransactionType.expense,
          date: DateTime.now(),
        ),
        throwsException,
      );
    });

    test('addTransaction creates transaction and updates account balance', () async {
      final txId = await controller.addTransaction(
        accountId: 'acc_main_checking',
        amount: 350.0,
        type: TransactionType.expense,
        date: DateTime.now(),
        merchantName: 'סופר פארם',
        note: 'תרופות ומוצרי היגיינה',
      );

      expect(txId.isNotEmpty, isTrue);

      final tx = await transactionsRepo.getTransactionById(txId);
      expect(tx, isNotNull);
      expect(tx!.amount, equals(350.0));
      expect(tx.merchantName, equals('סופר פארם'));

      // Check account balance updated
      final acc = await accountsRepo.getAccountById('acc_main_checking');
      expect(acc!.currentBalance, equals(-350.0)); // Initial was 0
    });

    test('Merchant auto-learning assigns default category on future entries', () async {
      // First transaction with merchant and explicit category
      await controller.addTransaction(
        accountId: 'acc_main_checking',
        amount: 80.0,
        type: TransactionType.expense,
        date: DateTime.now(),
        merchantName: 'דלק פז',
        categoryId: 'cat_transport_fuel',
      );

      // Second transaction with same merchant name but without category specified
      final tx2Id = await controller.addTransaction(
        accountId: 'acc_main_checking',
        amount: 120.0,
        type: TransactionType.expense,
        date: DateTime.now(),
        merchantName: 'דלק פז',
      );

      final tx2 = await transactionsRepo.getTransactionById(tx2Id);
      expect(tx2!.categoryId, equals('cat_transport_fuel'));
      expect(tx2.isAutoCategorized, isTrue);
    });

    test('watchTransactions filters by type and search query', () async {
      await controller.addTransaction(
        accountId: 'acc_main_checking',
        amount: 50.0,
        type: TransactionType.expense,
        date: DateTime.now(),
        merchantName: 'קפה ארומה',
      );

      await controller.addTransaction(
        accountId: 'acc_main_checking',
        amount: 10000.0,
        type: TransactionType.income,
        date: DateTime.now(),
        note: 'משכורת חודשית',
      );

      // Filter expenses only
      final expenses = await transactionsRepo.watchTransactions(type: 'expense').first;
      expect(expenses.length, equals(1));
      expect(expenses.first.merchantName, equals('קפה ארומה'));

      // Search by keyword
      final searchResult = await transactionsRepo.watchTransactions(searchQuery: 'משכורת').first;
      expect(searchResult.length, equals(1));
      expect(searchResult.first.type, equals(TransactionType.income));
    });
  });
}

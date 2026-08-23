import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracking/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:financial_tracking/features/transactions/domain/models/transaction_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late AccountsRepositoryImpl accountsRepo;
  late TransactionsRepositoryImpl transactionsRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    accountsRepo = AccountsRepositoryImpl(db);
    transactionsRepo = TransactionsRepositoryImpl(db, accountsRepo);

    // Seed Custom Bank Account with 10,000 ILS
    await accountsRepo.createAccount(
      AccountModel(
        id: 'acc_test_bank_1',
        name: 'עו"ש בדיקה',
        type: AccountType.bank,
        initialBalance: 10000.0,
        currentBalance: 10000.0,
        currency: 'ILS',
        colorValue: 0xFF2563EB,
        iconName: 'account_balance',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    // Seed Categories
    await db.into(db.categoriesTable).insert(
          CategoriesTableCompanion.insert(
            id: 'cat_groceries_test',
            name: 'סופרמרקט בדיקה',
            type: 'expense',
            colorValue: const Value(0xFF10B981),
            iconName: const Value('shopping_cart'),
          ),
        );
    await db.into(db.categoriesTable).insert(
          CategoriesTableCompanion.insert(
            id: 'cat_restaurants_test',
            name: 'מסעדות בדיקה',
            type: 'expense',
            colorValue: const Value(0xFFF59E0B),
            iconName: const Value('restaurant'),
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  test('TASK-12: Advanced multi-filter and batch operations', () async {
    const bankAccId = 'acc_test_bank_1';

    // Create 3 transactions
    final tx1 = await transactionsRepo.createTransaction(
      TransactionModel(
        id: '',
        accountId: bankAccId,
        categoryId: 'cat_groceries_test',
        amount: 250.0,
        type: TransactionType.expense,
        date: DateTime(2026, 8, 5),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    final tx2 = await transactionsRepo.createTransaction(
      TransactionModel(
        id: '',
        accountId: bankAccId,
        categoryId: 'cat_groceries_test',
        amount: 500.0,
        type: TransactionType.expense,
        date: DateTime(2026, 8, 10),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    final tx3 = await transactionsRepo.createTransaction(
      TransactionModel(
        id: '',
        accountId: bankAccId,
        categoryId: 'cat_restaurants_test',
        amount: 150.0,
        type: TransactionType.expense,
        date: DateTime(2026, 8, 15),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    // 1. Multi-filter by amount range (200 to 600)
    final filteredByAmount = await transactionsRepo
        .watchTransactions(
          accountId: bankAccId,
          minAmount: 200,
          maxAmount: 600,
        )
        .first;
    expect(filteredByAmount.length, 2);

    // 2. Batch Update Category (change tx1 and tx2 from groceries to restaurants)
    await transactionsRepo.batchUpdateCategory([tx1, tx2], 'cat_restaurants_test');
    final updatedTx1 = await transactionsRepo.getTransactionById(tx1);
    final updatedTx2 = await transactionsRepo.getTransactionById(tx2);
    expect(updatedTx1?.categoryId, 'cat_restaurants_test');
    expect(updatedTx2?.categoryId, 'cat_restaurants_test');

    // 3. Batch Delete Transactions
    await transactionsRepo.batchDeleteTransactions([tx1, tx2, tx3]);
    final remaining = await transactionsRepo.watchTransactions(accountId: bankAccId).first;
    expect(remaining.isEmpty, true);

    // Verify balance rolled back properly to initial 10000.0
    final reloadedAcc = await accountsRepo.getAccountById(bankAccId);
    expect(reloadedAcc?.currentBalance, 10000.0);
  });
}

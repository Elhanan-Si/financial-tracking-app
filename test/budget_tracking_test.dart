import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracking/features/budgets/data/repositories/budgets_repository_impl.dart';
import 'package:financial_tracking/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:financial_tracking/features/transactions/domain/models/transaction_model.dart';
import 'package:financial_tracking/features/transactions/domain/models/transaction_split_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late AccountsRepositoryImpl accountsRepo;
  late TransactionsRepositoryImpl transactionsRepo;
  late BudgetsRepositoryImpl budgetsRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    accountsRepo = AccountsRepositoryImpl(db);
    transactionsRepo = TransactionsRepositoryImpl(db, accountsRepo);
    budgetsRepo = BudgetsRepositoryImpl(db);

    await accountsRepo.createAccount(
      AccountModel(
        id: '',
        name: 'עו"ש',
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

    await db.into(db.categoriesTable).insert(
          CategoriesTableCompanion.insert(
            id: 'cat_groceries',
            name: 'סופרמרקט',
            type: 'expense',
            colorValue: const Value(0xFF10B981),
            iconName: const Value('shopping_cart'),
          ),
        );
    await db.into(db.categoriesTable).insert(
          CategoriesTableCompanion.insert(
            id: 'cat_pharmacy',
            name: 'פארם',
            type: 'expense',
            colorValue: const Value(0xFFEC4899),
            iconName: const Value('local_pharmacy'),
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  test('TASK-18: Real-time Budget Tracking with Splits and Burn Rate Status', () async {
    final acc = (await accountsRepo.getAccounts()).first;

    // Set Budget for Groceries = 1000 ILS in August 2026
    await budgetsRepo.setCategoryBudget(
      categoryId: 'cat_groceries',
      yearMonth: '2026-08',
      baseAmount: 1000.0,
    );

    // 1. Direct Expense: 400 ILS
    await transactionsRepo.createTransaction(
      TransactionModel(
        id: '',
        accountId: acc.id,
        categoryId: 'cat_groceries',
        amount: 400.0,
        type: TransactionType.expense,
        date: DateTime(2026, 8, 5),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    // 2. Split Transaction (Total 300 ILS: 200 Groceries, 100 Pharmacy)
    await transactionsRepo.createTransactionWithSplits(
      TransactionModel(
        id: '',
        accountId: acc.id,
        amount: 300.0,
        type: TransactionType.expense,
        date: DateTime(2026, 8, 12),
        hasSplits: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      [
        TransactionSplitModel(
          id: 'sp_1',
          transactionId: '',
          categoryId: 'cat_groceries',
          amount: 200.0,
          createdAt: DateTime.now(),
        ),
        TransactionSplitModel(
          id: 'sp_2',
          transactionId: '',
          categoryId: 'cat_pharmacy',
          amount: 100.0,
          createdAt: DateTime.now(),
        ),
      ],
    );

    // Total actual spent on Groceries should be 400 + 200 = 600 ILS
    final spent = await budgetsRepo.calculateActualSpentForCategory(
      categoryId: 'cat_groceries',
      yearMonth: '2026-08',
    );
    expect(spent, 600.0);

    // Overall Monthly Summary
    final summary = await budgetsRepo.getMonthlyBudgetSummary('2026-08');
    expect(summary.totalPlannedBudget, 1000.0);
    expect(summary.totalActualSpent, 600.0);
    expect(summary.totalRemaining, 400.0);
    expect(summary.totalPercentageUtilized, 0.6);

    final progress = summary.items.first;
    expect(progress.isOverBudget, false);
    expect(progress.remainingBudget, 400.0);
  });
}

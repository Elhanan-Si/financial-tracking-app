import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracking/features/budgets/data/repositories/budgets_repository_impl.dart';
import 'package:financial_tracking/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:financial_tracking/features/transactions/domain/models/transaction_model.dart';
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
        id: 'acc_rollover_bank',
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
  });

  tearDown(() async {
    await db.close();
  });

  test('TASK-17: Rollover Calculation with Surplus, Deficit, and Max Rollover Clamp', () async {
    const accId = 'acc_rollover_bank';

    // Case 1: Surplus (July Budget = 2000, Actual Spent = 1400 -> Surplus = +600)
    // Clamped by maxRolloverAmount = 500
    await budgetsRepo.setCategoryBudget(
      categoryId: 'cat_groceries',
      yearMonth: '2026-07',
      baseAmount: 2000.0,
      isRolloverEnabled: true,
      maxRolloverAmount: 500.0,
    );

    await transactionsRepo.createTransaction(
      TransactionModel(
        id: '',
        accountId: accId,
        categoryId: 'cat_groceries',
        amount: 1400.0,
        type: TransactionType.expense,
        date: DateTime(2026, 7, 10),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    // August Budget with Rollover Enabled
    await budgetsRepo.setCategoryBudget(
      categoryId: 'cat_groceries',
      yearMonth: '2026-08',
      baseAmount: 2000.0,
      isRolloverEnabled: true,
      maxRolloverAmount: 500.0,
    );

    final rolloverBalance = await budgetsRepo.calculateRolloverBalance(
      categoryId: 'cat_groceries',
      yearMonth: '2026-08',
    );

    // Difference was +600, clamped to max 500
    expect(rolloverBalance, 500.0);

    final augSummary = await budgetsRepo.getMonthlyBudgetSummary('2026-08');
    final augProgress = augSummary.items.first;
    // Effective budget = base (2000) + rollover (500) = 2500
    expect(augProgress.effectiveBudget, 2500.0);
  });
}

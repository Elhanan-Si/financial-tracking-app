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
        id: '',
        name: 'עו"ש',
        type: AccountType.bank,
        initialBalance: 5000.0,
        currentBalance: 5000.0,
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

  test('TASK-16: Budget Planning CRUD and Smart 3-Month Suggestion', () async {
    final acc = (await accountsRepo.getAccounts()).first;

    // 1. Create historical transactions for 3 previous months (May, June, July 2026)
    // May: 1200, June: 1400, July: 1600 -> Avg: 1400
    await transactionsRepo.createTransaction(
      TransactionModel(
        id: '',
        accountId: acc.id,
        categoryId: 'cat_groceries',
        amount: 1200.0,
        type: TransactionType.expense,
        date: DateTime(2026, 5, 15),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    await transactionsRepo.createTransaction(
      TransactionModel(
        id: '',
        accountId: acc.id,
        categoryId: 'cat_groceries',
        amount: 1400.0,
        type: TransactionType.expense,
        date: DateTime(2026, 6, 15),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    await transactionsRepo.createTransaction(
      TransactionModel(
        id: '',
        accountId: acc.id,
        categoryId: 'cat_groceries',
        amount: 1600.0,
        type: TransactionType.expense,
        date: DateTime(2026, 7, 15),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    // Calculate smart suggestion for August 2026
    final suggested = await budgetsRepo.calculateSuggestedBudget(
      categoryId: 'cat_groceries',
      currentYearMonth: '2026-08',
    );
    expect(suggested, 1400.0);

    // 2. Set Category Budget for August 2026
    final budgetId = await budgetsRepo.setCategoryBudget(
      categoryId: 'cat_groceries',
      yearMonth: '2026-08',
      baseAmount: 1500.0,
      isRolloverEnabled: true,
      maxRolloverAmount: 500.0,
    );
    expect(budgetId.isNotEmpty, true);

    final fetched = await budgetsRepo.getBudgetByCategoryAndMonth('cat_groceries', '2026-08');
    expect(fetched?.baseAmount, 1500.0);
    expect(fetched?.isRolloverEnabled, true);

    // 3. Copy Budgets from August to September 2026
    final copied = await budgetsRepo.copyBudgetsFromMonth(
      sourceYearMonth: '2026-08',
      targetYearMonth: '2026-09',
    );
    expect(copied, 1);

    final septBudget = await budgetsRepo.getBudgetByCategoryAndMonth('cat_groceries', '2026-09');
    expect(septBudget?.baseAmount, 1500.0);
  });
}

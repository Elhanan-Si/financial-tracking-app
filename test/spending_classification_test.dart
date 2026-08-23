import 'package:drift/native.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracking/features/budgets/data/repositories/budgets_repository_impl.dart';
import 'package:financial_tracking/features/categories_tags/data/repositories/categories_repository_impl.dart';
import 'package:financial_tracking/features/categories_tags/domain/models/category_model.dart';
import 'package:financial_tracking/features/insights_analytics/data/repositories/insights_repository_impl.dart';
import 'package:financial_tracking/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:financial_tracking/features/transactions/domain/models/transaction_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TASK-27: Spending Classification (50/30/20 & Fixed/Variable) Tests', () {
    late AppDatabase db;
    late AccountsRepositoryImpl accountsRepo;
    late CategoriesRepositoryImpl categoriesRepo;
    late TransactionsRepositoryImpl transactionsRepo;
    late BudgetsRepositoryImpl budgetsRepo;
    late InsightsRepositoryImpl insightsRepo;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      accountsRepo = AccountsRepositoryImpl(db);
      transactionsRepo = TransactionsRepositoryImpl(db, accountsRepo);
      categoriesRepo = CategoriesRepositoryImpl(db);
      budgetsRepo = BudgetsRepositoryImpl(db);
      insightsRepo = InsightsRepositoryImpl(db, budgetsRepo);
    });

    tearDown(() async {
      await db.close();
    });

    test('50/30/20 and Fixed/Variable expenses are classified accurately', () async {
      final accId = await accountsRepo.createAccount(
        AccountModel(
          id: 'acc_1',
          name: 'עו"ש',
          type: AccountType.bank,
          currency: 'ILS',
          initialBalance: 50000.0,
          colorValue: 0xFF3B82F6,
          iconName: 'bank',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Create Category 1: Housing / Rent (Needs, Fixed)
      final rentCatId = await categoriesRepo.createCategory(
        CategoryModel(
          id: 'custom_cat_rent',
          name: 'שכר דירה',
          type: 'expense',
          spendingClassification: SpendingClassification.needs,
          flexibility: CategoryFlexibility.fixed,
          colorValue: 0xFF3B82F6,
          iconName: 'housing',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Create Category 2: Restaurants / Dining (Wants, Variable)
      final diningCatId = await categoriesRepo.createCategory(
        CategoryModel(
          id: 'custom_cat_dining',
          name: 'מסעדות ובילויים',
          type: 'expense',
          spendingClassification: SpendingClassification.wants,
          flexibility: CategoryFlexibility.variable,
          colorValue: 0xFFF59E0B,
          iconName: 'foodDining',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final now = DateTime(2026, 8, 15);

      // Income: 20,000 ILS
      await transactionsRepo.createTransaction(
        TransactionModel(
          id: 'tx_inc',
          accountId: accId,
          amount: 20000.0,
          type: TransactionType.income,
          date: now,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Rent (Needs, Fixed): 5,000 ILS
      await transactionsRepo.createTransaction(
        TransactionModel(
          id: 'tx_rent',
          accountId: accId,
          categoryId: rentCatId,
          amount: 5000.0,
          type: TransactionType.expense,
          date: now,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Dining (Wants, Variable): 3,000 ILS
      await transactionsRepo.createTransaction(
        TransactionModel(
          id: 'tx_dining',
          accountId: accId,
          categoryId: diningCatId,
          amount: 3000.0,
          type: TransactionType.expense,
          date: now,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final model = await insightsRepo.getSpendingClassification(month: now);

      expect(model.totalIncome, 20000.0);
      expect(model.totalExpenses, 8000.0);
      expect(model.needsAmount, 5000.0);
      expect(model.wantsAmount, 3000.0);
      // Savings = 20,000 - 8,000 = 12,000
      expect(model.savingsAmount, 12000.0);

      // Needs % = 5,000 / 20,000 = 25%
      expect(model.needsPercent, 25.0);
      // Wants % = 3,000 / 20,000 = 15% (Within 30% limit)
      expect(model.wantsPercent, 15.0);
      expect(model.isWantsExceeded, false);

      // Fixed expenses = 5,000 (62.5% of total expenses)
      expect(model.fixedAmount, 5000.0);
      expect(model.variableAmount, 3000.0);
    });

    test('Wants threshold trigger flags warning when exceeding 30% of income', () async {
      final accId = await accountsRepo.createAccount(
        AccountModel(
          id: 'acc_2',
          name: 'עו"ש',
          type: AccountType.bank,
          currency: 'ILS',
          initialBalance: 50000.0,
          colorValue: 0xFF3B82F6,
          iconName: 'bank',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final luxuryCatId = await categoriesRepo.createCategory(
        CategoryModel(
          id: 'custom_cat_lux',
          name: 'מותרות',
          type: 'expense',
          spendingClassification: SpendingClassification.wants,
          flexibility: CategoryFlexibility.variable,
          colorValue: 0xFFEF4444,
          iconName: 'shopping',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final now = DateTime(2026, 8, 15);

      // Income = 10,000 ILS
      await transactionsRepo.createTransaction(
        TransactionModel(
          id: 'tx_inc_2',
          accountId: accId,
          amount: 10000.0,
          type: TransactionType.income,
          date: now,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Luxury = 4,000 ILS (40% of income > 30%)
      await transactionsRepo.createTransaction(
        TransactionModel(
          id: 'tx_lux',
          accountId: accId,
          categoryId: luxuryCatId,
          amount: 4000.0,
          type: TransactionType.expense,
          date: now,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final model = await insightsRepo.getSpendingClassification(month: now);
      expect(model.wantsPercent, 40.0);
      expect(model.isWantsExceeded, true);
    });
  });
}

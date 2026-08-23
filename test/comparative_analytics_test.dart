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
  group('TASK-28: Comparative Period Analytics & Top Movers Tests', () {
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

    test('Month-over-month comparison identifies Top Increasing and Decreasing categories', () async {
      final accId = await accountsRepo.createAccount(
        AccountModel(
          id: 'acc_comp',
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

      final foodCatId = await categoriesRepo.createCategory(
        CategoryModel(
          id: 'custom_cat_food',
          name: 'סופרמרקט ומזון',
          type: 'expense',
          spendingClassification: SpendingClassification.needs,
          flexibility: CategoryFlexibility.variable,
          colorValue: 0xFF3B82F6,
          iconName: 'groceries',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final travelCatId = await categoriesRepo.createCategory(
        CategoryModel(
          id: 'custom_cat_travel',
          name: 'טיסות וחופשות',
          type: 'expense',
          spendingClassification: SpendingClassification.wants,
          flexibility: CategoryFlexibility.variable,
          colorValue: 0xFFF59E0B,
          iconName: 'travel',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final prevMonth = DateTime(2026, 7, 15);
      final curMonth = DateTime(2026, 8, 15);

      // Previous Month: Food = 2000, Travel = 5000
      await transactionsRepo.createTransaction(
        TransactionModel(
          id: 'tx_food_prev',
          accountId: accId,
          categoryId: foodCatId,
          amount: 2000.0,
          type: TransactionType.expense,
          date: prevMonth,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
      await transactionsRepo.createTransaction(
        TransactionModel(
          id: 'tx_travel_prev',
          accountId: accId,
          categoryId: travelCatId,
          amount: 5000.0,
          type: TransactionType.expense,
          date: prevMonth,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Current Month: Food = 3500 (+1500 increase), Travel = 1000 (-4000 reduction)
      await transactionsRepo.createTransaction(
        TransactionModel(
          id: 'tx_food_cur',
          accountId: accId,
          categoryId: foodCatId,
          amount: 3500.0,
          type: TransactionType.expense,
          date: curMonth,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
      await transactionsRepo.createTransaction(
        TransactionModel(
          id: 'tx_travel_cur',
          accountId: accId,
          categoryId: travelCatId,
          amount: 1000.0,
          type: TransactionType.expense,
          date: curMonth,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final comp = await insightsRepo.getComparativeAnalytics(
        currentMonth: curMonth,
        previousMonth: prevMonth,
      );

      expect(comp.currentTotalExpenses, 4500.0);
      expect(comp.previousTotalExpenses, 7000.0);
      // Total expenses decreased by 2500 (-35.71%)
      expect(comp.expensesDeltaAmount, -2500.0);

      // Top Increasing: Food (+1500 ILS, +75%)
      expect(comp.topIncreasingCategories.length, 1);
      expect(comp.topIncreasingCategories.first.categoryName, 'סופרמרקט ומזון');
      expect(comp.topIncreasingCategories.first.deltaAmount, 1500.0);
      expect(comp.topIncreasingCategories.first.deltaPercent, 75.0);

      // Top Decreasing: Travel (-4000 ILS, -80%)
      expect(comp.topDecreasingCategories.length, 1);
      expect(comp.topDecreasingCategories.first.categoryName, 'טיסות וחופשות');
      expect(comp.topDecreasingCategories.first.deltaAmount, -4000.0);
      expect(comp.topDecreasingCategories.first.deltaPercent, -80.0);
    });
  });
}

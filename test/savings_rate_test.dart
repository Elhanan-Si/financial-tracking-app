import 'package:drift/native.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracking/features/budgets/data/repositories/budgets_repository_impl.dart';
import 'package:financial_tracking/features/insights_analytics/data/repositories/insights_repository_impl.dart';
import 'package:financial_tracking/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:financial_tracking/features/transactions/domain/models/transaction_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TASK-29: Savings Rate & Burn Rate Metrics Tests', () {
    late AppDatabase db;
    late AccountsRepositoryImpl accountsRepo;
    late TransactionsRepositoryImpl transactionsRepo;
    late BudgetsRepositoryImpl budgetsRepo;
    late InsightsRepositoryImpl insightsRepo;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      accountsRepo = AccountsRepositoryImpl(db);
      transactionsRepo = TransactionsRepositoryImpl(db, accountsRepo);
      budgetsRepo = BudgetsRepositoryImpl(db);
      insightsRepo = InsightsRepositoryImpl(db, budgetsRepo);
    });

    tearDown(() async {
      await db.close();
    });

    test('Savings Rate and Moving Averages calculate correctly across multi-month history', () async {
      final accId = await accountsRepo.createAccount(
        AccountModel(
          id: 'acc_sav',
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

      // Month 1 (June 2026): Income 20,000, Expense 10,000 -> 50% savings rate
      await transactionsRepo.createTransaction(
        TransactionModel(
          id: 'tx_m1_inc',
          accountId: accId,
          amount: 20000.0,
          type: TransactionType.income,
          date: DateTime(2026, 6, 10),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
      await transactionsRepo.createTransaction(
        TransactionModel(
          id: 'tx_m1_exp',
          accountId: accId,
          amount: 10000.0,
          type: TransactionType.expense,
          date: DateTime(2026, 6, 15),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Month 2 (July 2026): Income 20,000, Expense 14,000 -> 30% savings rate
      await transactionsRepo.createTransaction(
        TransactionModel(
          id: 'tx_m2_inc',
          accountId: accId,
          amount: 20000.0,
          type: TransactionType.income,
          date: DateTime(2026, 7, 10),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
      await transactionsRepo.createTransaction(
        TransactionModel(
          id: 'tx_m2_exp',
          accountId: accId,
          amount: 14000.0,
          type: TransactionType.expense,
          date: DateTime(2026, 7, 15),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Month 3 (August 2026): Income 20,000, Expense 12,000 -> 40% savings rate
      await transactionsRepo.createTransaction(
        TransactionModel(
          id: 'tx_m3_inc',
          accountId: accId,
          amount: 20000.0,
          type: TransactionType.income,
          date: DateTime(2026, 8, 10),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
      await transactionsRepo.createTransaction(
        TransactionModel(
          id: 'tx_m3_exp',
          accountId: accId,
          amount: 12000.0,
          type: TransactionType.expense,
          date: DateTime(2026, 8, 15),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final metrics = await insightsRepo.getSavingsRateMetrics(month: DateTime(2026, 8, 15));

      // Current Month (August): 40%
      expect(metrics.currentMonthSavingsRate, 40.0);
      expect(metrics.currentMonthNetSavings, 8000.0);

      // 3-Month Moving Average: (40 + 30 + 50) / 3 = 40%
      expect((metrics.threeMonthMovingAverage - 40.0).abs() < 0.1, true);

      // Monthly Burn Rate (Average of 12000, 14000, 10000) = 12000 ILS
      expect((metrics.monthlyBurnRate - 12000.0).abs() < 0.1, true);
    });
  });
}

import 'package:drift/native.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracking/features/cash_flow/data/repositories/cash_flow_repository_impl.dart';
import 'package:financial_tracking/features/cash_flow/domain/models/cash_flow_model.dart';
import 'package:financial_tracking/features/categories_tags/data/repositories/categories_repository_impl.dart';
import 'package:financial_tracking/features/recurring/data/repositories/recurring_repository_impl.dart';
import 'package:financial_tracking/features/recurring/domain/models/recurring_rule_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late AccountsRepositoryImpl accountsRepo;
  late CategoriesRepositoryImpl categoriesRepo;
  late RecurringRepositoryImpl recurringRepo;
  late CashFlowRepositoryImpl cashFlowRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    accountsRepo = AccountsRepositoryImpl(db);
    categoriesRepo = CategoriesRepositoryImpl(db);
    recurringRepo = RecurringRepositoryImpl(db, accountsRepo, categoriesRepo);
    cashFlowRepo = CashFlowRepositoryImpl(db);

    // Initial Bank Account with 2000 ILS
    await accountsRepo.createAccount(
      AccountModel(
        id: 'acc_test_cf_bank',
        name: 'עו"ש ראשי בדיקה',
        type: AccountType.bank,
        initialBalance: 2000.0,
        currentBalance: 2000.0,
        currency: 'ILS',
        colorValue: 0xFF2563EB,
        iconName: 'account_balance',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('TASK-20: 30-Day Cash Flow Forecast with Deficit Risk and What-If Simulation', () async {
    const bankAccId = 'acc_test_cf_bank';

    // 1. Recurring Salary (+10,000 ILS on the 10th of the month)
    await recurringRepo.createRecurringRule(
      RecurringRuleModel(
        id: '',
        accountId: bankAccId,
        name: 'משכורת',
        amount: 10000.0,
        frequency: RecurringFrequency.monthly,
        startDate: DateTime.now(),
        dayOfMonth: 10,
        nextExecutionDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    // 2. Base 30-day forecast without simulation
    final baseForecast = await cashFlowRepo.calculateCashFlowForecast(days: 30);
    expect(baseForecast.points.length, 31); // day 0 to 30

    // 3. What-If Scenario: Large expense of 50000 ILS in 5 days
    final scenarioDate = DateTime.now().add(const Duration(days: 5));
    final whatIfScenarios = [
      WhatIfScenarioModel(
        id: 'whatif_car_repair',
        name: 'תיקון רכב לא צפוי',
        amount: 50000.0,
        date: scenarioDate,
        isIncome: false,
        isEnabled: true,
      ),
    ];

    final simulatedForecast = await cashFlowRepo.calculateCashFlowForecast(
      days: 30,
      whatIfScenarios: whatIfScenarios,
    );

    // If starting was liquid accounts and 50,000 expense hit before day 10 salary, lowest balance will dip into deficit (< 0)
    expect(simulatedForecast.hasDeficitRisk, true);
    expect(simulatedForecast.deficitDaysCount > 0, true);
    expect(simulatedForecast.lowestBalance < 0, true);
  });

  test('Cash Flow Forecast separates recurring income (Salary) and recurring expenses (Standing Order)', () async {
    const bankAccId = 'acc_test_cf_bank';

    // 1. Recurring Salary (+8,000 ILS)
    await recurringRepo.createRecurringRule(
      RecurringRuleModel(
        id: 'rec_salary_test',
        accountId: bankAccId,
        name: 'משכורת חודשית',
        amount: 8000.0,
        frequency: RecurringFrequency.monthly,
        startDate: DateTime.now(),
        dayOfMonth: 10,
        nextExecutionDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    // 2. Recurring Standing Order Expense (-2,500 ILS)
    await recurringRepo.createRecurringRule(
      RecurringRuleModel(
        id: 'rec_rent_test',
        accountId: bankAccId,
        name: 'הוראת קבע שכירות',
        amount: 2500.0,
        frequency: RecurringFrequency.monthly,
        startDate: DateTime.now(),
        dayOfMonth: 15,
        nextExecutionDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    final forecast = await cashFlowRepo.calculateCashFlowForecast(days: 30);

    // Verify point with day 10 has inflow 8000 and point with day 15 has outflow 2500
    final day10Point = forecast.points.firstWhere((p) => p.date.day == 10);
    final day15Point = forecast.points.firstWhere((p) => p.date.day == 15);

    expect(day10Point.totalInflow, 8000.0);
    expect(day15Point.totalOutflow, 2500.0);
  });
}

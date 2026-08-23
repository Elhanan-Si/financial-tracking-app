import 'package:drift/native.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracking/features/cash_flow/data/repositories/cash_flow_repository_impl.dart';
import 'package:financial_tracking/features/categories_tags/data/repositories/categories_repository_impl.dart';
import 'package:financial_tracking/features/installments/data/repositories/installments_repository_impl.dart';
import 'package:financial_tracking/features/recurring/data/repositories/recurring_repository_impl.dart';
import 'package:financial_tracking/features/recurring/domain/models/recurring_rule_model.dart';
import 'package:financial_tracking/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:financial_tracking/features/transactions/domain/models/transaction_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late AccountsRepositoryImpl accountsRepo;
  late CategoriesRepositoryImpl categoriesRepo;
  late TransactionsRepositoryImpl transactionsRepo;
  late InstallmentsRepositoryImpl installmentsRepo;
  late RecurringRepositoryImpl recurringRepo;
  late CashFlowRepositoryImpl cashFlowRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    accountsRepo = AccountsRepositoryImpl(db);
    categoriesRepo = CategoriesRepositoryImpl(db);
    transactionsRepo = TransactionsRepositoryImpl(db, accountsRepo);
    installmentsRepo = InstallmentsRepositoryImpl(db, accountsRepo, categoriesRepo);
    recurringRepo = RecurringRepositoryImpl(db, accountsRepo, categoriesRepo);
    cashFlowRepo = CashFlowRepositoryImpl(db);

    // Create Credit Card Account with billing day 10
    await accountsRepo.createAccount(
      AccountModel(
        id: 'acc_test_cc_max',
        name: 'כרטיס מקס',
        type: AccountType.creditCard,
        initialBalance: 0.0,
        currentBalance: 0.0,
        currency: 'ILS',
        colorValue: 0xFF2563EB,
        iconName: 'credit_card',
        billingDayOfMonth: 10,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('TASK-19: Credit Card Billing Forecast combining transactions, installments and recurring', () async {
    const cardId = 'acc_test_cc_max';

    // 1. Regular Expense in current cycle: 500 ILS
    await transactionsRepo.createTransaction(
      TransactionModel(
        id: '',
        accountId: cardId,
        amount: 500.0,
        type: TransactionType.expense,
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    // 2. Installment Plan: 1200 ILS over 4 payments (300/mo)
    await installmentsRepo.createInstallmentPlan(
      accountId: cardId,
      merchantName: 'קניית מחשב',
      totalAmount: 1200.0,
      numberOfInstallments: 4,
      firstDueDate: DateTime.now(),
    );

    // 3. Recurring charge on card (e.g. Netflix 50 ILS)
    await recurringRepo.createRecurringRule(
      RecurringRuleModel(
        id: '',
        accountId: cardId,
        name: 'נטפליקס',
        amount: 50.0,
        frequency: RecurringFrequency.monthly,
        startDate: DateTime.now(),
        dayOfMonth: 1,
        nextExecutionDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    final forecasts = await cashFlowRepo.getCreditCardForecasts();
    final cardForecast = forecasts.firstWhere((f) => f.accountId == cardId);

    expect(cardForecast.cardName, 'כרטיס מקס');
    expect(cardForecast.billingDayOfMonth, 10);
    expect(cardForecast.currentCycleSpending >= 500.0, true);
    expect(cardForecast.installmentsDueAmount >= 300.0, true);
    expect(cardForecast.recurringChargesAmount, 50.0);
    expect(cardForecast.totalProjectedCharge >= 850.0, true);
  });
}

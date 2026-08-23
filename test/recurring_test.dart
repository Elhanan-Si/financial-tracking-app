import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/categories_tags/data/repositories/categories_repository_impl.dart';
import 'package:financial_tracking/features/recurring/data/repositories/recurring_repository_impl.dart';
import 'package:financial_tracking/features/recurring/domain/models/recurring_rule_model.dart';

void main() {
  late AppDatabase db;
  late AccountsRepositoryImpl accountsRepo;
  late CategoriesRepositoryImpl categoriesRepo;
  late RecurringRepositoryImpl recurringRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    accountsRepo = AccountsRepositoryImpl(db);
    categoriesRepo = CategoriesRepositoryImpl(db);
    recurringRepo = RecurringRepositoryImpl(db, accountsRepo, categoriesRepo);
  });

  tearDown(() async {
    await db.close();
  });

  group('TASK-11: Recurring Engine Tests', () {
    test('Can create, pause, resume, and calculate normalized monthly commitments', () async {
      final now = DateTime.now();

      // Monthly Netflix subscription 50 ILS
      await recurringRepo.createRecurringRule(
        RecurringRuleModel(
          id: 'rec_netflix',
          accountId: 'acc_main_credit',
          categoryId: 'cat_leisure_subs',
          name: 'נטפליקס',
          amount: 50.0,
          frequency: RecurringFrequency.monthly,
          dayOfMonth: 10,
          startDate: now,
          nextExecutionDate: DateTime(now.year, now.month + 1, 10),
          createdAt: now,
          updatedAt: now,
        ),
      );

      // Yearly Amazon Prime subscription 240 ILS (= 20 ILS/month)
      await recurringRepo.createRecurringRule(
        RecurringRuleModel(
          id: 'rec_amazon',
          accountId: 'acc_main_credit',
          categoryId: 'cat_leisure_subs',
          name: 'אמזון פריים',
          amount: 240.0,
          frequency: RecurringFrequency.yearly,
          dayOfMonth: 1,
          startDate: now,
          nextExecutionDate: DateTime(now.year + 1, 1, 1),
          createdAt: now,
          updatedAt: now,
        ),
      );

      // Total monthly commitments = 50 + (240 / 12) = 70 ILS
      var total = await recurringRepo.calculateTotalMonthlyCommitments();
      expect(total, equals(70.0));

      // Pause Netflix
      await recurringRepo.setPaused('rec_netflix', true);

      // Active rules should now only count Amazon (20 ILS)
      total = await recurringRepo.calculateTotalMonthlyCommitments();
      expect(total, equals(20.0));

      // Resume Netflix
      await recurringRepo.setPaused('rec_netflix', false);
      total = await recurringRepo.calculateTotalMonthlyCommitments();
      expect(total, equals(70.0));
    });

    test('executeDueRules creates transaction and updates nextExecutionDate', () async {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));

      // Rule due yesterday
      await recurringRepo.createRecurringRule(
        RecurringRuleModel(
          id: 'rec_due_gym',
          accountId: 'acc_main_checking',
          categoryId: 'cat_leisure_fitness',
          name: 'מנוי חדר כושר',
          amount: 200.0,
          frequency: RecurringFrequency.monthly,
          dayOfMonth: yesterday.day,
          startDate: yesterday,
          nextExecutionDate: yesterday,
          isAutoExecute: true,
          createdAt: now,
          updatedAt: now,
        ),
      );

      // Execute due rules
      final executedCount = await recurringRepo.executeDueRules();
      expect(executedCount, equals(1));

      // Checking account balance should now have a 200 ILS expense
      final bal = await accountsRepo.calculateAccountBalance('acc_main_checking');
      expect(bal, equals(-200.0));

      // Rule nextExecutionDate should be advanced to next month
      final rule = await recurringRepo.getRecurringRuleById('rec_due_gym');
      expect(rule, isNotNull);
      expect(rule!.lastExecutedDate, isNotNull);
      expect(rule.nextExecutionDate.isAfter(now), isTrue);
    });

    test('Recurring income (Salary) is flagged as isIncome and executes as income transaction', () async {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));

      final salaryRule = RecurringRuleModel(
        id: 'rec_salary',
        accountId: 'acc_main_checking',
        categoryId: 'cat_income_salary',
        name: 'משכורת חודשית',
        amount: 15000.0,
        frequency: RecurringFrequency.monthly,
        dayOfMonth: yesterday.day,
        startDate: yesterday,
        nextExecutionDate: yesterday,
        isAutoExecute: true,
        createdAt: now,
        updatedAt: now,
      );

      expect(salaryRule.isIncome, isTrue);

      await recurringRepo.createRecurringRule(salaryRule);

      final executed = await recurringRepo.executeDueRules();
      expect(executed, equals(1));

      final txs = await db.select(db.transactionsTable).get();
      final salaryTx = txs.firstWhere((t) => t.recurringRuleId == 'rec_salary');
      expect(salaryTx.type, equals('income'));
      expect(salaryTx.amount, equals(15000.0));

      final bal = await accountsRepo.calculateAccountBalance('acc_main_checking');
      expect(bal, equals(15000.0));
    });
  });
}

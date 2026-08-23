import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracking/features/auto_categorization/data/repositories/auto_categorization_repository_impl.dart';
import 'package:financial_tracking/features/auto_categorization/domain/models/category_rule_model.dart';
import 'package:financial_tracking/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:financial_tracking/features/transactions/domain/models/transaction_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late AccountsRepositoryImpl accountsRepo;
  late TransactionsRepositoryImpl transactionsRepo;
  late AutoCategorizationRepositoryImpl autoCatRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    accountsRepo = AccountsRepositoryImpl(db);
    transactionsRepo = TransactionsRepositoryImpl(db, accountsRepo);
    autoCatRepo = AutoCategorizationRepositoryImpl(db);

    await accountsRepo.createAccount(
      AccountModel(
        id: 'acc_autocat_test',
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

    await db.into(db.categoriesTable).insert(
          const CategoriesTableCompanion(
            id: Value('cat_fuel'),
            name: Value('דלק ותחבורה'),
            type: Value('expense'),
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  test('TASK-15: Auto-Categorization rule creation, suggestions and retroactive application', () async {
    const accId = 'acc_autocat_test';

    // 1. Create 2 uncategorized transactions containing "פז"
    await transactionsRepo.createTransaction(
      TransactionModel(
        id: '',
        accountId: accId,
        amount: 250.0,
        type: TransactionType.expense,
        date: DateTime(2026, 8, 10),
        note: 'תחנת דלק פז ירושלים',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    await transactionsRepo.createTransaction(
      TransactionModel(
        id: '',
        accountId: accId,
        amount: 280.0,
        type: TransactionType.expense,
        date: DateTime(2026, 8, 15),
        note: 'פז שטיפת רכב',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    // Initial suggestions before custom rule (should be 2 uncategorized with no rule suggestion)
    final initialSuggestions = await autoCatRepo.getUncategorizedTransactionsWithSuggestions();
    expect(initialSuggestions.length, 2);

    // 2. Create custom rule for "פז" -> category "cat_fuel" (let's insert category or dummy id)
    final rule = CategoryRuleModel(
      id: 'rule_paz',
      pattern: 'פז',
      matchType: RuleMatchType.contains,
      categoryId: 'cat_fuel',
      createdAt: DateTime.now(),
    );

    await autoCatRepo.saveCategoryRule(rule);

    // Verify rule matches in suggestions
    final ruleSuggestions = await autoCatRepo.getUncategorizedTransactionsWithSuggestions();
    expect(ruleSuggestions.length, 2);
    expect(ruleSuggestions[0].suggestedCategoryId, 'cat_fuel');
    expect(ruleSuggestions[0].confidenceScore, 1.0);

    // 3. Apply rule retroactively
    final appliedCount = await autoCatRepo.applyRuleRetroactively(rule);
    expect(appliedCount, 2);

    // Verify all transactions are now categorized
    final remainingUncategorized = await autoCatRepo.getUncategorizedTransactionsWithSuggestions();
    expect(remainingUncategorized.isEmpty, true);
  });
}

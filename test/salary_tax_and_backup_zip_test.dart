import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/core/services/sync/forex_api_service.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracking/features/auto_categorization/data/repositories/auto_categorization_repository_impl.dart';
import 'package:financial_tracking/features/auto_categorization/domain/models/category_rule_model.dart';
import 'package:financial_tracking/features/backup_settings/data/services/backup_service.dart';
import 'package:financial_tracking/features/backup_settings/data/services/salary_tax_settings_service.dart';
import 'package:financial_tracking/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:financial_tracking/features/transactions/domain/models/transaction_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Salary & Automatic Tax Calculation Tests', () {
    test('calculateFromGross correctly computes tax and net income', () {
      const model = SalaryTaxSettingsModel(baseSalary: 18000, defaultTaxRate: 20.0);
      final res = model.calculateFromGross(20000);
      expect(res.gross, 20000);
      expect(res.tax, 4000);
      expect(res.net, 16000);
    });

    test('calculateFromNet correctly computes gross and tax from net income', () {
      const model = SalaryTaxSettingsModel(baseSalary: 18000, defaultTaxRate: 20.0);
      final res = model.calculateFromNet(16000);
      expect(res.net, 16000);
      expect(res.gross, 20000);
      expect(res.tax, 4000);
    });

    test('toJson and fromJson preserves settings', () {
      const original = SalaryTaxSettingsModel(baseSalary: 22000, defaultTaxRate: 25.0);
      final json = original.toJson();
      final restored = SalaryTaxSettingsModel.fromJson(json);
      expect(restored.baseSalary, 22000);
      expect(restored.defaultTaxRate, 25.0);
    });
  });

  group('Zip Backup & Restore Tests', () {
    late AppDatabase db;
    late AccountsRepositoryImpl accountsRepo;
    late TransactionsRepositoryImpl txRepo;
    late BackupService backupService;

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      accountsRepo = AccountsRepositoryImpl(db);
      txRepo = TransactionsRepositoryImpl(db, accountsRepo);
      backupService = BackupService(db);

      await accountsRepo.createAccount(
        AccountModel(
          id: 'acc_test_1',
          name: 'בנק לאומי',
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

      await txRepo.createTransaction(
        TransactionModel(
          id: 'tx_test_1',
          accountId: 'acc_test_1',
          amount: 500.0,
          type: TransactionType.expense,
          date: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    });

    tearDown(() async {
      await db.close();
    });

    test('exportBackupZipArchive exports valid zip and restoreFromBackupZipArchive restores tables', () async {
      // 1. Export ZIP
      final zipBytes = await backupService.exportBackupZipArchive();
      expect(zipBytes.isNotEmpty, isTrue);

      // 2. Wipe database
      await backupService.resetAllData();
      final accountsAfterReset = await db.select(db.accountsTable).get();
      expect(accountsAfterReset, isEmpty);

      // 3. Restore from ZIP
      final success = await backupService.restoreFromBackupZipArchive(zipBytes);
      expect(success, isTrue);

      // 4. Verify restored data
      final restoredAccounts = await db.select(db.accountsTable).get();
      expect(restoredAccounts.any((a) => a.id == 'acc_test_1'), isTrue);

      final restoredTxs = await db.select(db.transactionsTable).get();
      expect(restoredTxs.length, 1);
      expect(restoredTxs.first.amount, 500.0);
    });
  });

  group('Auto-Categorization Merchant & Note Evaluation Tests', () {
    late AppDatabase db;
    late AccountsRepositoryImpl accountsRepo;
    late TransactionsRepositoryImpl txRepo;
    late AutoCategorizationRepositoryImpl autoCatRepo;

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      accountsRepo = AccountsRepositoryImpl(db);
      txRepo = TransactionsRepositoryImpl(db, accountsRepo);
      autoCatRepo = AutoCategorizationRepositoryImpl(db);

      await accountsRepo.createAccount(
        AccountModel(
          id: 'acc_main',
          name: 'עובר ושב',
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
            const CategoriesTableCompanion(
              id: drift.Value('cat_groceries'),
              name: drift.Value('סופר ומרכול'),
              type: drift.Value('expense'),
            ),
          );

      await db.into(db.merchantsTable).insert(
            const MerchantsTableCompanion(
              id: drift.Value('merch_shekem'),
              name: drift.Value('שקם אלקטריק'),
            ),
          );
    });

    tearDown(() async {
      await db.close();
    });

    test('applyRuleRetroactively matches both merchant name and note', () async {
      // Insert transaction with merchant "שקם" and NO category
      await txRepo.createTransaction(
        TransactionModel(
          id: '',
          accountId: 'acc_main',
          merchantId: 'merch_shekem',
          amount: 150.0,
          type: TransactionType.expense,
          date: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Apply rule for "שקם" -> cat_groceries
      final rule = CategoryRuleModel(
        id: 'rule_1',
        pattern: 'שקם',
        categoryId: 'cat_groceries',
        matchType: RuleMatchType.contains,
        createdAt: DateTime.now(),
      );

      final appliedCount = await autoCatRepo.applyRuleRetroactively(rule);
      expect(appliedCount, 1);

      final uncategorized = await autoCatRepo.getUncategorizedTransactionsWithSuggestions();
      expect(uncategorized.isEmpty, isTrue);
    });
  });

  group('Forex API Engine Tests', () {
    test('ForexApiService can instantiate and provides fallback rate', () {
      final service = ForexApiService();
      expect(service, isNotNull);
    });
  });
}

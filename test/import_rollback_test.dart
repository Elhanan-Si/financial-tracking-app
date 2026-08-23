import 'package:drift/native.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracking/features/categories_tags/data/repositories/categories_repository_impl.dart';
import 'package:financial_tracking/features/import_export/data/repositories/import_repository_impl.dart';
import 'package:financial_tracking/features/import_export/domain/models/duplicate_match_result.dart';
import 'package:financial_tracking/features/import_export/domain/models/parsed_transaction_row.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late AccountsRepositoryImpl accountsRepo;
  late CategoriesRepositoryImpl categoriesRepo;
  late ImportRepositoryImpl importRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    accountsRepo = AccountsRepositoryImpl(db);
    categoriesRepo = CategoriesRepositoryImpl(db);
    importRepo = ImportRepositoryImpl(db, accountsRepo, categoriesRepo);

    await accountsRepo.createAccount(
      AccountModel(
        id: 'acc_import_target',
        name: 'עו"ש ראשי',
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
  });

  tearDown(() async {
    await db.close();
  });

  test('TASK-13 & TASK-14: Batch Import creates transactions, updates balance, and Rollback reverts everything', () async {
    const accId = 'acc_import_target';

    final matchResults = [
      DuplicateMatchResult(
        parsedRow: ParsedTransactionRow(
          rowIndex: 1,
          date: DateTime(2026, 8, 1),
          rawDescription: 'משכורת חודשית',
          amount: 10000.0, // Income
        ),
        confidence: DuplicateConfidenceLevel.none,
        resolution: DuplicateResolutionAction.importAsNew,
      ),
      DuplicateMatchResult(
        parsedRow: ParsedTransactionRow(
          rowIndex: 2,
          date: DateTime(2026, 8, 5),
          rawDescription: 'קניות סופר',
          amount: -2000.0, // Expense
        ),
        confidence: DuplicateConfidenceLevel.none,
        resolution: DuplicateResolutionAction.importAsNew,
      ),
    ];

    // 1. Execute Import
    final batchId = await importRepo.executeImport(
      accountId: accId,
      sourceName: 'Leumi',
      fileName: 'leumi_aug_2026.csv',
      matchResults: matchResults,
    );

    expect(batchId.startsWith('batch_'), true);

    // Initial 5000 + 10000 income - 2000 expense = 13000
    final updatedAccount = await accountsRepo.getAccountById(accId);
    expect(updatedAccount?.currentBalance, 13000.0);

    final batches = await importRepo.getImportBatches();
    expect(batches.length, 1);
    expect(batches.first.status, 'completed');
    expect(batches.first.importedRows, 2);

    // 2. Perform Rollback
    await importRepo.rollbackBatch(batchId);

    // Balance should revert back to 5000.0
    final revertedAccount = await accountsRepo.getAccountById(accId);
    expect(revertedAccount?.currentBalance, 5000.0);

    final revertedBatches = await importRepo.getImportBatches();
    expect(revertedBatches.first.status, 'rolled_back');
  });
}

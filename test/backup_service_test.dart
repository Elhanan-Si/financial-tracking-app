import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/backup_settings/data/services/backup_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late BackupService backupService;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    backupService = BackupService(db);

    // Populate initial test data
    await db.into(db.accountsTable).insert(
          AccountsTableCompanion.insert(
            id: 'acc-test-1',
            name: 'חשבון עו"ש ראשי',
            type: 'bank',
            currency: const Value('ILS'),
            initialBalance: const Value(5000.0),
            currentBalance: const Value(5000.0),
            colorValue: const Value(0xFF3B82F6),
            iconName: const Value('bank'),
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
          ),
        );

    await db.into(db.transactionsTable).insert(
          TransactionsTableCompanion.insert(
            id: 'tx-test-1',
            accountId: 'acc-test-1',
            amount: 250.0,
            type: 'expense',
            date: DateTime.now(),
            note: const Value('קניות בסופר'),
            createdAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
          ),
        );
  });

  tearDown(() async {
    await db.close();
  });

  test('BackupService exports full JSON with SHA-256 and restores into a clean DB', () async {
    final jsonExport = await backupService.exportFullJsonBackup();
    expect(jsonExport.contains('"version": "2.7.0"'), isTrue);
    expect(jsonExport.contains('"checksum":'), isTrue);
    expect(jsonExport.contains('acc-test-1'), isTrue);

    // Create a new clean DB and restore
    final newDb = AppDatabase(NativeDatabase.memory());
    final newBackupService = BackupService(newDb);

    final success = await newBackupService.restoreFromJsonBackup(jsonExport);
    expect(success, isTrue);

    final accounts = await newDb.select(newDb.accountsTable).get();
    expect(accounts.any((a) => a.id == 'acc-test-1'), isTrue);

    final transactions = await newDb.select(newDb.transactionsTable).get();
    expect(transactions.any((t) => t.id == 'tx-test-1'), isTrue);

    await newDb.close();
  });

  test('BackupService exports Transactions to formatted Hebrew CSV for Excel', () async {
    final csv = await backupService.exportTransactionsCsv();
    expect(csv.startsWith('\uFEFF'), isTrue); // BOM for Excel
    expect(csv.contains('מזהה,תאריך,סוג,חשבון,קטגוריה,סכום (₪),הערה'), isTrue);
    expect(csv.contains('קניות בסופר'), isTrue);
    expect(csv.contains('250'), isTrue);
  });

  test('BackupService resets only transactions without deleting accounts', () async {
    await backupService.resetTransactionsOnly();

    final accounts = await db.select(db.accountsTable).get();
    expect(accounts.any((a) => a.id == 'acc-test-1'), isTrue);

    final transactions = await db.select(db.transactionsTable).get();
    expect(transactions, isEmpty);
  });

  test('BackupService resetAllData wipes all user data cleanly', () async {
    await backupService.resetAllData();

    final accounts = await db.select(db.accountsTable).get();
    expect(accounts, isEmpty);

    final transactions = await db.select(db.transactionsTable).get();
    expect(transactions, isEmpty);
  });
}

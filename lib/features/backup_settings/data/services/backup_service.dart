import 'dart:convert';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart' show Value;
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final backupServiceProvider = Provider<BackupService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return BackupService(db);
});

class BackupService {
  final AppDatabase _db;

  BackupService(this._db);

  /// Generates a full JSON backup payload with SHA-256 Checksum
  Future<String> exportFullJsonBackup() async {
    final accounts = await _db.select(_db.accountsTable).get();
    final categories = await _db.select(_db.categoriesTable).get();
    final transactions = await _db.select(_db.transactionsTable).get();
    final splits = await _db.select(_db.transactionSplitsTable).get();
    final budgets = await _db.select(_db.budgetsTable).get();
    final holdings = await _db.select(_db.holdingsTable).get();
    final pension = await _db.select(_db.pensionAssetsTable).get();
    final assets = await _db.select(_db.assetsTable).get();
    final liabilities = await _db.select(_db.liabilitiesTable).get();

    final dataPayload = {
      'accounts': accounts.map((a) => a.toJson()).toList(),
      'categories': categories.map((c) => c.toJson()).toList(),
      'transactions': transactions.map((t) => t.toJson()).toList(),
      'splits': splits.map((s) => s.toJson()).toList(),
      'budgets': budgets.map((b) => b.toJson()).toList(),
      'holdings': holdings.map((h) => h.toJson()).toList(),
      'pension': pension.map((p) => p.toJson()).toList(),
      'assets': assets.map((a) => a.toJson()).toList(),
      'liabilities': liabilities.map((l) => l.toJson()).toList(),
    };

    final rawDataJson = jsonEncode(dataPayload);
    final checksum = sha256.convert(utf8.encode(rawDataJson)).toString();

    final rootBackup = {
      'app': 'FinancialTracking',
      'version': '2.7.0',
      'exportedAt': DateTime.now().toIso8601String(),
      'checksum': checksum,
      'data': dataPayload,
    };

    return const JsonEncoder.withIndent('  ').convert(rootBackup);
  }

  /// Exports a compressed .backup / .zip archive containing backup_data.json and manifest.json
  Future<Uint8List> exportBackupZipArchive() async {
    final jsonStr = await exportFullJsonBackup();
    final jsonBytes = utf8.encode(jsonStr);

    final archive = Archive();
    archive.addFile(ArchiveFile('backup_data.json', jsonBytes.length, jsonBytes));

    final manifest = {
      'app': 'FinancialTracking',
      'version': '2.7.0',
      'exportedAt': DateTime.now().toIso8601String(),
      'format': 'ZIP_V1',
    };
    final manifestBytes = utf8.encode(jsonEncode(manifest));
    archive.addFile(ArchiveFile('manifest.json', manifestBytes.length, manifestBytes));

    final zipBytes = ZipEncoder().encode(archive);
    return Uint8List.fromList(zipBytes!);
  }

  /// Restores database from a compressed .backup / .zip archive
  Future<bool> restoreFromBackupZipArchive(Uint8List zipBytes) async {
    final archive = ZipDecoder().decodeBytes(zipBytes);
    final backupFile = archive.findFile('backup_data.json');
    if (backupFile == null) {
      throw const FormatException('קובץ הגיבוי פגום: לא נמצא קובץ נתונים ראשי (backup_data.json)');
    }

    final contentBytes = backupFile.content as List<int>;
    final jsonStr = utf8.decode(contentBytes);
    return await restoreFromJsonBackup(jsonStr);
  }

  /// Exports flat CSV for Excel of all transactions
  Future<String> exportTransactionsCsv() async {
    final txs = await _db.select(_db.transactionsTable).get();
    final accounts = await _db.select(_db.accountsTable).get();
    final categories = await _db.select(_db.categoriesTable).get();

    final accMap = {for (var a in accounts) a.id: a.name};
    final catMap = {for (var c in categories) c.id: c.name};

    final buffer = StringBuffer();
    // UTF-8 BOM for Excel
    buffer.write('\uFEFF');
    buffer.writeln('מזהה,תאריך,סוג,חשבון,קטגוריה,סכום (₪),הערה');

    for (final t in txs) {
      final accName = accMap[t.accountId] ?? t.accountId;
      final catName = t.categoryId != null ? (catMap[t.categoryId] ?? '') : 'מפוצל/ללא קטגוריה';
      final typeHebrew = t.type == 'income' ? 'הכנסה' : (t.type == 'expense' ? 'הוצאה' : 'העברה');
      final dateStr = '${t.date.day.toString().padLeft(2, '0')}/${t.date.month.toString().padLeft(2, '0')}/${t.date.year}';
      
      buffer.writeln('"${t.id}","$dateStr","$typeHebrew","$accName","$catName",${t.amount},"${t.note ?? ''}"');
    }

    return buffer.toString();
  }

  /// Restores database state from a validated JSON backup string
  Future<bool> restoreFromJsonBackup(String jsonStr) async {
    final root = jsonDecode(jsonStr) as Map<String, dynamic>;
    if (root['app'] != 'FinancialTracking' || root['data'] == null) {
      throw FormatException('קובץ גיבוי לא תקין או שאינו שייך לאפליקציית מעקב פיננסי');
    }

    final dataPayload = root['data'] as Map<String, dynamic>;
    final rawDataJson = jsonEncode(dataPayload);
    final calculatedChecksum = sha256.convert(utf8.encode(rawDataJson)).toString();

    final expectedChecksum = root['checksum'] as String?;
    if (expectedChecksum != null && expectedChecksum != calculatedChecksum) {
      throw FormatException('אימות אבטחה נכשל: נתוני הגיבוי פגומים או ששונו (Checksum Mismatch)');
    }

    // Execute in transaction
    await _db.transaction(() async {
      // Clear tables
      await _db.delete(_db.transactionSplitsTable).go();
      await _db.delete(_db.transactionsTable).go();
      await _db.delete(_db.budgetsTable).go();
      await _db.delete(_db.holdingsTable).go();
      await _db.delete(_db.pensionSnapshotsTable).go();
      await _db.delete(_db.pensionAssetsTable).go();
      await _db.delete(_db.liabilitiesTable).go();
      await _db.delete(_db.assetsTable).go();
      await _db.delete(_db.accountsTable).go();

      // Restore accounts
      if (dataPayload['accounts'] != null) {
        for (final item in (dataPayload['accounts'] as List)) {
          await _db.into(_db.accountsTable).insert(AccountEntry.fromJson(item as Map<String, dynamic>));
        }
      }

      // Restore transactions
      if (dataPayload['transactions'] != null) {
        for (final item in (dataPayload['transactions'] as List)) {
          await _db.into(_db.transactionsTable).insert(TransactionEntry.fromJson(item as Map<String, dynamic>));
        }
      }

      // Restore splits
      if (dataPayload['splits'] != null) {
        for (final item in (dataPayload['splits'] as List)) {
          await _db.into(_db.transactionSplitsTable).insert(TransactionSplitEntry.fromJson(item as Map<String, dynamic>));
        }
      }

      // Restore budgets
      if (dataPayload['budgets'] != null) {
        for (final item in (dataPayload['budgets'] as List)) {
          await _db.into(_db.budgetsTable).insert(BudgetEntry.fromJson(item as Map<String, dynamic>));
        }
      }

      // Restore holdings
      if (dataPayload['holdings'] != null) {
        for (final item in (dataPayload['holdings'] as List)) {
          await _db.into(_db.holdingsTable).insert(HoldingEntry.fromJson(item as Map<String, dynamic>));
        }
      }

      // Restore pension
      if (dataPayload['pension'] != null) {
        for (final item in (dataPayload['pension'] as List)) {
          await _db.into(_db.pensionAssetsTable).insert(PensionAssetEntry.fromJson(item as Map<String, dynamic>));
        }
      }

      // Restore assets & liabilities
      if (dataPayload['assets'] != null) {
        for (final item in (dataPayload['assets'] as List)) {
          await _db.into(_db.assetsTable).insert(AssetEntry.fromJson(item as Map<String, dynamic>));
        }
      }
      if (dataPayload['liabilities'] != null) {
        for (final item in (dataPayload['liabilities'] as List)) {
          await _db.into(_db.liabilitiesTable).insert(LiabilityEntry.fromJson(item as Map<String, dynamic>));
        }
      }
    });

    return true;
  }

  // --- Secure Reset Functions ---

  /// Full Factory Reset: Clears all user data
  Future<void> resetAllData() async {
    await _db.transaction(() async {
      await _db.delete(_db.transactionSplitsTable).go();
      await _db.delete(_db.transactionsTable).go();
      await _db.delete(_db.installmentItemsTable).go();
      await _db.delete(_db.installmentPlansTable).go();
      await _db.delete(_db.recurringRulesTable).go();
      await _db.delete(_db.transferLinksTable).go();
      await _db.delete(_db.budgetsTable).go();
      await _db.delete(_db.budgetPeriodsTable).go();
      await _db.delete(_db.investmentTransactionsTable).go();
      await _db.delete(_db.holdingsTable).go();
      await _db.delete(_db.pensionSnapshotsTable).go();
      await _db.delete(_db.pensionAssetsTable).go();
      await _db.delete(_db.loanSchedulesTable).go();
      await _db.delete(_db.liabilitiesTable).go();
      await _db.delete(_db.assetsTable).go();
      await _db.delete(_db.netWorthSnapshotsTable).go();
      await _db.delete(_db.importBatchesTable).go();
      await _db.delete(_db.accountsTable).go();
    });
  }

  /// Reset Transactions Only: Clears transactions, splits, installments, recurring history
  Future<void> resetTransactionsOnly() async {
    await _db.transaction(() async {
      await _db.delete(_db.transactionSplitsTable).go();
      await _db.delete(_db.transactionsTable).go();
      await _db.delete(_db.installmentItemsTable).go();
      await _db.delete(_db.installmentPlansTable).go();
      await _db.delete(_db.transferLinksTable).go();
      await _db.delete(_db.importBatchesTable).go();

      // Reset accounts current balances to initial balances
      final accounts = await _db.select(_db.accountsTable).get();
      for (final acc in accounts) {
        await (_db.update(_db.accountsTable)..where((t) => t.id.equals(acc.id)))
            .write(AccountsTableCompanion(currentBalance: Value(acc.initialBalance)));
      }
    });
  }

  /// Reset Budgets & Goals Only
  Future<void> resetBudgetsOnly() async {
    await _db.transaction(() async {
      await _db.delete(_db.budgetsTable).go();
      await _db.delete(_db.budgetPeriodsTable).go();
    });
  }

  /// Reset Investments & Assets Only (Stocks, Pensions, Real Estate, Mortgages)
  Future<void> resetInvestmentsAndAssetsOnly() async {
    await _db.transaction(() async {
      await _db.delete(_db.investmentTransactionsTable).go();
      await _db.delete(_db.holdingsTable).go();
      await _db.delete(_db.pensionSnapshotsTable).go();
      await _db.delete(_db.pensionAssetsTable).go();
      await _db.delete(_db.loanSchedulesTable).go();
      await _db.delete(_db.liabilitiesTable).go();
      await _db.delete(_db.assetsTable).go();
      await _db.delete(_db.netWorthSnapshotsTable).go();
    });
  }
}

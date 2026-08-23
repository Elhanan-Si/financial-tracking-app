import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../accounts/domain/repositories/accounts_repository.dart';
import '../../../categories_tags/domain/repositories/categories_repository.dart';
import '../../domain/models/duplicate_match_result.dart';
import '../../domain/models/import_batch_model.dart';
import '../../domain/models/import_mapping_model.dart';
import '../../domain/repositories/import_repository.dart';

/// Drift implementation of ImportRepository
class ImportRepositoryImpl implements ImportRepository {
  final AppDatabase _db;
  final AccountsRepository _accountsRepo;
  final CategoriesRepository _categoriesRepo;

  ImportRepositoryImpl(this._db, this._accountsRepo, this._categoriesRepo);

  @override
  Stream<List<ImportBatchModel>> watchImportBatches() {
    final query = _db.select(_db.importBatchesTable)
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.importedAt, mode: OrderingMode.desc)]);

    return query.watch().map((rows) {
      return rows.map((r) => _mapRowToModel(r)).toList();
    });
  }

  @override
  Future<List<ImportBatchModel>> getImportBatches() async {
    final rows = await (_db.select(_db.importBatchesTable)
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.importedAt, mode: OrderingMode.desc)]))
        .get();

    return rows.map((r) => _mapRowToModel(r)).toList();
  }

  @override
  Future<ImportBatchModel?> getBatchById(String batchId) async {
    final row = await (_db.select(_db.importBatchesTable)..where((tbl) => tbl.id.equals(batchId))).getSingleOrNull();
    if (row == null) return null;
    return _mapRowToModel(row);
  }

  @override
  Future<void> saveMappingTemplate(ImportMappingModel mapping) async {
    final now = DateTime.now();
    final existing = await (_db.select(_db.importMappingsTable)
          ..where((tbl) => tbl.sourceName.equals(mapping.sourceName)))
        .getSingleOrNull();

    if (existing != null) {
      await (_db.update(_db.importMappingsTable)..where((tbl) => tbl.id.equals(existing.id))).write(
        ImportMappingsTableCompanion(
          mappingConfigJson: Value(mapping.toJsonString()),
          updatedAt: Value(now),
        ),
      );
    } else {
      await _db.into(_db.importMappingsTable).insert(
            ImportMappingsTableCompanion.insert(
              id: mapping.id.isNotEmpty ? mapping.id : 'map_${DateTime.now().millisecondsSinceEpoch}',
              sourceName: mapping.sourceName,
              mappingConfigJson: mapping.toJsonString(),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
    }
  }

  @override
  Future<ImportMappingModel?> getMappingTemplate(String sourceName) async {
    final row = await (_db.select(_db.importMappingsTable)..where((tbl) => tbl.sourceName.equals(sourceName))).getSingleOrNull();
    if (row == null) return null;

    return ImportMappingModel.fromJsonString(
      id: row.id,
      sourceName: row.sourceName,
      jsonString: row.mappingConfigJson,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  @override
  Future<String> executeImport({
    required String accountId,
    required String sourceName,
    required String fileName,
    required List<DuplicateMatchResult> matchResults,
  }) async {
    return await _db.transaction(() async {
      final batchId = 'batch_${DateTime.now().millisecondsSinceEpoch}';
      final now = DateTime.now();

      int importedCount = 0;
      int duplicatesMergedCount = 0;
      int skippedCount = 0;

      for (final match in matchResults) {
        final row = match.parsedRow;

        if (match.resolution == DuplicateResolutionAction.skip) {
          skippedCount++;
          continue;
        }

        if (match.resolution == DuplicateResolutionAction.merge && match.matchedTransaction != null) {
          // Merge: Preserve user category & notes, add reference if missing
          final existing = match.matchedTransaction!;
          final updatedRef = (existing.transferLinkId == null || existing.transferLinkId!.isEmpty)
              ? row.referenceNumber
              : existing.transferLinkId;

          await (_db.update(_db.transactionsTable)..where((tbl) => tbl.id.equals(existing.id))).write(
            TransactionsTableCompanion(
              transferLinkId: Value(updatedRef),
              updatedAt: Value(now),
            ),
          );
          duplicatesMergedCount++;
          continue;
        }

        // Import as new transaction
        String? merchantId;
        String? resolvedCategoryId = row.categoryId;
        bool isAutoCategorized = false;

        if (row.merchantName != null && row.merchantName!.trim().isNotEmpty) {
          final merchant = await _categoriesRepo.findOrCreateMerchant(
            row.merchantName!.trim(),
            defaultCategoryId: row.categoryId,
          );
          merchantId = merchant.id;
          if (resolvedCategoryId == null && merchant.defaultCategoryId != null) {
            resolvedCategoryId = merchant.defaultCategoryId;
            isAutoCategorized = true;
          }
        }

        final txId = 'tx_imp_${DateTime.now().millisecondsSinceEpoch}_$importedCount';
        final isIncome = row.amount > 0;
        final txAmount = row.amount.abs();

        await _db.into(_db.transactionsTable).insert(
              TransactionsTableCompanion.insert(
                id: txId,
                accountId: accountId,
                categoryId: Value(resolvedCategoryId),
                merchantId: Value(merchantId),
                amount: txAmount,
                type: isIncome ? 'income' : 'expense',
                date: row.date,
                note: Value(row.rawDescription),
                transferLinkId: Value(batchId), // Links to batch for clean rollback!
                isAutoCategorized: Value(isAutoCategorized),
                originalCurrency: Value(row.originalCurrency ?? 'ILS'),
                originalAmount: Value(row.originalAmount ?? txAmount),
                exchangeRateToIls: const Value(1.0),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
        importedCount++;
      }

      // Save Batch Entry
      await _db.into(_db.importBatchesTable).insert(
            ImportBatchesTableCompanion.insert(
              id: batchId,
              sourceName: sourceName,
              fileName: fileName,
              importedAt: Value(now),
              totalRows: Value(matchResults.length),
              importedRows: Value(importedCount),
              duplicatesSkipped: Value(duplicatesMergedCount + skippedCount),
              status: const Value('completed'),
              createdAt: Value(now),
            ),
          );

      // Recalculate account balance
      await _accountsRepo.calculateAccountBalance(accountId);

      return batchId;
    });
  }

  @override
  Future<void> rollbackBatch(String batchId) async {
    await _db.transaction(() async {
      final batch = await (_db.select(_db.importBatchesTable)..where((tbl) => tbl.id.equals(batchId))).getSingleOrNull();
      if (batch == null) return;

      // Find affected accounts
      final affectedAccounts = await (_db.selectOnly(_db.transactionsTable, distinct: true)
            ..addColumns([_db.transactionsTable.accountId])
            ..where(_db.transactionsTable.transferLinkId.equals(batchId)))
          .map((r) => r.read(_db.transactionsTable.accountId)!)
          .get();

      // Delete all transactions created in this batch
      await (_db.delete(_db.transactionsTable)..where((tbl) => tbl.transferLinkId.equals(batchId))).go();

      // Mark batch as rolled_back
      await (_db.update(_db.importBatchesTable)..where((tbl) => tbl.id.equals(batchId))).write(
        const ImportBatchesTableCompanion(
          status: Value('rolled_back'),
        ),
      );

      // Recalculate balances
      for (final accId in affectedAccounts) {
        await _accountsRepo.calculateAccountBalance(accId);
      }
    });
  }

  ImportBatchModel _mapRowToModel(ImportBatchEntry row) {
    return ImportBatchModel(
      id: row.id,
      sourceName: row.sourceName,
      fileName: row.fileName,
      importedAt: row.importedAt,
      totalRows: row.totalRows,
      importedRows: row.importedRows,
      duplicatesSkipped: row.duplicatesSkipped,
      status: row.status,
      createdAt: row.createdAt,
    );
  }
}

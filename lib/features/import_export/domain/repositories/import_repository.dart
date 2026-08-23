import '../models/duplicate_match_result.dart';
import '../models/import_batch_model.dart';
import '../models/import_mapping_model.dart';

/// Repository interface for Statement Imports, Mappings, and Batch Rollbacks
abstract class ImportRepository {
  Stream<List<ImportBatchModel>> watchImportBatches();
  Future<List<ImportBatchModel>> getImportBatches();
  Future<ImportBatchModel?> getBatchById(String batchId);

  Future<void> saveMappingTemplate(ImportMappingModel mapping);
  Future<ImportMappingModel?> getMappingTemplate(String sourceName);

  /// Commits verified match results into the database in a single atomic transaction
  Future<String> executeImport({
    required String accountId,
    required String sourceName,
    required String fileName,
    required List<DuplicateMatchResult> matchResults,
  });

  /// Rolls back an entire import batch and restores account balances
  Future<void> rollbackBatch(String batchId);
}

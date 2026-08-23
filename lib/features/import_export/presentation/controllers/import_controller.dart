import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../accounts/presentation/controllers/accounts_controller.dart';
import '../../../categories_tags/presentation/controllers/categories_controller.dart';
import '../../../transactions/presentation/controllers/transactions_controller.dart';
import '../../data/deduplication/deduplication_engine.dart';
import '../../data/parsers/generic_csv_excel_parser.dart';
import '../../data/parsers/isracard_parser.dart';
import '../../data/parsers/leumi_parser.dart';
import '../../data/parsers/one_zero_parser.dart';
import '../../data/parsers/pagi_fibi_parser.dart';
import '../../data/repositories/import_repository_impl.dart';
import '../../domain/models/duplicate_match_result.dart';
import '../../domain/models/import_batch_model.dart';
import '../../domain/models/parsed_transaction_row.dart';
import '../../domain/repositories/import_repository.dart';

final importRepositoryProvider = Provider<ImportRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final accountsRepo = ref.watch(accountsRepositoryProvider);
  final categoriesRepo = ref.watch(categoriesRepositoryProvider);
  return ImportRepositoryImpl(db, accountsRepo, categoriesRepo);
});

final importBatchesStreamProvider = StreamProvider<List<ImportBatchModel>>((ref) {
  final repo = ref.watch(importRepositoryProvider);
  return repo.watchImportBatches();
});

final selectedImportAccountProvider = StateProvider<String?>((ref) => null);
final selectedImportSourceProvider = StateProvider<String>((ref) => 'Isracard');
final activeImportResultsProvider = StateProvider<List<DuplicateMatchResult>>((ref) => []);

final importControllerProvider = Provider<ImportController>((ref) {
  final repo = ref.watch(importRepositoryProvider);
  final txRepo = ref.watch(transactionsRepositoryProvider);
  return ImportController(repo, txRepo, ref);
});

class ImportController {
  final ImportRepository _repo;
  final dynamic _txRepo;
  final Ref _ref;

  ImportController(this._repo, this._txRepo, this._ref);

  /// Parses file (CSV text or Excel bytes) according to source preset
  Future<List<DuplicateMatchResult>> parseAndEvaluate({
    required String accountId,
    required String sourceName,
    String? csvContent,
    Uint8List? excelBytes,
  }) async {
    List<ParsedTransactionRow> parsedRows = [];

    if (excelBytes != null && excelBytes.isNotEmpty) {
      switch (sourceName) {
        case 'Isracard':
          parsedRows = IsracardParser.parseExcel(excelBytes);
          break;
        case 'Leumi':
          parsedRows = LeumiParser.parseExcel(excelBytes);
          break;
        case 'PAGI':
          parsedRows = PagiFibiParser.parseExcel(excelBytes);
          break;
        case 'OneZero':
          parsedRows = OneZeroParser.parseExcel(excelBytes);
          break;
        default:
          parsedRows = GenericCsvExcelParser.parseExcel(bytes: excelBytes);
      }
    } else if (csvContent != null && csvContent.isNotEmpty) {
      switch (sourceName) {
        case 'Isracard':
          parsedRows = IsracardParser.parseCsv(csvContent);
          break;
        case 'Leumi':
          parsedRows = LeumiParser.parseCsv(csvContent);
          break;
        case 'PAGI':
          parsedRows = PagiFibiParser.parseCsv(csvContent);
          break;
        case 'OneZero':
          parsedRows = OneZeroParser.parseCsv(csvContent);
          break;
        default:
          parsedRows = GenericCsvExcelParser.parseCsv(csvContent: csvContent);
      }
    }

    if (parsedRows.isEmpty) {
      _ref.read(activeImportResultsProvider.notifier).state = [];
      return [];
    }

    // Load existing transactions to run Deduplication Engine
    final existingTransactions = await _txRepo.watchTransactions(accountId: accountId).first;

    final matchResults = DeduplicationEngine.evaluateDuplicates(
      parsedRows: parsedRows,
      existingTransactions: existingTransactions,
      accountId: accountId,
    );

    _ref.read(activeImportResultsProvider.notifier).state = matchResults;
    return matchResults;
  }

  void updateRowResolution(int index, DuplicateResolutionAction newAction) {
    _ref.read(activeImportResultsProvider.notifier).update((list) {
      if (index < 0 || index >= list.length) return list;
      final copy = List<DuplicateMatchResult>.from(list);
      copy[index] = copy[index].copyWith(resolution: newAction);
      return copy;
    });
  }

  Future<String> executeImport({
    required String accountId,
    required String sourceName,
    required String fileName,
  }) async {
    final results = _ref.read(activeImportResultsProvider);
    if (results.isEmpty) throw Exception('אין שורות נתונים לייבוא');

    final batchId = await _repo.executeImport(
      accountId: accountId,
      sourceName: sourceName,
      fileName: fileName,
      matchResults: results,
    );

    _ref.read(activeImportResultsProvider.notifier).state = [];
    return batchId;
  }

  Future<void> rollbackBatch(String batchId) async {
    await _repo.rollbackBatch(batchId);
  }
}

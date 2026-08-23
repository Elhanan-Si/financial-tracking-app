import 'dart:typed_data';
import '../../domain/models/import_mapping_model.dart';
import '../../domain/models/parsed_transaction_row.dart';
import 'generic_csv_excel_parser.dart';

/// Specialized Parser for Isracard credit card statements (.xlsx and .csv)
class IsracardParser {
  static final ImportMappingModel defaultMapping = ImportMappingModel(
    id: 'mapping_isracard',
    sourceName: 'Isracard',
    dateColumn: 'תאריך רכישה',
    descriptionColumn: 'שם בית עסק',
    amountColumn: 'סכום חיוב',
    categoryColumn: 'ענף',
    referenceColumn: 'מספר שובר',
    currencyColumn: 'מטבע',
    dateFormat: 'dd/MM/yyyy',
    skipHeaderRows: 3,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  static List<ParsedTransactionRow> parseCsv(String content) {
    return GenericCsvExcelParser.parseCsv(
      csvContent: content,
      mapping: defaultMapping,
    );
  }

  static List<ParsedTransactionRow> parseExcel(Uint8List bytes) {
    return GenericCsvExcelParser.parseExcel(
      bytes: bytes,
      mapping: defaultMapping,
    );
  }
}

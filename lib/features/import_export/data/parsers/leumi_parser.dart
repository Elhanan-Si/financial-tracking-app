import 'dart:typed_data';
import '../../domain/models/import_mapping_model.dart';
import '../../domain/models/parsed_transaction_row.dart';
import 'generic_csv_excel_parser.dart';

/// Specialized Parser for Bank Leumi checking account statements (.xlsx and .csv)
class LeumiParser {
  static final ImportMappingModel defaultMapping = ImportMappingModel(
    id: 'mapping_leumi',
    sourceName: 'Leumi',
    dateColumn: 'תאריך',
    descriptionColumn: 'תיאור',
    debitColumn: 'חובה',
    creditColumn: 'זכות',
    referenceColumn: 'אסמכתא',
    dateFormat: 'dd/MM/yyyy',
    skipHeaderRows: 1,
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

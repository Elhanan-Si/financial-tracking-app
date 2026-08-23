import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import '../../domain/models/import_mapping_model.dart';
import '../../domain/models/parsed_transaction_row.dart';

/// Universal Parser for CSV and Excel files supporting dynamic header mapping and presets
class GenericCsvExcelParser {
  /// Parse CSV from raw String or byte content
  static List<ParsedTransactionRow> parseCsv({
    required String csvContent,
    ImportMappingModel? mapping,
  }) {
    final rows = const CsvToListConverter(shouldParseNumbers: false, eol: '\n').convert(csvContent);
    if (rows.isEmpty) return [];

    return _parseTableRows(rows, mapping);
  }

  /// Parse Excel (.xlsx) from raw bytes
  static List<ParsedTransactionRow> parseExcel({
    required Uint8List bytes,
    ImportMappingModel? mapping,
  }) {
    final excel = Excel.decodeBytes(bytes);
    final sheetName = excel.tables.keys.firstWhere((k) => excel.tables[k]?.rows.isNotEmpty ?? false, orElse: () => '');
    if (sheetName.isEmpty) return [];

    final sheet = excel.tables[sheetName];
    if (sheet == null || sheet.rows.isEmpty) return [];

    final tableRows = <List<dynamic>>[];
    for (final row in sheet.rows) {
      final cells = row.map((cell) => cell?.value?.toString() ?? '').toList();
      tableRows.add(cells);
    }

    return _parseTableRows(tableRows, mapping);
  }

  static List<ParsedTransactionRow> _parseTableRows(
    List<List<dynamic>> allRows,
    ImportMappingModel? mapping,
  ) {
    if (allRows.isEmpty) return [];

    // Find header row (either row 0 or row matching common Hebrew financial keywords)
    int headerIndex = 0;
    for (int i = 0; i < allRows.length && i < 10; i++) {
      final rowStr = allRows[i].map((e) => e.toString().trim()).join(' ');
      if (rowStr.contains('תאריך') || rowStr.contains('סכום') || rowStr.contains('תיאור') || rowStr.contains('חובה')) {
        headerIndex = i;
        break;
      }
    }

    final headerRow = allRows[headerIndex].map((e) => e.toString().trim()).toList();
    final dataRows = allRows.sublist(headerIndex + 1);

    // Resolve column indices
    int dateCol = _findColumnIndex(headerRow, mapping?.dateColumn, ['תאריך', 'תאריך רכישה', 'תאריך עסקה', 'תאריך ערך', 'Date']);
    int descCol = _findColumnIndex(headerRow, mapping?.descriptionColumn, ['תיאור', 'שם בית עסק', 'בית עסק', 'שם עסק', 'פירוט', 'Description', 'Merchant']);
    int amountCol = _findColumnIndex(headerRow, mapping?.amountColumn, ['סכום', 'סכום חיוב', 'סכום עסקה', 'סכום בש"ח', 'סכום לתשלום', 'Amount']);
    int debitCol = _findColumnIndex(headerRow, mapping?.debitColumn, ['חובה', 'סכום חובה', 'Debit']);
    int creditCol = _findColumnIndex(headerRow, mapping?.creditColumn, ['זכות', 'סכום זכות', 'Credit']);
    int refCol = _findColumnIndex(headerRow, mapping?.referenceColumn, ['אסמכתא', 'מספר אסמכתא', 'מספר שובר', 'Ref', 'Reference']);
    int catCol = _findColumnIndex(headerRow, mapping?.categoryColumn, ['ענף', 'קטגוריה', 'סיווג', 'Category']);
    int currCol = _findColumnIndex(headerRow, mapping?.currencyColumn, ['מטבע', 'מטבע מקור', 'Currency']);

    final results = <ParsedTransactionRow>[];

    for (int rIdx = 0; rIdx < dataRows.length; rIdx++) {
      final row = dataRows[rIdx];
      if (row.isEmpty || row.every((c) => c.toString().trim().isEmpty)) continue;

      final dateStr = (dateCol >= 0 && dateCol < row.length) ? row[dateCol].toString().trim() : '';
      final descStr = (descCol >= 0 && descCol < row.length) ? row[descCol].toString().trim() : 'ללא תיאור';
      final refStr = (refCol >= 0 && refCol < row.length) ? row[refCol].toString().trim() : null;
      final catStr = (catCol >= 0 && catCol < row.length) ? row[catCol].toString().trim() : null;
      final currStr = (currCol >= 0 && currCol < row.length) ? row[currCol].toString().trim() : 'ILS';

      final parsedDate = _tryParseDate(dateStr, mapping?.dateFormat);
      if (parsedDate == null) {
        // Skip header repetitions or invalid date rows
        continue;
      }

      double amount = 0.0;
      if (amountCol >= 0 && amountCol < row.length) {
        amount = _parseAmount(row[amountCol].toString());
      } else if (debitCol >= 0 || creditCol >= 0) {
        final debit = (debitCol >= 0 && debitCol < row.length) ? _parseAmount(row[debitCol].toString()) : 0.0;
        final credit = (creditCol >= 0 && creditCol < row.length) ? _parseAmount(row[creditCol].toString()) : 0.0;
        amount = credit > 0 ? credit : -debit.abs();
      }

      if (amount == 0.0) continue;

      results.add(
        ParsedTransactionRow(
          rowIndex: rIdx + headerIndex + 2,
          date: parsedDate,
          rawDescription: descStr,
          merchantName: _cleanMerchantName(descStr),
          amount: amount,
          categoryName: catStr,
          referenceNumber: refStr,
          originalCurrency: currStr.isNotEmpty ? currStr : 'ILS',
        ),
      );
    }

    return results;
  }

  static int _findColumnIndex(List<String> headers, String? explicitName, List<String> fallbackKeywords) {
    if (explicitName != null && explicitName.isNotEmpty) {
      final idx = headers.indexOf(explicitName);
      if (idx >= 0) return idx;
    }

    for (final kw in fallbackKeywords) {
      for (int i = 0; i < headers.length; i++) {
        if (headers[i].toLowerCase().contains(kw.toLowerCase())) {
          return i;
        }
      }
    }
    return -1;
  }

  static DateTime? _tryParseDate(String str, String? preferredFormat) {
    if (str.isEmpty) return null;

    final cleaned = str.replaceAll(RegExp(r'[^0-9\/\-\.]'), '').trim();
    final formats = [
      if (preferredFormat != null) preferredFormat,
      'dd/MM/yyyy',
      'd/M/yyyy',
      'dd-MM-yyyy',
      'yyyy-MM-dd',
      'dd.MM.yyyy',
      'd.M.yyyy',
      'yyyy/MM/dd',
    ];

    for (final fmt in formats) {
      try {
        final parsed = DateFormat(fmt).parseStrict(cleaned);
        if (parsed.year >= 2000 && parsed.year <= 2050) {
          return parsed;
        }
      } catch (_) {}
    }

    // Try standard ISO8601
    return DateTime.tryParse(cleaned);
  }

  static double _parseAmount(String str) {
    if (str.isEmpty) return 0.0;
    final cleaned = str
        .replaceAll('₪', '')
        .replaceAll('\$', '')
        .replaceAll('€', '')
        .replaceAll(',', '')
        .replaceAll(' ', '')
        .trim();

    return double.tryParse(cleaned) ?? 0.0;
  }

  static String _cleanMerchantName(String raw) {
    var cleaned = raw
        .replaceAll(RegExp(r'בע"מ|בעמ|שיווק|סניף.*|בע״מ|\bLTD\b|\bINC\b', caseSensitive: false), '')
        .replaceAll(RegExp(r'[\*\#\-\_\d]{4,}'), '') // remove trailing card digits or codes
        .trim();
    return cleaned.isNotEmpty ? cleaned : raw.trim();
  }
}

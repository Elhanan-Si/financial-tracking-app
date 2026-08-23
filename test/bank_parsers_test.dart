import 'package:financial_tracking/features/import_export/data/parsers/generic_csv_excel_parser.dart';
import 'package:financial_tracking/features/import_export/data/parsers/isracard_parser.dart';
import 'package:financial_tracking/features/import_export/data/parsers/leumi_parser.dart';
import 'package:financial_tracking/features/import_export/data/parsers/one_zero_parser.dart';
import 'package:financial_tracking/features/import_export/data/parsers/pagi_fibi_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TASK-13: Israeli Financial Institution Statement Parsers', () {
    test('Isracard CSV statement is parsed correctly', () {
      const isracardCsv = '''
תאריך רכישה,שם בית עסק,סכום חיוב,ענף,מספר שובר
10/08/2026,שופרסל דיל,450.50,מזון וסופר,994821
12/08/2026,סופר-פארם,120.00,פארם ובריאות,994822
14/08/2026,סונול דלק,250.00,רכב ותחבורה,994823
''';

      final rows = IsracardParser.parseCsv(isracardCsv);
      expect(rows.length, 3);
      expect(rows[0].merchantName, 'שופרסל דיל');
      expect(rows[0].amount, 450.50);
      expect(rows[0].date.year, 2026);
      expect(rows[0].date.month, 8);
      expect(rows[0].date.day, 10);
      expect(rows[0].referenceNumber, '994821');
      expect(rows[0].categoryName, 'מזון וסופר');
    });

    test('Bank Leumi checking statement is parsed correctly with debit/credit', () {
      const leumiCsv = '''
תאריך,תיאור,חובה,זכות,אסמכתא
01/08/2026,משכורת חודשית,,14500.00,1001
05/08/2026,ארנונה עירייה,850.00,,1002
10/08/2026,חברת החשמל,420.00,,1003
''';

      final rows = LeumiParser.parseCsv(leumiCsv);
      expect(rows.length, 3);

      // Income row
      expect(rows[0].amount, 14500.00);
      expect(rows[0].rawDescription, 'משכורת חודשית');
      expect(rows[0].referenceNumber, '1001');

      // Expense row (negative amount)
      expect(rows[1].amount, -850.00);
      expect(rows[1].rawDescription, 'ארנונה עירייה');
      expect(rows[1].referenceNumber, '1002');
    });

    test('Bank PAGI / FIBI statement is parsed correctly', () {
      const pagiCsv = '''
תאריך,תיאור פעולה,חובה,זכות,אסמכתא
02/08/2026,משכורת חודשית,,12000.00,551
08/08/2026,ביטוח הראל,320.00,,552
''';

      final rows = PagiFibiParser.parseCsv(pagiCsv);
      expect(rows.length, 2);
      expect(rows[0].amount, 12000.00);
      expect(rows[1].amount, -320.00);
      expect(rows[1].rawDescription, 'ביטוח הראל');
    });

    test('OneZero digital bank statement is parsed correctly', () {
      const oneZeroCsv = '''
תאריך,בית עסק,סכום,קטגוריה,מספר תנועה
03/08/2026,קפה לנדוור,-65.00,מסעדות,8801
07/08/2026,העברת ביט,+200.00,העברות,8802
''';

      final rows = OneZeroParser.parseCsv(oneZeroCsv);
      expect(rows.length, 2);
      expect(rows[0].amount, -65.00);
      expect(rows[0].merchantName, 'קפה לנדוור');
      expect(rows[1].amount, 200.00);
    });

    test('Generic CSV Parser auto-detects standard Hebrew headers', () {
      const genericCsv = '''
תאריך,תיאור,סכום
15/08/2026,רכישת ספרים,150.00
''';

      final rows = GenericCsvExcelParser.parseCsv(csvContent: genericCsv);
      expect(rows.length, 1);
      expect(rows[0].rawDescription, 'רכישת ספרים');
      expect(rows[0].amount, 150.00);
    });
  });
}

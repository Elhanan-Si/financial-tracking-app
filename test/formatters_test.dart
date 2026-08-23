import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:financial_tracking/core/utils/currency_formatter.dart';
import 'package:financial_tracking/core/utils/date_formatter.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('he_IL', null);
  });

  group('CurrencyFormatter Tests', () {
    test('formats ILS amount with decimals', () {
      final formatted = CurrencyFormatter.formatILS(1250.5);
      expect(formatted.contains('1,250.50'), isTrue);
      expect(formatted.contains('₪'), isTrue);
    });

    test('formats ILS amount without decimals', () {
      final formatted = CurrencyFormatter.formatILS(1250.0, showDecimals: false);
      expect(formatted.contains('1,250'), isTrue);
      expect(formatted.contains('₪'), isTrue);
    });

    test('formats signed ILS for expense', () {
      final formatted = CurrencyFormatter.formatSignedILS(350.0, isExpense: true);
      expect(formatted.startsWith('-'), isTrue);
      expect(formatted.contains('350'), isTrue);
    });

    test('formats compact ILS', () {
      final formatted = CurrencyFormatter.formatCompactILS(50000);
      expect(formatted.contains('50K') || formatted.contains('50'), isTrue);
      expect(formatted.contains('₪'), isTrue);
    });
  });

  group('AppDateFormatter Tests', () {
    test('formats short date in Hebrew format', () {
      final date = DateTime(2026, 8, 21);
      final formatted = AppDateFormatter.formatShortDate(date);
      expect(formatted, equals('21/8/2026'));
    });

    test('creates year-month key', () {
      final date = DateTime(2026, 8, 21);
      final key = AppDateFormatter.toYearMonthKey(date);
      expect(key, equals('2026-08'));
    });
  });
}

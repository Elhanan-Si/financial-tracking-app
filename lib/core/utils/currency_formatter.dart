import 'package:intl/intl.dart';

/// Currency and numeric formatter tailored for Hebrew RTL financial display
class CurrencyFormatter {
  static final NumberFormat _shekelFormat = NumberFormat.currency(
    locale: 'he_IL',
    symbol: '₪',
    decimalDigits: 2,
  );

  static final NumberFormat _shekelIntegerFormat = NumberFormat.currency(
    locale: 'he_IL',
    symbol: '₪',
    decimalDigits: 0,
  );

  static final NumberFormat _plainNumberFormat = NumberFormat.decimalPattern('he_IL');

  /// Formats amount with Shekel symbol (e.g. "₪ 1,234.50")
  static String formatILS(double amount, {bool showDecimals = true}) {
    if (showDecimals) {
      return _shekelFormat.format(amount);
    }
    return _shekelIntegerFormat.format(amount);
  }

  /// Formats amount for specific currency symbol (e.g. "$", "€")
  static String formatCurrency(double amount, String currencyCode, {bool showDecimals = true}) {
    final format = NumberFormat.currency(
      locale: 'he_IL',
      symbol: _getSymbol(currencyCode),
      decimalDigits: showDecimals ? 2 : 0,
    );
    return format.format(amount);
  }

  /// Formats signed amount for transactions (+₪ 500 / -₪ 250)
  static String formatSignedILS(double amount, {bool isExpense = false, bool showDecimals = true}) {
    final absFormatted = formatILS(amount.abs(), showDecimals: showDecimals);
    if (isExpense || amount < 0) {
      return '- $absFormatted';
    } else if (amount > 0) {
      return '+ $absFormatted';
    }
    return absFormatted;
  }

  /// Formats compact numbers (e.g. ₪ 12.5K / ₪ 1.2M)
  static String formatCompactILS(double amount) {
    final compact = NumberFormat.compact(locale: 'he_IL');
    return '${compact.format(amount)} ₪';
  }

  /// Plain percentage format (e.g. "24.5%")
  static String formatPercent(double percent, {int decimalDigits = 1}) {
    final format = NumberFormat.percentPattern('he_IL');
    format.maximumFractionDigits = decimalDigits;
    format.minimumFractionDigits = decimalDigits;
    return format.format(percent / 100);
  }

  /// Plain decimal number
  static String formatNumber(num number) {
    return _plainNumberFormat.format(number);
  }

  static String _getSymbol(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'ILS':
        return '₪';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      default:
        return currencyCode;
    }
  }
}

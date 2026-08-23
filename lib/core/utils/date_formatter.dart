import 'package:intl/intl.dart';

/// Hebrew date and time formatting utilities
class AppDateFormatter {
  static final DateFormat _fullHebrewDate = DateFormat('EEEE, d בMMMM yyyy', 'he_IL');
  static final DateFormat _shortDate = DateFormat('d/M/yyyy', 'he_IL');
  static final DateFormat _mediumDate = DateFormat('d בMMM yyyy', 'he_IL');
  static final DateFormat _monthYear = DateFormat('MMMM yyyy', 'he_IL');
  static final DateFormat _shortMonthYear = DateFormat('MMM yyyy', 'he_IL');
  static final DateFormat _time = DateFormat('HH:mm', 'he_IL');
  static final DateFormat _dateTime = DateFormat('d/M/yyyy HH:mm', 'he_IL');

  /// e.g. "יום ראשון, 15 בינואר 2026"
  static String formatFullDate(DateTime date) => _fullHebrewDate.format(date);

  /// e.g. "15/1/2026"
  static String formatShortDate(DateTime date) => _shortDate.format(date);

  /// e.g. "15 בינואר 2026"
  static String formatMediumDate(DateTime date) => _mediumDate.format(date);

  /// e.g. "ינואר 2026"
  static String formatMonthYear(DateTime date) => _monthYear.format(date);

  /// e.g. "ינו׳ 2026"
  static String formatShortMonthYear(DateTime date) => _shortMonthYear.format(date);

  /// e.g. "14:30"
  static String formatTime(DateTime date) => _time.format(date);

  /// e.g. "15/1/2026 14:30"
  static String formatDateTime(DateTime date) => _dateTime.format(date);

  /// Friendly relative date: "היום", "אתמול", "שלשום", or full date
  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final itemDate = DateTime(date.year, date.month, date.day);
    final diffDays = today.difference(itemDate).inDays;

    if (diffDays == 0) {
      return 'היום, ${_time.format(date)}';
    } else if (diffDays == 1) {
      return 'אתמול, ${_time.format(date)}';
    } else if (diffDays == 2) {
      return 'שלשום, ${_time.format(date)}';
    } else if (diffDays == -1) {
      return 'מחר, ${_time.format(date)}';
    } else {
      return '${_shortDate.format(date)}, ${_time.format(date)}';
    }
  }

  /// Month-year key format for database budgeting: "2026-08"
  static String toYearMonthKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}';
  }
}

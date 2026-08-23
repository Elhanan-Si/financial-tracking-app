/// Responsive Breakpoints matching SDD specification 4.29 & 6.6
abstract class AppBreakpoints {
  /// Compact screens (Mobile phones): width < 600dp
  static const double compact = 600.0;

  /// Medium screens (Tablets / Foldables): 600dp <= width < 1024dp
  static const double medium = 1024.0;

  /// Expanded screens (Desktop / Large Displays): width >= 1024dp
  static const double expanded = 1024.0;
}

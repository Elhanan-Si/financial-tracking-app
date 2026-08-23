class SpendingClassificationModel {
  final double totalIncome;
  final double totalExpenses;
  final double needsAmount;
  final double wantsAmount;
  final double savingsAmount;
  final double fixedAmount;
  final double variableAmount;

  const SpendingClassificationModel({
    required this.totalIncome,
    required this.totalExpenses,
    required this.needsAmount,
    required this.wantsAmount,
    required this.savingsAmount,
    required this.fixedAmount,
    required this.variableAmount,
  });

  // 50/30/20 Percentages of Total Income
  double get needsPercent => totalIncome > 0 ? (needsAmount / totalIncome) * 100 : 0.0;
  double get wantsPercent => totalIncome > 0 ? (wantsAmount / totalIncome) * 100 : 0.0;
  double get savingsPercent => totalIncome > 0 ? (savingsAmount / totalIncome) * 100 : 0.0;

  // Percentage of Total Expenses
  double get fixedExpensePercent =>
      totalExpenses > 0 ? (fixedAmount / totalExpenses) * 100 : 0.0;
  double get variableExpensePercent =>
      totalExpenses > 0 ? (variableAmount / totalExpenses) * 100 : 0.0;

  /// Soft warning if wants exceed 30% of income (or if wants > 40% of total expenses)
  bool get isWantsExceeded => wantsPercent > 30.0 || (totalExpenses > 0 && (wantsAmount / totalExpenses) > 0.40);
}

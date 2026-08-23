class CategoryMover {
  final String categoryId;
  final String categoryName;
  final double currentAmount;
  final double previousAmount;
  final double deltaAmount; // current - previous
  final double deltaPercent; // ((current - previous) / previous) * 100

  const CategoryMover({
    required this.categoryId,
    required this.categoryName,
    required this.currentAmount,
    required this.previousAmount,
    required this.deltaAmount,
    required this.deltaPercent,
  });
}

class ComparativeAnalyticsModel {
  final String currentPeriodLabel;
  final String previousPeriodLabel;
  final double currentTotalExpenses;
  final double previousTotalExpenses;
  final double currentTotalIncome;
  final double previousTotalIncome;
  final List<CategoryMover> topIncreasingCategories; // Spent more
  final List<CategoryMover> topDecreasingCategories; // Saved more

  const ComparativeAnalyticsModel({
    required this.currentPeriodLabel,
    required this.previousPeriodLabel,
    required this.currentTotalExpenses,
    required this.previousTotalExpenses,
    required this.currentTotalIncome,
    required this.previousTotalIncome,
    required this.topIncreasingCategories,
    required this.topDecreasingCategories,
  });

  double get expensesDeltaAmount => currentTotalExpenses - previousTotalExpenses;
  double get expensesDeltaPercent => previousTotalExpenses > 0
      ? ((currentTotalExpenses - previousTotalExpenses) / previousTotalExpenses) * 100
      : 0.0;

  double get incomeDeltaAmount => currentTotalIncome - previousTotalIncome;
  double get incomeDeltaPercent => previousTotalIncome > 0
      ? ((currentTotalIncome - previousTotalIncome) / previousTotalIncome) * 100
      : 0.0;
}

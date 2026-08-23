class SavingsRateModel {
  final double currentMonthIncome;
  final double currentMonthExpenses;
  final double currentMonthSavingsRate; // %
  final double threeMonthMovingAverage; // %
  final double sixMonthMovingAverage; // %
  final double twelveMonthMovingAverage; // %
  final double monthlyBurnRate; // ILS (clean recurring burn)
  final double targetSavingsRatePercent; // User goal %

  const SavingsRateModel({
    required this.currentMonthIncome,
    required this.currentMonthExpenses,
    required this.currentMonthSavingsRate,
    required this.threeMonthMovingAverage,
    required this.sixMonthMovingAverage,
    required this.twelveMonthMovingAverage,
    required this.monthlyBurnRate,
    this.targetSavingsRatePercent = 25.0,
  });

  bool get isTargetAchieved => currentMonthSavingsRate >= targetSavingsRatePercent;
  double get currentMonthNetSavings => currentMonthIncome - currentMonthExpenses;
}

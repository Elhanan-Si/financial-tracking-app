class BenchmarkModel {
  final String id;
  final String ticker;
  final String name; // 'S&P 500 (SPY)', 'מדד ת"א 125', 'NASDAQ 100 (QQQ)'
  final double currentPrice;
  final double returnYtdPercent;
  final double return1YearPercent;
  final double return3YearPercent;
  final DateTime lastUpdated;

  const BenchmarkModel({
    required this.id,
    required this.ticker,
    required this.name,
    required this.currentPrice,
    required this.returnYtdPercent,
    required this.return1YearPercent,
    required this.return3YearPercent,
    required this.lastUpdated,
  });
}

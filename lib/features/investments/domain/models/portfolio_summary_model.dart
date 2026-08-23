import 'holding_model.dart';

class PortfolioSummaryModel {
  final double totalPortfolioValueILS;
  final double totalCostBasisILS;
  final double totalUnrealizedProfitLossILS;
  final double totalUnrealizedProfitLossPercent;
  final double totalRealizedProfitLossILS;
  final double totalDividendsReceivedILS;
  final int totalHoldingsCount;
  final List<HoldingModel> holdings;
  final DateTime lastUpdated;

  const PortfolioSummaryModel({
    required this.totalPortfolioValueILS,
    required this.totalCostBasisILS,
    required this.totalUnrealizedProfitLossILS,
    required this.totalUnrealizedProfitLossPercent,
    required this.totalRealizedProfitLossILS,
    required this.totalDividendsReceivedILS,
    required this.totalHoldingsCount,
    required this.holdings,
    required this.lastUpdated,
  });

  factory PortfolioSummaryModel.empty() {
    return PortfolioSummaryModel(
      totalPortfolioValueILS: 0.0,
      totalCostBasisILS: 0.0,
      totalUnrealizedProfitLossILS: 0.0,
      totalUnrealizedProfitLossPercent: 0.0,
      totalRealizedProfitLossILS: 0.0,
      totalDividendsReceivedILS: 0.0,
      totalHoldingsCount: 0,
      holdings: const [],
      lastUpdated: DateTime.now(),
    );
  }
}

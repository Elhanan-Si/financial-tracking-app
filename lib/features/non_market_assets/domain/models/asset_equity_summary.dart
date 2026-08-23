import 'asset_model.dart';
import 'liability_model.dart';

class AssetEquitySummary {
  final AssetModel asset;
  final List<LiabilityModel> linkedLiabilities;

  const AssetEquitySummary({
    required this.asset,
    required this.linkedLiabilities,
  });

  double get totalDebt {
    return linkedLiabilities.fold(0.0, (sum, item) => sum + item.currentPrincipal);
  }

  /// Home Equity = Asset Estimated Value - Outstanding Liabilities
  double get netEquity => asset.estimatedValue - totalDebt;

  /// Loan-To-Value (LTV) %
  double get ltvPercent => asset.estimatedValue > 0 ? (totalDebt / asset.estimatedValue) * 100 : 0.0;
}

class NonMarketAssetsSummaryModel {
  final double totalPhysicalAssetsValue;
  final double totalLiabilitiesValue;
  final double totalNetEquityValue;
  final double totalMonthlyLoanPayments;
  final List<AssetModel> assets;
  final List<LiabilityModel> liabilities;

  const NonMarketAssetsSummaryModel({
    required this.totalPhysicalAssetsValue,
    required this.totalLiabilitiesValue,
    required this.totalNetEquityValue,
    required this.totalMonthlyLoanPayments,
    required this.assets,
    required this.liabilities,
  });
}

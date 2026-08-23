class NetWorthSummaryModel {
  final double totalLiquidAssets; // Bank accounts, Wallets, Cash
  final double totalInvestments; // Stock & ETF portfolio in ILS
  final double totalPension; // Pension, Study funds, Provident funds
  final double totalRealEstateAndAssets; // Physical real estate, vehicles, valuables
  final double totalShortTermLiabilities; // Credit card balances, short personal loans
  final double totalLongTermLiabilities; // Mortgages, car loans
  final DateTime lastCalculated;

  const NetWorthSummaryModel({
    required this.totalLiquidAssets,
    required this.totalInvestments,
    required this.totalPension,
    required this.totalRealEstateAndAssets,
    required this.totalShortTermLiabilities,
    required this.totalLongTermLiabilities,
    required this.lastCalculated,
  });

  double get totalAssets =>
      totalLiquidAssets + totalInvestments + totalPension + totalRealEstateAndAssets;

  double get totalLiabilities => totalShortTermLiabilities + totalLongTermLiabilities;

  /// Total Net Worth = Total Assets - Total Liabilities
  double get totalNetWorth => totalAssets - totalLiabilities;

  /// Liquid Net Worth (Conservative view excluding illiquid Real Estate and locked Pension)
  double get liquidNetWorth => (totalLiquidAssets + totalInvestments) - totalShortTermLiabilities;

  // Asset Allocation Percentages
  double get liquidPercent => totalAssets > 0 ? (totalLiquidAssets / totalAssets) * 100 : 0.0;
  double get investmentsPercent => totalAssets > 0 ? (totalInvestments / totalAssets) * 100 : 0.0;
  double get pensionPercent => totalAssets > 0 ? (totalPension / totalAssets) * 100 : 0.0;
  double get realEstatePercent =>
      totalAssets > 0 ? (totalRealEstateAndAssets / totalAssets) * 100 : 0.0;

  // Debt-to-Asset Ratio %
  double get debtToAssetRatio => totalAssets > 0 ? (totalLiabilities / totalAssets) * 100 : 0.0;
}

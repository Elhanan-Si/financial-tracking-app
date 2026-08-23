import 'security_model.dart';

class HoldingModel {
  final String id;
  final String securityId;
  final String securityTicker;
  final String securityName;
  final SecurityType securityType;
  final double quantity;
  final double averageCostBasis; // In holding currency (e.g. USD)
  final double currentPrice; // In holding currency
  final String currency; // 'USD', 'ILS', etc.
  final double exchangeRateToIls; // Current FX rate
  final double purchaseExchangeRate; // Average FX rate at purchase
  final DateTime? lastPriceUpdate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const HoldingModel({
    required this.id,
    required this.securityId,
    required this.securityTicker,
    required this.securityName,
    required this.securityType,
    required this.quantity,
    required this.averageCostBasis,
    required this.currentPrice,
    this.currency = 'USD',
    this.exchangeRateToIls = 3.65,
    this.purchaseExchangeRate = 3.65,
    this.lastPriceUpdate,
    required this.createdAt,
    required this.updatedAt,
  });

  // Native Currency Values
  double get totalCostBasis => quantity * averageCostBasis;
  double get currentMarketValue => quantity * currentPrice;
  double get unrealizedProfitLoss => currentMarketValue - totalCostBasis;
  double get unrealizedProfitLossPercent =>
      totalCostBasis > 0 ? (unrealizedProfitLoss / totalCostBasis) * 100 : 0.0;

  // ILS Normalized Values
  double get totalCostBasisILS => totalCostBasis * purchaseExchangeRate;
  double get currentMarketValueILS => currentMarketValue * exchangeRateToIls;
  double get unrealizedProfitLossILS => currentMarketValueILS - totalCostBasisILS;
  double get unrealizedProfitLossILSPercent =>
      totalCostBasisILS > 0 ? (unrealizedProfitLossILS / totalCostBasisILS) * 100 : 0.0;

  // TASK-25: Multi-Currency Breakdown (Asset Price Effect vs Currency Exchange Effect)
  /// Gain resulting from stock price appreciation in native currency, converted to ILS
  double get assetGainILS => unrealizedProfitLoss * exchangeRateToIls;

  /// Gain resulting purely from FX fluctuation (e.g. USD appreciating against ILS)
  double get currencyGainILS => totalCostBasis * (exchangeRateToIls - purchaseExchangeRate);
}

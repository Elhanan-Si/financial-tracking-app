import '../models/benchmark_model.dart';
import '../models/holding_model.dart';
import '../models/investment_transaction_model.dart';
import '../models/portfolio_summary_model.dart';
import '../models/security_model.dart';

abstract class InvestmentsRepository {
  Stream<PortfolioSummaryModel> watchPortfolioSummary();
  Future<PortfolioSummaryModel> getPortfolioSummary();

  Stream<List<HoldingModel>> watchHoldings();
  Future<List<HoldingModel>> getHoldings();
  Future<HoldingModel?> getHoldingById(String holdingId);

  Stream<List<InvestmentTransactionModel>> watchTransactionsForSecurity(String securityId);

  Future<String> recordBuyTransaction({
    required String ticker,
    required String name,
    required SecurityType type,
    required double quantity,
    required double pricePerUnit,
    double fee = 0.0,
    required DateTime date,
    String currency = 'USD',
    double? exchangeRateToIls,
  });

  Future<String> recordSellTransaction({
    required String holdingId,
    required double quantity,
    required double pricePerUnit,
    double fee = 0.0,
    required DateTime date,
    double? exchangeRateToIls,
  });

  Future<String> recordDividend({
    required String securityId,
    required double amount,
    required DateTime date,
    String currency = 'USD',
    double? exchangeRateToIls,
  });

  Future<List<BenchmarkModel>> getBenchmarks();
  Future<void> syncLivePrices();
}

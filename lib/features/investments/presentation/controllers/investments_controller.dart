import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../data/repositories/investments_repository_impl.dart';
import '../../domain/models/benchmark_model.dart';
import '../../domain/models/holding_model.dart';
import '../../domain/models/investment_transaction_model.dart';
import '../../domain/models/portfolio_summary_model.dart';
import '../../domain/models/security_model.dart';
import '../../domain/repositories/investments_repository.dart';

final investmentsRepositoryProvider = Provider<InvestmentsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return InvestmentsRepositoryImpl(db);
});

final portfolioSummaryStreamProvider = StreamProvider<PortfolioSummaryModel>((ref) {
  final repo = ref.watch(investmentsRepositoryProvider);
  return repo.watchPortfolioSummary();
});

final holdingsStreamProvider = StreamProvider<List<HoldingModel>>((ref) {
  final repo = ref.watch(investmentsRepositoryProvider);
  return repo.watchHoldings();
});

final benchmarksProvider = FutureProvider<List<BenchmarkModel>>((ref) {
  final repo = ref.watch(investmentsRepositoryProvider);
  return repo.getBenchmarks();
});

final holdingTransactionsStreamProvider =
    StreamProvider.family<List<InvestmentTransactionModel>, String>((ref, securityId) {
  final repo = ref.watch(investmentsRepositoryProvider);
  return repo.watchTransactionsForSecurity(securityId);
});

final usdToIlsRateStreamProvider = StreamProvider<double>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.exchangeRatesTable)
        ..where((tbl) => tbl.baseCurrency.equals('USD') & tbl.targetCurrency.equals('ILS')))
      .watchSingleOrNull()
      .map((r) => r?.rate ?? 3.65);
});

final investmentsControllerProvider = Provider<InvestmentsController>((ref) {
  final repo = ref.watch(investmentsRepositoryProvider);
  return InvestmentsController(repo);
});

class InvestmentsController {
  final InvestmentsRepository _repo;

  InvestmentsController(this._repo);

  Future<void> recordBuy({
    required String ticker,
    required String name,
    required SecurityType type,
    required double quantity,
    required double pricePerUnit,
    double fee = 0.0,
    required DateTime date,
    String currency = 'USD',
  }) async {
    await _repo.recordBuyTransaction(
      ticker: ticker,
      name: name,
      type: type,
      quantity: quantity,
      pricePerUnit: pricePerUnit,
      fee: fee,
      date: date,
      currency: currency,
    );
  }

  Future<void> recordSell({
    required String holdingId,
    required double quantity,
    required double pricePerUnit,
    double fee = 0.0,
    required DateTime date,
  }) async {
    await _repo.recordSellTransaction(
      holdingId: holdingId,
      quantity: quantity,
      pricePerUnit: pricePerUnit,
      fee: fee,
      date: date,
    );
  }

  Future<void> syncPrices() async {
    await _repo.syncLivePrices();
  }
}

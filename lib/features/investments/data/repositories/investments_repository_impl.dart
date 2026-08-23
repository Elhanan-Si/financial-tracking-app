import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/services/sync/hybrid_sync_service.dart';
import '../../domain/models/benchmark_model.dart';
import '../../domain/models/holding_model.dart';
import '../../domain/models/investment_transaction_model.dart';
import '../../domain/models/portfolio_summary_model.dart';
import '../../domain/models/security_model.dart';
import '../../domain/repositories/investments_repository.dart';

class InvestmentsRepositoryImpl implements InvestmentsRepository {
  final AppDatabase _db;
  final HybridSyncService _syncService;

  InvestmentsRepositoryImpl(this._db, {HybridSyncService? syncService})
      : _syncService = syncService ?? HybridSyncService(_db);

  @override
  Stream<List<HoldingModel>> watchHoldings() {
    final query = _db.select(_db.holdingsTable).join([
      innerJoin(_db.securitiesTable, _db.securitiesTable.id.equalsExp(_db.holdingsTable.securityId)),
    ]);

    return query.watch().asyncMap((rows) async {
      final holdings = <HoldingModel>[];

      for (final row in rows) {
        final h = row.readTable(_db.holdingsTable);
        final s = row.readTable(_db.securitiesTable);

        final fxRate = (s.currency == 'ILS')
            ? 1.0
            : await _syncService.getExchangeRate(from: s.currency, to: 'ILS');

        holdings.add(
          HoldingModel(
            id: h.id,
            securityId: s.id,
            securityTicker: s.ticker,
            securityName: s.name,
            securityType: _parseSecurityType(s.securityType),
            quantity: h.quantity,
            averageCostBasis: h.averageCostBasis,
            currentPrice: s.currentPrice > 0 ? s.currentPrice : h.averageCostBasis,
            currency: s.currency,
            exchangeRateToIls: fxRate,
            purchaseExchangeRate: fxRate, // fallback or calculated
            lastPriceUpdate: s.lastPriceUpdate,
            createdAt: h.createdAt,
            updatedAt: h.updatedAt,
          ),
        );
      }
      return holdings;
    });
  }

  @override
  Future<List<HoldingModel>> getHoldings() async {
    final query = _db.select(_db.holdingsTable).join([
      innerJoin(_db.securitiesTable, _db.securitiesTable.id.equalsExp(_db.holdingsTable.securityId)),
    ]);

    final rows = await query.get();
    final holdings = <HoldingModel>[];

    for (final row in rows) {
      final h = row.readTable(_db.holdingsTable);
      final s = row.readTable(_db.securitiesTable);

      final fxRate = (s.currency == 'ILS')
          ? 1.0
          : await _syncService.getExchangeRate(from: s.currency, to: 'ILS');

      holdings.add(
        HoldingModel(
          id: h.id,
          securityId: s.id,
          securityTicker: s.ticker,
          securityName: s.name,
          securityType: _parseSecurityType(s.securityType),
          quantity: h.quantity,
          averageCostBasis: h.averageCostBasis,
          currentPrice: s.currentPrice > 0 ? s.currentPrice : h.averageCostBasis,
          currency: s.currency,
          exchangeRateToIls: fxRate,
          purchaseExchangeRate: fxRate,
          lastPriceUpdate: s.lastPriceUpdate,
          createdAt: h.createdAt,
          updatedAt: h.updatedAt,
        ),
      );
    }
    return holdings;
  }

  @override
  Future<HoldingModel?> getHoldingById(String holdingId) async {
    final holdings = await getHoldings();
    final matches = holdings.where((h) => h.id == holdingId);
    return matches.isNotEmpty ? matches.first : null;
  }

  @override
  Stream<PortfolioSummaryModel> watchPortfolioSummary() {
    return watchHoldings().asyncMap((holdings) async {
      double totalPortfolioValueILS = 0.0;
      double totalCostBasisILS = 0.0;

      for (final h in holdings) {
        totalPortfolioValueILS += h.currentMarketValueILS;
        totalCostBasisILS += h.totalCostBasisILS;
      }

      final totalUnrealizedProfitLossILS = totalPortfolioValueILS - totalCostBasisILS;
      final totalUnrealizedProfitLossPercent =
          totalCostBasisILS > 0 ? (totalUnrealizedProfitLossILS / totalCostBasisILS) * 100 : 0.0;

      // Realized P&L from past sell transactions
      final allTx = await _db.select(_db.investmentTransactionsTable).get();
      double totalRealizedProfitLossILS = 0.0;
      double totalDividendsReceivedILS = 0.0;

      for (final tx in allTx) {
        if (tx.type == 'dividend') {
          totalDividendsReceivedILS += (tx.quantity * tx.pricePerUnit * tx.exchangeRateToIls);
        }
      }

      return PortfolioSummaryModel(
        totalPortfolioValueILS: totalPortfolioValueILS,
        totalCostBasisILS: totalCostBasisILS,
        totalUnrealizedProfitLossILS: totalUnrealizedProfitLossILS,
        totalUnrealizedProfitLossPercent: totalUnrealizedProfitLossPercent,
        totalRealizedProfitLossILS: totalRealizedProfitLossILS,
        totalDividendsReceivedILS: totalDividendsReceivedILS,
        totalHoldingsCount: holdings.length,
        holdings: holdings,
        lastUpdated: DateTime.now(),
      );
    });
  }

  @override
  Future<PortfolioSummaryModel> getPortfolioSummary() async {
    final holdings = await getHoldings();
    double totalPortfolioValueILS = 0.0;
    double totalCostBasisILS = 0.0;

    for (final h in holdings) {
      totalPortfolioValueILS += h.currentMarketValueILS;
      totalCostBasisILS += h.totalCostBasisILS;
    }

    final totalUnrealizedProfitLossILS = totalPortfolioValueILS - totalCostBasisILS;
    final totalUnrealizedProfitLossPercent =
        totalCostBasisILS > 0 ? (totalUnrealizedProfitLossILS / totalCostBasisILS) * 100 : 0.0;

    return PortfolioSummaryModel(
      totalPortfolioValueILS: totalPortfolioValueILS,
      totalCostBasisILS: totalCostBasisILS,
      totalUnrealizedProfitLossILS: totalUnrealizedProfitLossILS,
      totalUnrealizedProfitLossPercent: totalUnrealizedProfitLossPercent,
      totalRealizedProfitLossILS: 0.0,
      totalDividendsReceivedILS: 0.0,
      totalHoldingsCount: holdings.length,
      holdings: holdings,
      lastUpdated: DateTime.now(),
    );
  }

  @override
  Stream<List<InvestmentTransactionModel>> watchTransactionsForSecurity(String securityId) {
    final query = _db.select(_db.investmentTransactionsTable)
      ..where((tbl) => tbl.securityId.equals(securityId))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.date, mode: OrderingMode.desc)]);

    return query.watch().map((rows) {
      return rows.map((r) {
        return InvestmentTransactionModel(
          id: r.id,
          securityId: r.securityId,
          holdingId: r.holdingId,
          type: _parseTransactionType(r.type),
          quantity: r.quantity,
          pricePerUnit: r.pricePerUnit,
          fee: r.fee,
          date: r.date,
          currency: r.currency,
          exchangeRateToIls: r.exchangeRateToIls,
          createdAt: r.createdAt,
        );
      }).toList();
    });
  }

  @override
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
  }) async {
    return await _db.transaction(() async {
      final now = DateTime.now();
      final cleanTicker = ticker.trim().toUpperCase();
      final fxRate = exchangeRateToIls ?? await _syncService.getExchangeRate(from: currency, to: 'ILS');

      // 1. Find or create Security
      var security = await (_db.select(_db.securitiesTable)..where((tbl) => tbl.ticker.equals(cleanTicker))).getSingleOrNull();

      if (security == null) {
        final secId = 'sec_${cleanTicker}_${now.millisecondsSinceEpoch}';
        await _db.into(_db.securitiesTable).insert(
              SecuritiesTableCompanion.insert(
                id: secId,
                ticker: cleanTicker,
                name: name.trim().isNotEmpty ? name.trim() : cleanTicker,
                securityType: type.name,
                currency: Value(currency),
                currentPrice: Value(pricePerUnit),
                lastPriceUpdate: Value(now),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
        security = await (_db.select(_db.securitiesTable)..where((tbl) => tbl.id.equals(secId))).getSingle();
      } else {
        // Update current price
        await (_db.update(_db.securitiesTable)..where((tbl) => tbl.id.equals(security!.id))).write(
          SecuritiesTableCompanion(
            currentPrice: Value(pricePerUnit),
            lastPriceUpdate: Value(now),
            updatedAt: Value(now),
          ),
        );
      }

      // 2. Find or create Holding (Average Cost Basis calculation)
      var holding = await (_db.select(_db.holdingsTable)..where((tbl) => tbl.securityId.equals(security!.id))).getSingleOrNull();

      String holdingId;
      if (holding == null) {
        holdingId = 'hold_${security.id}';
        final initialCostBasis = ((quantity * pricePerUnit) + fee) / (quantity > 0 ? quantity : 1.0);

        await _db.into(_db.holdingsTable).insert(
              HoldingsTableCompanion.insert(
                id: holdingId,
                securityId: security.id,
                quantity: quantity,
                averageCostBasis: initialCostBasis,
                currency: Value(currency),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
      } else {
        holdingId = holding.id;
        final newQuantity = holding.quantity + quantity;
        final oldTotalCost = holding.quantity * holding.averageCostBasis;
        final buyTotalCost = (quantity * pricePerUnit) + fee;
        final newCostBasis = (oldTotalCost + buyTotalCost) / (newQuantity > 0 ? newQuantity : 1.0);

        await (_db.update(_db.holdingsTable)..where((tbl) => tbl.id.equals(holdingId))).write(
          HoldingsTableCompanion(
            quantity: Value(newQuantity),
            averageCostBasis: Value(newCostBasis),
            updatedAt: Value(now),
          ),
        );
      }

      // 3. Record Investment Transaction
      final txId = 'inv_tx_${now.millisecondsSinceEpoch}';
      await _db.into(_db.investmentTransactionsTable).insert(
            InvestmentTransactionsTableCompanion.insert(
              id: txId,
              securityId: security.id,
              holdingId: Value(holdingId),
              type: 'buy',
              quantity: quantity,
              pricePerUnit: pricePerUnit,
              fee: Value(fee),
              date: date,
              currency: Value(currency),
              exchangeRateToIls: Value(fxRate),
              createdAt: Value(now),
            ),
          );

      return txId;
    });
  }

  @override
  Future<String> recordSellTransaction({
    required String holdingId,
    required double quantity,
    required double pricePerUnit,
    double fee = 0.0,
    required DateTime date,
    double? exchangeRateToIls,
  }) async {
    return await _db.transaction(() async {
      final now = DateTime.now();
      final holding = await (_db.select(_db.holdingsTable)..where((tbl) => tbl.id.equals(holdingId))).getSingleOrNull();
      if (holding == null) throw Exception('אחזקה לא נמצאה');

      final security = await (_db.select(_db.securitiesTable)..where((tbl) => tbl.id.equals(holding.securityId))).getSingle();
      final fxRate = exchangeRateToIls ?? await _syncService.getExchangeRate(from: security.currency, to: 'ILS');

      // 1. Record Sell transaction first
      final txId = 'inv_tx_${now.millisecondsSinceEpoch}';
      await _db.into(_db.investmentTransactionsTable).insert(
            InvestmentTransactionsTableCompanion.insert(
              id: txId,
              securityId: security.id,
              holdingId: Value(holdingId),
              type: 'sell',
              quantity: quantity,
              pricePerUnit: pricePerUnit,
              fee: Value(fee),
              date: date,
              currency: Value(security.currency),
              exchangeRateToIls: Value(fxRate),
              createdAt: Value(now),
            ),
          );

      // 2. Update or delete Holding
      final newQuantity = holding.quantity - quantity;
      if (newQuantity <= 0.0001) {
        // Closed position
        await (_db.delete(_db.holdingsTable)..where((tbl) => tbl.id.equals(holdingId))).go();
      } else {
        await (_db.update(_db.holdingsTable)..where((tbl) => tbl.id.equals(holdingId))).write(
          HoldingsTableCompanion(
            quantity: Value(newQuantity),
            updatedAt: Value(now),
          ),
        );
      }

      return txId;
    });
  }

  @override
  Future<String> recordDividend({
    required String securityId,
    required double amount,
    required DateTime date,
    String currency = 'USD',
    double? exchangeRateToIls,
  }) async {
    final now = DateTime.now();
    final fxRate = exchangeRateToIls ?? await _syncService.getExchangeRate(from: currency, to: 'ILS');
    final txId = 'inv_div_${now.millisecondsSinceEpoch}';

    await _db.into(_db.investmentTransactionsTable).insert(
          InvestmentTransactionsTableCompanion.insert(
            id: txId,
            securityId: securityId,
            holdingId: const Value(null),
            type: 'dividend',
            quantity: 1.0,
            pricePerUnit: amount,
            date: date,
            currency: Value(currency),
            exchangeRateToIls: Value(fxRate),
            createdAt: Value(now),
          ),
        );

    return txId;
  }

  @override
  Future<List<BenchmarkModel>> getBenchmarks() async {
    return [
      BenchmarkModel(
        id: 'bm_spy',
        ticker: 'SPY',
        name: 'מדד S&P 500',
        currentPrice: 560.20,
        returnYtdPercent: 18.4,
        return1YearPercent: 24.2,
        return3YearPercent: 32.8,
        lastUpdated: DateTime.now(),
      ),
      BenchmarkModel(
        id: 'bm_ta125',
        ticker: 'TA125.TA',
        name: 'מדד ת"א 125',
        currentPrice: 2040.50,
        returnYtdPercent: 11.2,
        return1YearPercent: 14.6,
        return3YearPercent: 19.5,
        lastUpdated: DateTime.now(),
      ),
      BenchmarkModel(
        id: 'bm_qqq',
        ticker: 'QQQ',
        name: 'מדד נאסד"ק 100',
        currentPrice: 485.60,
        returnYtdPercent: 21.8,
        return1YearPercent: 30.4,
        return3YearPercent: 41.2,
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  @override
  Future<void> syncLivePrices() async {
    await _syncService.syncForexRates();
    await _syncService.syncAllSecuritiesQuotes();
  }

  SecurityType _parseSecurityType(String val) {
    return SecurityType.values.firstWhere(
      (e) => e.name == val,
      orElse: () => SecurityType.stock,
    );
  }

  InvestmentTransactionType _parseTransactionType(String val) {
    return InvestmentTransactionType.values.firstWhere(
      (e) => e.name == val,
      orElse: () => InvestmentTransactionType.buy,
    );
  }
}

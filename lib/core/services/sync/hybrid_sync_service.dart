import 'package:drift/drift.dart';
import '../../database/app_database.dart';
import 'finnhub_api_service.dart';
import 'forex_api_service.dart';

/// Hybrid Sync Service: Fetches live data from Finnhub & Forex APIs when online, caches to Drift, and falls back to offline DB
class HybridSyncService {
  final AppDatabase _db;
  final FinnhubApiService _api;
  final ForexApiService _forexApi;

  HybridSyncService(this._db, {FinnhubApiService? api, ForexApiService? forexApi})
      : _api = api ?? FinnhubApiService(),
        _forexApi = forexApi ?? ForexApiService();

  /// Refreshes quotes for all tracked securities and caches them in DB
  Future<void> syncAllSecuritiesQuotes() async {
    final securities = await _db.select(_db.securitiesTable).get();
    final now = DateTime.now();

    for (final sec in securities) {
      try {
        final quote = await _api.fetchQuote(sec.ticker);

        // 1. Update SecuritiesTable
        await (_db.update(_db.securitiesTable)..where((tbl) => tbl.id.equals(sec.id))).write(
          SecuritiesTableCompanion(
            currentPrice: Value(quote.currentPrice),
            lastPriceUpdate: Value(quote.timestamp),
            updatedAt: Value(now),
          ),
        );

        // 2. Insert into historical PriceQuotesTable
        await _db.into(_db.priceQuotesTable).insert(
              PriceQuotesTableCompanion.insert(
                id: 'pq_${sec.ticker}_${now.millisecondsSinceEpoch}',
                ticker: sec.ticker,
                price: quote.currentPrice,
                changePercent: Value(quote.changePercent),
                timestamp: Value(quote.timestamp),
                source: const Value('finnhub'),
                createdAt: Value(now),
              ),
            );
      } catch (_) {
        // Offline or API limit: continue with remaining securities
      }
    }
  }

  /// Syncs exchange rates (USD/ILS, EUR/ILS, GBP/ILS) from real-time API and caches them in DB
  Future<void> syncForexRates() async {
    try {
      Map<String, double> rates;
      try {
        rates = await _forexApi.fetchLatestRates(base: 'USD');
      } catch (_) {
        rates = await _api.fetchForexRates(base: 'USD');
      }

      final now = DateTime.now();
      final ilsRate = rates['ILS'];
      if (ilsRate == null || ilsRate <= 0) return;

      final eurRate = rates['EUR'] ?? 0.92;
      final gbpRate = rates['GBP'] ?? 0.78;

      final pairs = [
        {'base': 'USD', 'target': 'ILS', 'rate': ilsRate},
        {'base': 'EUR', 'target': 'ILS', 'rate': (1.0 / (eurRate > 0 ? eurRate : 1.0)) * ilsRate},
        {'base': 'GBP', 'target': 'ILS', 'rate': (1.0 / (gbpRate > 0 ? gbpRate : 1.0)) * ilsRate},
        {'base': 'ILS', 'target': 'ILS', 'rate': 1.0},
      ];

      for (final p in pairs) {
        final base = p['base'] as String;
        final target = p['target'] as String;
        final rate = p['rate'] as double;

        // Upsert latest rate in DB
        final existing = await (_db.select(_db.exchangeRatesTable)
              ..where((tbl) => tbl.baseCurrency.equals(base) & tbl.targetCurrency.equals(target)))
            .getSingleOrNull();

        if (existing != null) {
          await (_db.update(_db.exchangeRatesTable)..where((tbl) => tbl.id.equals(existing.id))).write(
            ExchangeRatesTableCompanion(
              rate: Value(rate),
              timestamp: Value(now),
              source: const Value('finnhub'),
            ),
          );
        } else {
          await _db.into(_db.exchangeRatesTable).insert(
                ExchangeRatesTableCompanion.insert(
                  id: 'fx_${base}_$target',
                  baseCurrency: base,
                  targetCurrency: Value(target),
                  rate: rate,
                  timestamp: Value(now),
                  source: const Value('finnhub'),
                  createdAt: Value(now),
                ),
              );
        }
      }
    } catch (_) {
      // Offline fallback: existing rates in DB will be used
    }
  }

  /// Retrieves the latest known exchange rate from local cache (defaulting to 3.65 if empty)
  Future<double> getExchangeRate({required String from, String to = 'ILS'}) async {
    if (from == to) return 1.0;

    final rateEntry = await (_db.select(_db.exchangeRatesTable)
          ..where((tbl) => tbl.baseCurrency.equals(from) & tbl.targetCurrency.equals(to))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.timestamp, mode: OrderingMode.desc)]))
        .getSingleOrNull();

    if (rateEntry != null) {
      return rateEntry.rate;
    }

    // Standard fallback approximations if DB is fresh
    if (from == 'USD' && to == 'ILS') return 3.65;
    if (from == 'EUR' && to == 'ILS') return 3.95;
    if (from == 'GBP' && to == 'ILS') return 4.65;
    return 1.0;
  }
}

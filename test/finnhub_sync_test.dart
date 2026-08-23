import 'dart:convert';
import 'package:drift/native.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/core/services/sync/finnhub_api_service.dart';
import 'package:financial_tracking/core/services/sync/hybrid_sync_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('TASK-21: Finnhub API & Hybrid Sync Service Tests', () {
    late AppDatabase db;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
    });

    tearDown(() async {
      await db.close();
    });

    test('FinnhubQuote parses JSON response correctly', () {
      final json = {
        'c': 224.23,
        'd': 1.5,
        'dp': 0.67,
        'h': 225.0,
        'l': 222.1,
        'o': 223.0,
        'pc': 222.73,
        't': 1724246400,
      };

      final quote = FinnhubQuote.fromJson(json);
      expect(quote.currentPrice, 224.23);
      expect(quote.previousClose, 222.73);
      expect(quote.changePercent, 0.67);
      expect(quote.highPrice, 225.0);
    });

    test('HybridSyncService syncs forex rates into Drift DB and retrieves rate', () async {
      final mockClient = MockClient((request) async {
        if (request.url.path.contains('forex/rates')) {
          return http.Response(
            jsonEncode({
              'base': 'USD',
              'quote': {'ILS': 3.72, 'EUR': 0.91, 'GBP': 0.77},
            }),
            200,
          );
        }
        return http.Response('Not Found', 404);
      });

      final api = FinnhubApiService(client: mockClient);
      final syncService = HybridSyncService(db, api: api);

      await syncService.syncForexRates();

      final usdIls = await syncService.getExchangeRate(from: 'USD', to: 'ILS');
      expect(usdIls, 3.72);

      final eurIls = await syncService.getExchangeRate(from: 'EUR', to: 'ILS');
      expect(eurIls > 3.0, true);
    });

    test('HybridSyncService returns default approximations when offline and DB is empty', () async {
      final syncService = HybridSyncService(db);
      final usdIls = await syncService.getExchangeRate(from: 'USD', to: 'ILS');
      expect(usdIls, 3.65);
    });
  });
}

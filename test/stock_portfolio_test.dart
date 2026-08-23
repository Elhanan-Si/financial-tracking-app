import 'package:drift/native.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/investments/data/repositories/investments_repository_impl.dart';
import 'package:financial_tracking/features/investments/domain/models/security_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TASK-22: Stock Portfolio & Average Cost Basis Tests', () {
    late AppDatabase db;
    late InvestmentsRepositoryImpl repo;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      repo = InvestmentsRepositoryImpl(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('Multiple Buy orders calculate Average Cost Basis correctly', () async {
      // 1st Buy: 10 units at $100 + $5 fee -> total cost $1005 -> $100.5 per unit
      await repo.recordBuyTransaction(
        ticker: 'AAPL',
        name: 'Apple Inc.',
        type: SecurityType.stock,
        quantity: 10.0,
        pricePerUnit: 100.0,
        fee: 5.0,
        date: DateTime(2026, 8, 1),
        currency: 'USD',
        exchangeRateToIls: 3.65,
      );

      var holdings = await repo.getHoldings();
      expect(holdings.length, 1);
      expect(holdings.first.securityTicker, 'AAPL');
      expect(holdings.first.quantity, 10.0);
      expect(holdings.first.averageCostBasis, 100.5);

      // 2nd Buy: 10 units at $200 + $5 fee -> total cost $2005
      // Total new quantity: 20 units. Total cost: 1005 + 2005 = 3010 -> Average Cost Basis = $150.5
      await repo.recordBuyTransaction(
        ticker: 'AAPL',
        name: 'Apple Inc.',
        type: SecurityType.stock,
        quantity: 10.0,
        pricePerUnit: 200.0,
        fee: 5.0,
        date: DateTime(2026, 8, 15),
        currency: 'USD',
        exchangeRateToIls: 3.65,
      );

      holdings = await repo.getHoldings();
      expect(holdings.length, 1);
      expect(holdings.first.quantity, 20.0);
      expect(holdings.first.averageCostBasis, 150.5);
    });

    test('Selling partial position reduces holding quantity while preserving cost basis', () async {
      await repo.recordBuyTransaction(
        ticker: 'NVDA',
        name: 'NVIDIA Corp.',
        type: SecurityType.stock,
        quantity: 20.0,
        pricePerUnit: 120.0,
        fee: 0.0,
        date: DateTime(2026, 8, 1),
      );

      final holdings = await repo.getHoldings();
      final nvdaHolding = holdings.first;

      // Sell 5 units
      await repo.recordSellTransaction(
        holdingId: nvdaHolding.id,
        quantity: 5.0,
        pricePerUnit: 140.0,
        fee: 2.0,
        date: DateTime(2026, 8, 10),
      );

      final updatedHoldings = await repo.getHoldings();
      expect(updatedHoldings.first.quantity, 15.0);
      expect(updatedHoldings.first.averageCostBasis, 120.0);
    });

    test('Selling full position closes and removes the holding', () async {
      await repo.recordBuyTransaction(
        ticker: 'TSLA',
        name: 'Tesla Inc.',
        type: SecurityType.stock,
        quantity: 5.0,
        pricePerUnit: 220.0,
        fee: 0.0,
        date: DateTime(2026, 8, 1),
      );

      final holdings = await repo.getHoldings();
      await repo.recordSellTransaction(
        holdingId: holdings.first.id,
        quantity: 5.0,
        pricePerUnit: 250.0,
        fee: 0.0,
        date: DateTime(2026, 8, 12),
      );

      final updatedHoldings = await repo.getHoldings();
      expect(updatedHoldings.isEmpty, true);
    });
  });
}

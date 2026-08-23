import 'package:financial_tracking/features/investments/domain/models/holding_model.dart';
import 'package:financial_tracking/features/investments/domain/models/security_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TASK-25: Multi-Currency & Asset vs FX P&L Breakdown Tests', () {
    test('HoldingModel separates stock price gain from currency exchange fluctuation', () {
      // Bought 10 units of AAPL at $100 when USD/ILS was 3.50 -> Cost basis = $1000 ($100/unit), 3,500 ILS
      // Current AAPL price is $120, current USD/ILS is 3.80
      // Current market value = 10 * $120 = $1200 -> in ILS = $1200 * 3.80 = 4,560 ILS
      // Total Unrealized Profit in ILS = 4,560 - 3,500 = 1,060 ILS
      // Asset Gain (in USD converted to ILS) = ($120 - $100) * 10 * 3.80 = $200 * 3.80 = 760 ILS
      // Currency FX Gain = $1000 * (3.80 - 3.50) = $1000 * 0.30 = 300 ILS
      // Total = 760 + 300 = 1,060 ILS!

      final holding = HoldingModel(
        id: 'hold_aapl',
        securityId: 'sec_aapl',
        securityTicker: 'AAPL',
        securityName: 'Apple Inc.',
        securityType: SecurityType.stock,
        quantity: 10.0,
        averageCostBasis: 100.0,
        currentPrice: 120.0,
        currency: 'USD',
        exchangeRateToIls: 3.80,
        purchaseExchangeRate: 3.50,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      expect(holding.totalCostBasis, 1000.0);
      expect(holding.currentMarketValue, 1200.0);
      expect(holding.unrealizedProfitLoss, 200.0); // $200 native gain

      expect(holding.totalCostBasisILS, 3500.0);
      expect(holding.currentMarketValueILS, 4560.0);
      expect(holding.unrealizedProfitLossILS, 1060.0);

      expect((holding.assetGainILS - 760.0).abs() < 0.01, true);
      expect((holding.currencyGainILS - 300.0).abs() < 0.01, true);
      expect(((holding.assetGainILS + holding.currencyGainILS) - holding.unrealizedProfitLossILS).abs() < 0.01, true);
    });
  });
}

import 'package:financial_tracking/features/non_market_assets/data/services/amortization_calculator.dart';
import 'package:financial_tracking/features/non_market_assets/domain/models/asset_equity_summary.dart';
import 'package:financial_tracking/features/non_market_assets/domain/models/asset_model.dart';
import 'package:financial_tracking/features/non_market_assets/domain/models/liability_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TASK-24: Spitzer Amortization & Equity Engine Tests', () {
    test('Spitzer monthly payment is calculated accurately', () {
      // Loan of 1,000,000 ILS at 4.5% annual interest for 25 years (300 months)
      // Standard Spitzer monthly payment: ~5558.32 ILS
      final monthly = AmortizationCalculator.calculateSpitzerMonthlyPayment(
        principal: 1000000.0,
        annualInterestRatePercent: 4.5,
        totalMonths: 300,
      );

      expect((monthly - 5558.32).abs() < 1.0, true);
    });

    test('Spitzer schedule generates full payments and amortizes principal to zero', () {
      final schedule = AmortizationCalculator.generateSpitzerSchedule(
        principal: 100000.0,
        annualInterestRatePercent: 5.0,
        totalMonths: 24,
        startDate: DateTime(2026, 1, 1),
      );

      expect(schedule.length, 24);

      // Verify each payment sums principalComponent + interestComponent == monthlyPayment
      for (final item in schedule) {
        final sum = item.principalComponent + item.interestComponent;
        expect((sum - item.monthlyPayment).abs() < 0.01, true);
      }

      // Final payment leaves 0.0 remaining balance
      expect(schedule.last.remainingBalance, 0.0);
    });

    test('AssetEquitySummary calculates Net Home Equity and LTV accurately', () {
      final apartment = AssetModel(
        id: 'apt_1',
        name: 'דירה בתל אביב',
        assetType: AssetType.realEstate,
        estimatedValue: 3000000.0,
        lastValuationDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final mortgagePrime = LiabilityModel(
        id: 'liab_1',
        assetId: 'apt_1',
        name: 'משכנתה פריים',
        liabilityType: LiabilityType.mortgage,
        initialPrincipal: 600000.0,
        currentPrincipal: 500000.0,
        interestRate: 5.0,
        monthlyPayment: 3500.0,
        remainingPayments: 200,
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final mortgageFixed = LiabilityModel(
        id: 'liab_2',
        assetId: 'apt_1',
        name: 'משכנתה קבועה',
        liabilityType: LiabilityType.mortgage,
        initialPrincipal: 600000.0,
        currentPrincipal: 500000.0,
        interestRate: 4.0,
        monthlyPayment: 3200.0,
        remainingPayments: 200,
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final equitySummary = AssetEquitySummary(
        asset: apartment,
        linkedLiabilities: [mortgagePrime, mortgageFixed],
      );

      // Total debt = 500,000 + 500,000 = 1,000,000
      expect(equitySummary.totalDebt, 1000000.0);
      // Net Equity = 3,000,000 - 1,000,000 = 2,000,000
      expect(equitySummary.netEquity, 2000000.0);
      // LTV = 1,000,000 / 3,000,000 = 33.33%
      expect((equitySummary.ltvPercent - 33.33).abs() < 0.1, true);
    });
  });
}

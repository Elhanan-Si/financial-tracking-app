import 'package:drift/native.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracking/features/investments/data/repositories/investments_repository_impl.dart';
import 'package:financial_tracking/features/investments/domain/models/security_model.dart';
import 'package:financial_tracking/features/net_worth/data/repositories/net_worth_repository_impl.dart';
import 'package:financial_tracking/features/non_market_assets/data/repositories/non_market_assets_repository_impl.dart';
import 'package:financial_tracking/features/non_market_assets/domain/models/asset_model.dart';
import 'package:financial_tracking/features/non_market_assets/domain/models/liability_model.dart';
import 'package:financial_tracking/features/pension_assets/data/repositories/pension_repository_impl.dart';
import 'package:financial_tracking/features/pension_assets/domain/models/pension_asset_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TASK-26: Net Worth Engine & Snapshots Tests', () {
    late AppDatabase db;
    late AccountsRepositoryImpl accountsRepo;
    late InvestmentsRepositoryImpl investmentsRepo;
    late PensionRepositoryImpl pensionRepo;
    late NonMarketAssetsRepositoryImpl nonMarketRepo;
    late NetWorthRepositoryImpl netWorthRepo;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      accountsRepo = AccountsRepositoryImpl(db);
      investmentsRepo = InvestmentsRepositoryImpl(db);
      pensionRepo = PensionRepositoryImpl(db);
      nonMarketRepo = NonMarketAssetsRepositoryImpl(db);
      netWorthRepo = NetWorthRepositoryImpl(
        db,
        accountsRepo,
        investmentsRepo,
        pensionRepo,
        nonMarketRepo,
      );
    });

    tearDown(() async {
      await db.close();
    });

    test('Net Worth calculates Total and Liquid Net Worth accurately across all asset classes', () async {
      // 1. Bank Account (Liquid): 50,000 ILS
      await accountsRepo.createAccount(
        AccountModel(
          id: 'acc_bank',
          name: 'עו"ש פועלים',
          type: AccountType.bank,
          currency: 'ILS',
          initialBalance: 50000.0,
          colorValue: 0xFF3B82F6,
          iconName: 'bank',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // 2. Credit Card (Short-term debt): -5,000 ILS
      await accountsRepo.createAccount(
        AccountModel(
          id: 'acc_cc',
          name: 'ישראכרט',
          type: AccountType.creditCard,
          currency: 'ILS',
          initialBalance: -5000.0,
          colorValue: 0xFFEF4444,
          iconName: 'creditCard',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // 3. Stock Portfolio: 100 units AAPL at $100 -> $10,000 -> 36,500 ILS
      await investmentsRepo.recordBuyTransaction(
        ticker: 'AAPL',
        name: 'Apple Inc.',
        type: SecurityType.stock,
        quantity: 100.0,
        pricePerUnit: 100.0,
        fee: 0.0,
        date: DateTime.now(),
        currency: 'USD',
        exchangeRateToIls: 3.65,
      );

      // 4. Pension Assets: 200,000 ILS
      await pensionRepo.createPensionAsset(
        PensionAssetModel(
          id: 'pens_1',
          name: 'קרן פנסיה',
          type: PensionAssetType.pension,
          providerName: 'הראל',
          currentBalance: 200000.0,
          lastUpdatedDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // 5. Real Estate: 2,000,000 ILS & Mortgage: 800,000 ILS
      final aptId = await nonMarketRepo.createAsset(
        AssetModel(
          id: 'apt_1',
          name: 'דירה',
          assetType: AssetType.realEstate,
          estimatedValue: 2000000.0,
          lastValuationDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      await nonMarketRepo.createLiability(
        LiabilityModel(
          id: 'liab_1',
          assetId: aptId,
          name: 'משכנתה',
          liabilityType: LiabilityType.mortgage,
          initialPrincipal: 800000.0,
          currentPrincipal: 800000.0,
          interestRate: 4.5,
          monthlyPayment: 4500.0,
          remainingPayments: 240,
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final summary = await netWorthRepo.getNetWorthSummary();

      // Liquid Assets = 50,000
      expect(summary.totalLiquidAssets, 50000.0);
      // Investments = 36,500
      expect(summary.totalInvestments, 36500.0);
      // Pension = 200,000
      expect(summary.totalPension, 200000.0);
      // Real Estate = 2,000,000
      expect(summary.totalRealEstateAndAssets, 2000000.0);
      // Total Assets = 50,000 + 36,500 + 200,000 + 2,000,000 = 2,286,500
      expect(summary.totalAssets, 2286500.0);

      // Liabilities: Short-term = 5,000 (credit card), Long-term = 800,000 (mortgage)
      expect(summary.totalShortTermLiabilities, 5000.0);
      expect(summary.totalLongTermLiabilities, 800000.0);
      expect(summary.totalLiabilities, 805000.0);

      // Total Net Worth = 2,286,500 - 805,000 = 1,481,500 ILS
      expect(summary.totalNetWorth, 1481500.0);

      // Liquid Net Worth (Excluding Real Estate and Pension) = (50,000 + 36,500) - 5,000 = 81,500 ILS
      expect(summary.liquidNetWorth, 81500.0);
    });

    test('Recording monthly snapshot saves record in NetWorthSnapshotsTable', () async {
      await accountsRepo.createAccount(
        AccountModel(
          id: 'acc_snap',
          name: 'עו"ש',
          type: AccountType.bank,
          currency: 'ILS',
          initialBalance: 100000.0,
          colorValue: 0xFF3B82F6,
          iconName: 'bank',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final snapshotId = await netWorthRepo.recordSnapshot(date: DateTime(2026, 8, 1));
      expect(snapshotId.isNotEmpty, true);

      final snapshots = await netWorthRepo.getHistoricalSnapshots();
      expect(snapshots.length, 1);
      expect(snapshots.first.netWorth, 100000.0);
      expect(snapshots.first.totalLiquidAssets, 100000.0);
    });
  });
}

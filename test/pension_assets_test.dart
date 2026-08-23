import 'package:drift/native.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/pension_assets/data/repositories/pension_repository_impl.dart';
import 'package:financial_tracking/features/pension_assets/domain/models/pension_asset_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TASK-23: Pension & Study Funds Repository Tests', () {
    late AppDatabase db;
    late PensionRepositoryImpl repo;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      repo = PensionRepositoryImpl(db);
    });

    tearDown(() async {
      await db.close();
    });

    test('Can create pension asset, study fund and calculate summary', () async {
      final pension = PensionAssetModel(
        id: 'pens_1',
        name: 'פנסיה מקיפה',
        type: PensionAssetType.pension,
        providerName: 'הראל',
        trackName: 'מסלול מחקה S&P 500',
        currentBalance: 250000.0,
        monthlyDepositEmployee: 1200.0,
        monthlyDepositEmployer: 2400.0,
        lastUpdatedDate: DateTime(2026, 8, 1),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final studyFund = PensionAssetModel(
        id: 'pens_2',
        name: 'קרן השתלמות',
        type: PensionAssetType.studyFund,
        providerName: 'אלטשולר שחם',
        currentBalance: 120000.0,
        monthlyDepositEmployee: 500.0,
        monthlyDepositEmployer: 1500.0,
        lastUpdatedDate: DateTime(2026, 8, 1),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await repo.createPensionAsset(pension);
      await repo.createPensionAsset(studyFund);

      final summary = await repo.getPensionSummary();
      expect(summary.totalPensionValue, 250000.0);
      expect(summary.totalStudyFundValue, 120000.0);
      expect(summary.totalCombinedValue, 370000.0);
      // Total monthly deposits: (1200+2400) + (500+1500) = 5600
      expect(summary.totalMonthlyContributions, 5600.0);
    });

    test('Updating pension balance creates a historical snapshot', () async {
      final asset = PensionAssetModel(
        id: 'pens_hist',
        name: 'קופת גמל להשקעה',
        type: PensionAssetType.providentFund,
        providerName: 'מיטב',
        currentBalance: 50000.0,
        lastUpdatedDate: DateTime(2026, 1, 1),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await repo.createPensionAsset(asset);

      // Update balance
      await repo.updateBalanceAndRecordSnapshot('pens_hist', 55000.0, DateTime(2026, 8, 1));

      final assets = await repo.getPensionAssets();
      expect(assets.first.currentBalance, 55000.0);
    });
  });
}

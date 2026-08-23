import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/models/amortization_schedule_model.dart';
import '../../domain/models/asset_equity_summary.dart';
import '../../domain/models/asset_model.dart';
import '../../domain/models/liability_model.dart';
import '../../domain/repositories/non_market_assets_repository.dart';
import '../services/amortization_calculator.dart';

class NonMarketAssetsRepositoryImpl implements NonMarketAssetsRepository {
  final AppDatabase _db;

  NonMarketAssetsRepositoryImpl(this._db);

  @override
  Stream<List<AssetModel>> watchAssets() {
    final query = _db.select(_db.assetsTable)
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)]);

    return query.watch().map((rows) => rows.map(_mapAssetEntryToModel).toList());
  }

  @override
  Future<List<AssetModel>> getAssets() async {
    final rows = await (_db.select(_db.assetsTable)
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)]))
        .get();
    return rows.map(_mapAssetEntryToModel).toList();
  }

  @override
  Stream<List<LiabilityModel>> watchLiabilities() {
    final query = _db.select(_db.liabilitiesTable)
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)]);

    return query.watch().map((rows) => rows.map(_mapLiabilityEntryToModel).toList());
  }

  @override
  Future<List<LiabilityModel>> getLiabilities() async {
    final rows = await (_db.select(_db.liabilitiesTable)
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)]))
        .get();
    return rows.map(_mapLiabilityEntryToModel).toList();
  }

  @override
  Stream<NonMarketAssetsSummaryModel> watchSummary() {
    return watchAssets().asyncMap((assets) async {
      final liabilities = await getLiabilities();

      final totalAssets = assets.fold(0.0, (sum, a) => sum + a.estimatedValue);
      final totalLiabilities = liabilities.fold(0.0, (sum, l) => sum + l.currentPrincipal);
      final totalMonthlyPayments = liabilities.fold(0.0, (sum, l) => sum + l.monthlyPayment);

      return NonMarketAssetsSummaryModel(
        totalPhysicalAssetsValue: totalAssets,
        totalLiabilitiesValue: totalLiabilities,
        totalNetEquityValue: totalAssets - totalLiabilities,
        totalMonthlyLoanPayments: totalMonthlyPayments,
        assets: assets,
        liabilities: liabilities,
      );
    });
  }

  @override
  Future<NonMarketAssetsSummaryModel> getSummary() async {
    final assets = await getAssets();
    final liabilities = await getLiabilities();

    final totalAssets = assets.fold(0.0, (sum, a) => sum + a.estimatedValue);
    final totalLiabilities = liabilities.fold(0.0, (sum, l) => sum + l.currentPrincipal);
    final totalMonthlyPayments = liabilities.fold(0.0, (sum, l) => sum + l.monthlyPayment);

    return NonMarketAssetsSummaryModel(
      totalPhysicalAssetsValue: totalAssets,
      totalLiabilitiesValue: totalLiabilities,
      totalNetEquityValue: totalAssets - totalLiabilities,
      totalMonthlyLoanPayments: totalMonthlyPayments,
      assets: assets,
      liabilities: liabilities,
    );
  }

  @override
  Future<List<AssetEquitySummary>> getAssetsWithEquities() async {
    final assets = await getAssets();
    final liabilities = await getLiabilities();

    return assets.map((asset) {
      final linked = liabilities.where((l) => l.assetId == asset.id).toList();
      return AssetEquitySummary(asset: asset, linkedLiabilities: linked);
    }).toList();
  }

  @override
  List<AmortizationScheduleItem> getAmortizationScheduleForLiability(LiabilityModel liability) {
    return AmortizationCalculator.generateSpitzerSchedule(
      principal: liability.initialPrincipal,
      annualInterestRatePercent: liability.interestRate,
      totalMonths: liability.remainingPayments > 0 ? liability.remainingPayments : 12,
      startDate: liability.startDate,
    );
  }

  @override
  Future<String> createAsset(AssetModel asset) async {
    final id = asset.id.isNotEmpty ? asset.id : 'asset_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();

    await _db.into(_db.assetsTable).insert(
          AssetsTableCompanion.insert(
            id: id,
            name: asset.name,
            assetType: asset.assetType.dbValue,
            estimatedValue: asset.estimatedValue,
            lastValuationDate: Value(asset.lastValuationDate),
            note: Value(asset.note),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );

    return id;
  }

  @override
  Future<void> updateAsset(AssetModel asset) async {
    final now = DateTime.now();

    await (_db.update(_db.assetsTable)..where((tbl) => tbl.id.equals(asset.id))).write(
      AssetsTableCompanion(
        name: Value(asset.name),
        assetType: Value(asset.assetType.dbValue),
        estimatedValue: Value(asset.estimatedValue),
        lastValuationDate: Value(asset.lastValuationDate),
        note: Value(asset.note),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<void> deleteAsset(String assetId) async {
    await (_db.delete(_db.assetsTable)..where((tbl) => tbl.id.equals(assetId))).go();
  }

  @override
  Future<String> createLiability(LiabilityModel liability) async {
    final id = liability.id.isNotEmpty ? liability.id : 'liab_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();

    await _db.into(_db.liabilitiesTable).insert(
          LiabilitiesTableCompanion.insert(
            id: id,
            assetId: Value(liability.assetId),
            name: liability.name,
            liabilityType: liability.liabilityType.dbValue,
            initialPrincipal: liability.initialPrincipal,
            currentPrincipal: liability.currentPrincipal,
            interestRate: liability.interestRate,
            monthlyPayment: liability.monthlyPayment,
            remainingPayments: liability.remainingPayments,
            startDate: liability.startDate,
            endDate: liability.endDate,
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );

    return id;
  }

  @override
  Future<void> updateLiability(LiabilityModel liability) async {
    final now = DateTime.now();

    await (_db.update(_db.liabilitiesTable)..where((tbl) => tbl.id.equals(liability.id))).write(
      LiabilitiesTableCompanion(
        assetId: Value(liability.assetId),
        name: Value(liability.name),
        liabilityType: Value(liability.liabilityType.dbValue),
        initialPrincipal: Value(liability.initialPrincipal),
        currentPrincipal: Value(liability.currentPrincipal),
        interestRate: Value(liability.interestRate),
        monthlyPayment: Value(liability.monthlyPayment),
        remainingPayments: Value(liability.remainingPayments),
        startDate: Value(liability.startDate),
        endDate: Value(liability.endDate),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<void> deleteLiability(String liabilityId) async {
    await (_db.delete(_db.liabilitiesTable)..where((tbl) => tbl.id.equals(liabilityId))).go();
  }

  AssetModel _mapAssetEntryToModel(AssetEntry e) {
    return AssetModel(
      id: e.id,
      name: e.name,
      assetType: AssetType.fromDb(e.assetType),
      estimatedValue: e.estimatedValue,
      lastValuationDate: e.lastValuationDate,
      note: e.note,
      createdAt: e.createdAt,
      updatedAt: e.updatedAt,
    );
  }

  LiabilityModel _mapLiabilityEntryToModel(LiabilityEntry e) {
    return LiabilityModel(
      id: e.id,
      assetId: e.assetId,
      name: e.name,
      liabilityType: LiabilityType.fromDb(e.liabilityType),
      initialPrincipal: e.initialPrincipal,
      currentPrincipal: e.currentPrincipal,
      interestRate: e.interestRate,
      monthlyPayment: e.monthlyPayment,
      remainingPayments: e.remainingPayments,
      startDate: e.startDate,
      endDate: e.endDate,
      createdAt: e.createdAt,
      updatedAt: e.updatedAt,
    );
  }
}

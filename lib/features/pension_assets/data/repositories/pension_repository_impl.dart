import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/models/pension_asset_model.dart';
import '../../domain/models/pension_snapshot_model.dart';
import '../../domain/models/pension_summary_model.dart';
import '../../domain/repositories/pension_repository.dart';

class PensionRepositoryImpl implements PensionRepository {
  final AppDatabase _db;

  PensionRepositoryImpl(this._db);

  @override
  Stream<List<PensionAssetModel>> watchPensionAssets() {
    final query = _db.select(_db.pensionAssetsTable)
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)]);

    return query.watch().map((rows) => rows.map(_mapEntryToModel).toList());
  }

  @override
  Future<List<PensionAssetModel>> getPensionAssets() async {
    final rows = await (_db.select(_db.pensionAssetsTable)
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)]))
        .get();
    return rows.map(_mapEntryToModel).toList();
  }

  @override
  Stream<PensionSummaryModel> watchPensionSummary() {
    return watchPensionAssets().map((assets) => PensionSummaryModel.fromAssets(assets));
  }

  @override
  Future<PensionSummaryModel> getPensionSummary() async {
    final assets = await getPensionAssets();
    return PensionSummaryModel.fromAssets(assets);
  }

  @override
  Stream<List<PensionSnapshotModel>> watchSnapshots(String pensionAssetId) {
    final query = _db.select(_db.pensionSnapshotsTable)
      ..where((tbl) => tbl.pensionAssetId.equals(pensionAssetId))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.snapshotDate, mode: OrderingMode.desc)]);

    return query.watch().map((rows) {
      return rows.map((r) {
        return PensionSnapshotModel(
          id: r.id,
          pensionAssetId: r.pensionAssetId,
          balance: r.balance,
          snapshotDate: r.snapshotDate,
          createdAt: r.createdAt,
        );
      }).toList();
    });
  }

  @override
  Future<String> createPensionAsset(PensionAssetModel asset) async {
    final id = asset.id.isNotEmpty ? asset.id : 'pens_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();

    await _db.into(_db.pensionAssetsTable).insert(
          PensionAssetsTableCompanion.insert(
            id: id,
            name: asset.name,
            type: asset.type.dbValue,
            providerName: asset.providerName,
            policyNumber: Value(asset.policyNumber),
            trackName: Value(asset.trackName),
            currentBalance: Value(asset.currentBalance),
            monthlyDepositEmployee: Value(asset.monthlyDepositEmployee),
            monthlyDepositEmployer: Value(asset.monthlyDepositEmployer),
            lastUpdatedDate: Value(asset.lastUpdatedDate),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );

    // Record initial snapshot
    if (asset.currentBalance > 0) {
      await _db.into(_db.pensionSnapshotsTable).insert(
            PensionSnapshotsTableCompanion.insert(
              id: 'psnap_${now.millisecondsSinceEpoch}',
              pensionAssetId: id,
              balance: asset.currentBalance,
              snapshotDate: asset.lastUpdatedDate,
              createdAt: Value(now),
            ),
          );
    }

    return id;
  }

  @override
  Future<void> updatePensionAsset(PensionAssetModel asset) async {
    final now = DateTime.now();

    await (_db.update(_db.pensionAssetsTable)..where((tbl) => tbl.id.equals(asset.id))).write(
      PensionAssetsTableCompanion(
        name: Value(asset.name),
        type: Value(asset.type.dbValue),
        providerName: Value(asset.providerName),
        policyNumber: Value(asset.policyNumber),
        trackName: Value(asset.trackName),
        currentBalance: Value(asset.currentBalance),
        monthlyDepositEmployee: Value(asset.monthlyDepositEmployee),
        monthlyDepositEmployer: Value(asset.monthlyDepositEmployer),
        lastUpdatedDate: Value(asset.lastUpdatedDate),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<void> updateBalanceAndRecordSnapshot(String assetId, double newBalance, DateTime date) async {
    final now = DateTime.now();

    await (_db.update(_db.pensionAssetsTable)..where((tbl) => tbl.id.equals(assetId))).write(
      PensionAssetsTableCompanion(
        currentBalance: Value(newBalance),
        lastUpdatedDate: Value(date),
        updatedAt: Value(now),
      ),
    );

    await _db.into(_db.pensionSnapshotsTable).insert(
          PensionSnapshotsTableCompanion.insert(
            id: 'psnap_${now.millisecondsSinceEpoch}',
            pensionAssetId: assetId,
            balance: newBalance,
            snapshotDate: date,
            createdAt: Value(now),
          ),
        );
  }

  @override
  Future<void> deletePensionAsset(String assetId) async {
    await (_db.delete(_db.pensionAssetsTable)..where((tbl) => tbl.id.equals(assetId))).go();
  }

  PensionAssetModel _mapEntryToModel(PensionAssetEntry e) {
    return PensionAssetModel(
      id: e.id,
      name: e.name,
      type: PensionAssetType.fromDb(e.type),
      providerName: e.providerName,
      policyNumber: e.policyNumber,
      trackName: e.trackName,
      currentBalance: e.currentBalance,
      monthlyDepositEmployee: e.monthlyDepositEmployee,
      monthlyDepositEmployer: e.monthlyDepositEmployer,
      lastUpdatedDate: e.lastUpdatedDate,
      createdAt: e.createdAt,
      updatedAt: e.updatedAt,
    );
  }
}

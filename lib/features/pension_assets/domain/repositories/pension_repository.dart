import '../models/pension_asset_model.dart';
import '../models/pension_snapshot_model.dart';
import '../models/pension_summary_model.dart';

abstract class PensionRepository {
  Stream<PensionSummaryModel> watchPensionSummary();
  Future<PensionSummaryModel> getPensionSummary();

  Stream<List<PensionAssetModel>> watchPensionAssets();
  Future<List<PensionAssetModel>> getPensionAssets();

  Stream<List<PensionSnapshotModel>> watchSnapshots(String pensionAssetId);

  Future<String> createPensionAsset(PensionAssetModel asset);
  Future<void> updatePensionAsset(PensionAssetModel asset);
  Future<void> updateBalanceAndRecordSnapshot(String assetId, double newBalance, DateTime date);
  Future<void> deletePensionAsset(String assetId);
}

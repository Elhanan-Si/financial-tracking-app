import '../models/amortization_schedule_model.dart';
import '../models/asset_equity_summary.dart';
import '../models/asset_model.dart';
import '../models/liability_model.dart';

abstract class NonMarketAssetsRepository {
  Stream<NonMarketAssetsSummaryModel> watchSummary();
  Future<NonMarketAssetsSummaryModel> getSummary();

  Stream<List<AssetModel>> watchAssets();
  Future<List<AssetModel>> getAssets();
  Future<String> createAsset(AssetModel asset);
  Future<void> updateAsset(AssetModel asset);
  Future<void> deleteAsset(String assetId);

  Stream<List<LiabilityModel>> watchLiabilities();
  Future<List<LiabilityModel>> getLiabilities();
  Future<String> createLiability(LiabilityModel liability);
  Future<void> updateLiability(LiabilityModel liability);
  Future<void> deleteLiability(String liabilityId);

  Future<List<AssetEquitySummary>> getAssetsWithEquities();
  List<AmortizationScheduleItem> getAmortizationScheduleForLiability(LiabilityModel liability);
}

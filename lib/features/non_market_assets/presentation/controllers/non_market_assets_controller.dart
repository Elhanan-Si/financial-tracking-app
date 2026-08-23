import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../data/repositories/non_market_assets_repository_impl.dart';
import '../../domain/models/amortization_schedule_model.dart';
import '../../domain/models/asset_equity_summary.dart';
import '../../domain/models/asset_model.dart';
import '../../domain/models/liability_model.dart';
import '../../domain/repositories/non_market_assets_repository.dart';

final nonMarketAssetsRepositoryProvider = Provider<NonMarketAssetsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return NonMarketAssetsRepositoryImpl(db);
});

final nonMarketSummaryStreamProvider = StreamProvider<NonMarketAssetsSummaryModel>((ref) {
  final repo = ref.watch(nonMarketAssetsRepositoryProvider);
  return repo.watchSummary();
});

final assetsStreamProvider = StreamProvider<List<AssetModel>>((ref) {
  final repo = ref.watch(nonMarketAssetsRepositoryProvider);
  return repo.watchAssets();
});

final liabilitiesStreamProvider = StreamProvider<List<LiabilityModel>>((ref) {
  final repo = ref.watch(nonMarketAssetsRepositoryProvider);
  return repo.watchLiabilities();
});

final assetEquitiesFutureProvider = FutureProvider<List<AssetEquitySummary>>((ref) {
  final repo = ref.watch(nonMarketAssetsRepositoryProvider);
  return repo.getAssetsWithEquities();
});

final nonMarketAssetsControllerProvider = Provider<NonMarketAssetsController>((ref) {
  final repo = ref.watch(nonMarketAssetsRepositoryProvider);
  return NonMarketAssetsController(repo);
});

class NonMarketAssetsController {
  final NonMarketAssetsRepository _repo;

  NonMarketAssetsController(this._repo);

  Future<void> createAsset(AssetModel asset) async {
    await _repo.createAsset(asset);
  }

  Future<void> updateAsset(AssetModel asset) async {
    await _repo.updateAsset(asset);
  }

  Future<void> deleteAsset(String assetId) async {
    await _repo.deleteAsset(assetId);
  }

  Future<void> createLiability(LiabilityModel liability) async {
    await _repo.createLiability(liability);
  }

  Future<void> updateLiability(LiabilityModel liability) async {
    await _repo.updateLiability(liability);
  }

  Future<void> deleteLiability(String liabilityId) async {
    await _repo.deleteLiability(liabilityId);
  }

  List<AmortizationScheduleItem> getAmortizationSchedule(LiabilityModel liability) {
    return _repo.getAmortizationScheduleForLiability(liability);
  }
}

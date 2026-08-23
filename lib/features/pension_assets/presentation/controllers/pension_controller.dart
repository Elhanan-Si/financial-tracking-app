import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../data/repositories/pension_repository_impl.dart';
import '../../domain/models/pension_asset_model.dart';
import '../../domain/models/pension_snapshot_model.dart';
import '../../domain/models/pension_summary_model.dart';
import '../../domain/repositories/pension_repository.dart';

final pensionRepositoryProvider = Provider<PensionRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return PensionRepositoryImpl(db);
});

final pensionSummaryStreamProvider = StreamProvider<PensionSummaryModel>((ref) {
  final repo = ref.watch(pensionRepositoryProvider);
  return repo.watchPensionSummary();
});

final pensionAssetsStreamProvider = StreamProvider<List<PensionAssetModel>>((ref) {
  final repo = ref.watch(pensionRepositoryProvider);
  return repo.watchPensionAssets();
});

final pensionSnapshotsStreamProvider =
    StreamProvider.family<List<PensionSnapshotModel>, String>((ref, assetId) {
  final repo = ref.watch(pensionRepositoryProvider);
  return repo.watchSnapshots(assetId);
});

final pensionControllerProvider = Provider<PensionController>((ref) {
  final repo = ref.watch(pensionRepositoryProvider);
  return PensionController(repo);
});

class PensionController {
  final PensionRepository _repo;

  PensionController(this._repo);

  Future<void> createAsset(PensionAssetModel asset) async {
    await _repo.createPensionAsset(asset);
  }

  Future<void> updateAsset(PensionAssetModel asset) async {
    await _repo.updatePensionAsset(asset);
  }

  Future<void> updateBalance(String assetId, double newBalance, DateTime date) async {
    await _repo.updateBalanceAndRecordSnapshot(assetId, newBalance, date);
  }

  Future<void> deleteAsset(String assetId) async {
    await _repo.deletePensionAsset(assetId);
  }
}

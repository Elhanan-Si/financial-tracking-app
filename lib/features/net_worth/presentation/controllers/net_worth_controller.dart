import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../accounts/presentation/controllers/accounts_controller.dart';
import '../../../investments/presentation/controllers/investments_controller.dart';
import '../../../non_market_assets/presentation/controllers/non_market_assets_controller.dart';
import '../../../pension_assets/presentation/controllers/pension_controller.dart';
import '../../data/repositories/net_worth_repository_impl.dart';
import '../../domain/models/net_worth_snapshot_model.dart';
import '../../domain/models/net_worth_summary_model.dart';
import '../../domain/repositories/net_worth_repository.dart';

final netWorthRepositoryProvider = Provider<NetWorthRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final accountsRepo = ref.watch(accountsRepositoryProvider);
  final investmentsRepo = ref.watch(investmentsRepositoryProvider);
  final pensionRepo = ref.watch(pensionRepositoryProvider);
  final nonMarketRepo = ref.watch(nonMarketAssetsRepositoryProvider);

  return NetWorthRepositoryImpl(
    db,
    accountsRepo,
    investmentsRepo,
    pensionRepo,
    nonMarketRepo,
  );
});

final netWorthSummaryStreamProvider = StreamProvider<NetWorthSummaryModel>((ref) {
  final repo = ref.watch(netWorthRepositoryProvider);
  return repo.watchNetWorthSummary();
});

final netWorthSnapshotsStreamProvider = StreamProvider<List<NetWorthSnapshotModel>>((ref) {
  final repo = ref.watch(netWorthRepositoryProvider);
  return repo.watchHistoricalSnapshots();
});

final netWorthControllerProvider = Provider<NetWorthController>((ref) {
  final repo = ref.watch(netWorthRepositoryProvider);
  return NetWorthController(repo);
});

class NetWorthController {
  final NetWorthRepository _repo;

  NetWorthController(this._repo);

  Future<void> takeSnapshot() async {
    await _repo.recordSnapshot();
  }
}

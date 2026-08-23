import '../models/net_worth_snapshot_model.dart';
import '../models/net_worth_summary_model.dart';

abstract class NetWorthRepository {
  Stream<NetWorthSummaryModel> watchNetWorthSummary();
  Future<NetWorthSummaryModel> getNetWorthSummary();

  Stream<List<NetWorthSnapshotModel>> watchHistoricalSnapshots();
  Future<List<NetWorthSnapshotModel>> getHistoricalSnapshots();

  Future<String> recordSnapshot({NetWorthSummaryModel? summary, DateTime? date});
}

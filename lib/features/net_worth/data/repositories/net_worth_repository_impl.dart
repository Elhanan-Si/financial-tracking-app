import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../accounts/domain/models/account_model.dart';
import '../../../accounts/domain/repositories/accounts_repository.dart';
import '../../../investments/domain/repositories/investments_repository.dart';
import '../../../non_market_assets/domain/repositories/non_market_assets_repository.dart';
import '../../../pension_assets/domain/repositories/pension_repository.dart';
import '../../domain/models/net_worth_snapshot_model.dart';
import '../../domain/models/net_worth_summary_model.dart';
import '../../domain/repositories/net_worth_repository.dart';

class NetWorthRepositoryImpl implements NetWorthRepository {
  final AppDatabase _db;
  final AccountsRepository _accountsRepo;
  final InvestmentsRepository _investmentsRepo;
  final PensionRepository _pensionRepo;
  final NonMarketAssetsRepository _nonMarketAssetsRepo;

  NetWorthRepositoryImpl(
    this._db,
    this._accountsRepo,
    this._investmentsRepo,
    this._pensionRepo,
    this._nonMarketAssetsRepo,
  );

  @override
  Stream<NetWorthSummaryModel> watchNetWorthSummary() {
    // React to account balance changes
    return _accountsRepo.watchAccounts().asyncMap((_) async {
      return await getNetWorthSummary();
    });
  }

  @override
  Future<NetWorthSummaryModel> getNetWorthSummary() async {
    final now = DateTime.now();

    // 1. Liquid Assets & Credit Card Liabilities
    final accounts = await _accountsRepo.getAccounts();
    double totalLiquidAssets = 0.0;
    double totalShortTermLiabilities = 0.0;

    for (final acc in accounts) {
      if (acc.type == AccountType.creditCard) {
        if (acc.currentBalance < 0) {
          totalShortTermLiabilities += acc.currentBalance.abs();
        }
      } else {
        if (acc.currentBalance >= 0) {
          totalLiquidAssets += acc.currentBalance;
        } else {
          totalShortTermLiabilities += acc.currentBalance.abs();
        }
      }
    }

    // 2. Stock Portfolio Value in ILS
    final portfolio = await _investmentsRepo.getPortfolioSummary();
    final totalInvestments = portfolio.totalPortfolioValueILS;

    // 3. Pension & Long-Term Savings in ILS
    final pension = await _pensionRepo.getPensionSummary();
    final totalPension = pension.totalCombinedValue;

    // 4. Physical Real Estate, Vehicles & Long-Term Debt
    final nonMarket = await _nonMarketAssetsRepo.getSummary();
    final totalRealEstateAndAssets = nonMarket.totalPhysicalAssetsValue;
    final totalLongTermLiabilities = nonMarket.totalLiabilitiesValue;

    return NetWorthSummaryModel(
      totalLiquidAssets: totalLiquidAssets,
      totalInvestments: totalInvestments,
      totalPension: totalPension,
      totalRealEstateAndAssets: totalRealEstateAndAssets,
      totalShortTermLiabilities: totalShortTermLiabilities,
      totalLongTermLiabilities: totalLongTermLiabilities,
      lastCalculated: now,
    );
  }

  @override
  Stream<List<NetWorthSnapshotModel>> watchHistoricalSnapshots() {
    final query = _db.select(_db.netWorthSnapshotsTable)
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.snapshotDate, mode: OrderingMode.desc)]);

    return query.watch().map((rows) => rows.map(_mapEntryToModel).toList());
  }

  @override
  Future<List<NetWorthSnapshotModel>> getHistoricalSnapshots() async {
    final rows = await (_db.select(_db.netWorthSnapshotsTable)
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.snapshotDate, mode: OrderingMode.desc)]))
        .get();
    return rows.map(_mapEntryToModel).toList();
  }

  @override
  Future<String> recordSnapshot({NetWorthSummaryModel? summary, DateTime? date}) async {
    final current = summary ?? await getNetWorthSummary();
    final snapshotTime = date ?? DateTime.now();
    final id = 'nw_snap_${snapshotTime.millisecondsSinceEpoch}';

    await _db.into(_db.netWorthSnapshotsTable).insert(
          NetWorthSnapshotsTableCompanion.insert(
            id: id,
            snapshotDate: snapshotTime,
            totalLiquidAssets: current.totalLiquidAssets,
            totalInvestments: current.totalInvestments,
            totalPension: current.totalPension,
            totalRealEstate: current.totalRealEstateAndAssets,
            totalLiabilities: current.totalLiabilities,
            netWorth: current.totalNetWorth,
            createdAt: Value(DateTime.now()),
          ),
        );

    return id;
  }

  NetWorthSnapshotModel _mapEntryToModel(NetWorthSnapshotEntry e) {
    return NetWorthSnapshotModel(
      id: e.id,
      snapshotDate: e.snapshotDate,
      totalLiquidAssets: e.totalLiquidAssets,
      totalInvestments: e.totalInvestments,
      totalPension: e.totalPension,
      totalRealEstate: e.totalRealEstate,
      totalLiabilities: e.totalLiabilities,
      netWorth: e.netWorth,
      createdAt: e.createdAt,
    );
  }
}

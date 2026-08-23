class NetWorthSnapshotModel {
  final String id;
  final DateTime snapshotDate;
  final double totalLiquidAssets;
  final double totalInvestments;
  final double totalPension;
  final double totalRealEstate;
  final double totalLiabilities;
  final double netWorth;
  final DateTime createdAt;

  const NetWorthSnapshotModel({
    required this.id,
    required this.snapshotDate,
    required this.totalLiquidAssets,
    required this.totalInvestments,
    required this.totalPension,
    required this.totalRealEstate,
    required this.totalLiabilities,
    required this.netWorth,
    required this.createdAt,
  });
}

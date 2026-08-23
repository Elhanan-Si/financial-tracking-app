class PensionSnapshotModel {
  final String id;
  final String pensionAssetId;
  final double balance;
  final DateTime snapshotDate;
  final DateTime createdAt;

  const PensionSnapshotModel({
    required this.id,
    required this.pensionAssetId,
    required this.balance,
    required this.snapshotDate,
    required this.createdAt,
  });
}

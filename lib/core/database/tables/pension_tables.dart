import 'package:drift/drift.dart';

/// Pension Assets table (Pension, Study Fund - Keren Hishtalmut, Provident Fund - Kupat Gemel)
@DataClassName('PensionAssetEntry')
class PensionAssetsTable extends Table {
  @override
  String get tableName => 'pension_assets';

  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get type => text()(); // 'pension', 'study_fund', 'provident_fund'
  TextColumn get providerName => text()(); // e.g. Harel, Altshuler Shaham, Meitav
  TextColumn get policyNumber => text().nullable()();
  TextColumn get trackName => text().nullable()(); // e.g. S&P 500 track, General track
  RealColumn get currentBalance => real().withDefault(const Constant(0.0))();
  RealColumn get monthlyDepositEmployee => real().withDefault(const Constant(0.0))();
  RealColumn get monthlyDepositEmployer => real().withDefault(const Constant(0.0))();
  DateTimeColumn get lastUpdatedDate => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Pension Snapshots table for historical value tracking
@DataClassName('PensionSnapshotEntry')
class PensionSnapshotsTable extends Table {
  @override
  String get tableName => 'pension_snapshots';

  TextColumn get id => text()();
  TextColumn get pensionAssetId => text().references(PensionAssetsTable, #id, onDelete: KeyAction.cascade)();
  RealColumn get balance => real()();
  DateTimeColumn get snapshotDate => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

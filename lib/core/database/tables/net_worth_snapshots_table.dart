import 'package:drift/drift.dart';

/// Net Worth Snapshots table (Historical monthly snapshots)
@DataClassName('NetWorthSnapshotEntry')
class NetWorthSnapshotsTable extends Table {
  @override
  String get tableName => 'net_worth_snapshots';

  TextColumn get id => text()();
  DateTimeColumn get snapshotDate => dateTime()();
  RealColumn get totalLiquidAssets => real()();
  RealColumn get totalInvestments => real()();
  RealColumn get totalPension => real()();
  RealColumn get totalRealEstate => real()();
  RealColumn get totalLiabilities => real()();
  RealColumn get netWorth => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// App Settings table
@DataClassName('AppSettingEntry')
class AppSettingsTable extends Table {
  @override
  String get tableName => 'app_settings';

  TextColumn get id => text()();
  TextColumn get baseCurrency => text().withDefault(const Constant('ILS'))();
  BoolColumn get isBiometricEnabled => boolean().withDefault(const Constant(false))();
  IntColumn get autoLockTimeoutSeconds => integer().withDefault(const Constant(300))();
  DateTimeColumn get lastBackupDate => dateTime().nullable()();
  BoolColumn get isAutoBackupEnabled => boolean().withDefault(const Constant(false))();
  TextColumn get backupFrequency => text().withDefault(const Constant('weekly'))();
  TextColumn get themeMode => text().withDefault(const Constant('light'))();
  TextColumn get customSettingsJson => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

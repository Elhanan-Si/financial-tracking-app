import 'package:drift/drift.dart';

/// Import Batches table (Audit log of bank / card statement imports)
@DataClassName('ImportBatchEntry')
class ImportBatchesTable extends Table {
  @override
  String get tableName => 'import_batches';

  TextColumn get id => text()();
  TextColumn get sourceName => text()(); // 'Isracard', 'Leumi', 'PAGI', 'OneZero', etc.
  TextColumn get fileName => text()();
  DateTimeColumn get importedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get totalRows => integer().withDefault(const Constant(0))();
  IntColumn get importedRows => integer().withDefault(const Constant(0))();
  IntColumn get duplicatesSkipped => integer().withDefault(const Constant(0))();
  TextColumn get status => text().withDefault(const Constant('completed'))(); // 'completed', 'rolled_back'
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Import Mappings table (Templates for column mapping per bank/card provider)
@DataClassName('ImportMappingEntry')
class ImportMappingsTable extends Table {
  @override
  String get tableName => 'import_mappings';

  TextColumn get id => text()();
  TextColumn get sourceName => text()();
  TextColumn get mappingConfigJson => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

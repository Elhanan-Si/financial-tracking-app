import 'package:drift/drift.dart';

/// Categories table (Two-tier tree hierarchy)
@DataClassName('CategoryEntry')
class CategoriesTable extends Table {
  @override
  String get tableName => 'categories';

  TextColumn get id => text()();
  TextColumn get parentId => text().nullable().references(CategoriesTable, #id)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get type => text()(); // 'expense', 'income'
  TextColumn get spendingClassification => text().withDefault(const Constant('needs'))(); // 'needs', 'wants'
  TextColumn get flexibility => text().withDefault(const Constant('variable'))(); // 'fixed', 'variable'
  IntColumn get colorValue => integer().withDefault(const Constant(0xFF3B82F6))();
  TextColumn get iconName => text().withDefault(const Constant('uncategorized'))();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

import 'package:drift/drift.dart';
import 'accounts_table.dart';
import 'categories_table.dart';
import 'tags_and_merchants_tables.dart';

/// Recurring Rules (Standing orders / Subscriptions) table
@DataClassName('RecurringRuleEntry')
class RecurringRulesTable extends Table {
  @override
  String get tableName => 'recurring_rules';

  TextColumn get id => text()();
  TextColumn get accountId => text().references(AccountsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get categoryId => text().nullable().references(CategoriesTable, #id, onDelete: KeyAction.setNull)();
  TextColumn get merchantId => text().nullable().references(MerchantsTable, #id, onDelete: KeyAction.setNull)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  RealColumn get amount => real()();
  TextColumn get frequency => text()(); // 'monthly', 'bi_monthly', 'quarterly', 'yearly'
  IntColumn get dayOfMonth => integer()(); // 1-31
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  BoolColumn get isAutoExecute => boolean().withDefault(const Constant(true))();
  BoolColumn get isPaused => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastExecutedDate => dateTime().nullable()();
  DateTimeColumn get nextExecutionDate => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Transfer Links table (Links debits and credits representing internal account transfers)
@DataClassName('TransferLinkEntry')
class TransferLinksTable extends Table {
  @override
  String get tableName => 'transfer_links';

  TextColumn get id => text()();
  TextColumn get sourceTransactionId => text()();
  TextColumn get destinationTransactionId => text()();
  @ReferenceName('sourceTransferLinks')
  TextColumn get sourceAccountId => text().references(AccountsTable, #id, onDelete: KeyAction.cascade)();
  @ReferenceName('destinationTransferLinks')
  TextColumn get destinationAccountId => text().references(AccountsTable, #id, onDelete: KeyAction.cascade)();
  RealColumn get amount => real()();
  RealColumn get exchangeRate => real().withDefault(const Constant(1.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

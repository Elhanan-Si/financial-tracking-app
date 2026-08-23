import 'package:drift/drift.dart';
import 'accounts_table.dart';
import 'categories_table.dart';
import 'tags_and_merchants_tables.dart';

/// Central Transactions table
@DataClassName('TransactionEntry')
class TransactionsTable extends Table {
  @override
  String get tableName => 'transactions';

  TextColumn get id => text()();
  TextColumn get accountId => text().references(AccountsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get categoryId => text().nullable().references(CategoriesTable, #id, onDelete: KeyAction.setNull)();
  TextColumn get merchantId => text().nullable().references(MerchantsTable, #id, onDelete: KeyAction.setNull)();
  RealColumn get amount => real()(); // Always positive absolute value
  TextColumn get type => text()(); // 'expense', 'income', 'transfer'
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text().nullable()();
  BoolColumn get isExcludedFromReports => boolean().withDefault(const Constant(false))();
  BoolColumn get hasSplits => boolean().withDefault(const Constant(false))();
  BoolColumn get isRecurringInstance => boolean().withDefault(const Constant(false))();
  TextColumn get recurringRuleId => text().nullable()();
  TextColumn get installmentPlanId => text().nullable()();
  IntColumn get installmentNumber => integer().nullable()();
  TextColumn get transferLinkId => text().nullable()();
  BoolColumn get isAutoCategorized => boolean().withDefault(const Constant(false))();
  TextColumn get importBatchId => text().nullable()();
  TextColumn get originalCurrency => text().withDefault(const Constant('ILS'))();
  RealColumn get originalAmount => real().nullable()();
  RealColumn get exchangeRateToIls => real().withDefault(const Constant(1.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

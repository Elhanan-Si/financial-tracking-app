import 'package:drift/drift.dart';
import 'categories_table.dart';
import 'transactions_table.dart';

/// Transaction Splits table
@DataClassName('TransactionSplitEntry')
class TransactionSplitsTable extends Table {
  @override
  String get tableName => 'transaction_splits';

  TextColumn get id => text()();
  TextColumn get transactionId => text().references(TransactionsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get categoryId => text().references(CategoriesTable, #id, onDelete: KeyAction.restrict)();
  RealColumn get amount => real()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

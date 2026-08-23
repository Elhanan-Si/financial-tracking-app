import 'package:drift/drift.dart';
import 'accounts_table.dart';
import 'categories_table.dart';
import 'tags_and_merchants_tables.dart';

/// Installment Plans table
@DataClassName('InstallmentPlanEntry')
class InstallmentPlansTable extends Table {
  @override
  String get tableName => 'installment_plans';

  TextColumn get id => text()();
  TextColumn get accountId => text().references(AccountsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get categoryId => text().nullable().references(CategoriesTable, #id, onDelete: KeyAction.setNull)();
  TextColumn get merchantId => text().nullable().references(MerchantsTable, #id, onDelete: KeyAction.setNull)();
  RealColumn get totalAmount => real()();
  RealColumn get firstInstallmentAmount => real().nullable()();
  IntColumn get numberOfInstallments => integer()();
  DateTimeColumn get firstDueDate => dateTime()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Installment Items table
@DataClassName('InstallmentItemEntry')
class InstallmentItemsTable extends Table {
  @override
  String get tableName => 'installment_items';

  TextColumn get id => text()();
  TextColumn get installmentPlanId => text().references(InstallmentPlansTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get transactionId => text().nullable()();
  IntColumn get installmentNumber => integer()();
  RealColumn get amount => real()();
  DateTimeColumn get dueDate => dateTime()();
  BoolColumn get isPaid => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

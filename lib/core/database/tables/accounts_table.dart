import 'package:drift/drift.dart';

/// Accounts table: Bank, Credit Card, Digital Wallet, Cash
@DataClassName('AccountEntry')
class AccountsTable extends Table {
  @override
  String get tableName => 'accounts';

  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get type => text()(); // 'bank', 'creditCard', 'digitalWallet', 'cash'
  TextColumn get currency => text().withDefault(const Constant('ILS'))();
  RealColumn get initialBalance => real().withDefault(const Constant(0.0))();
  RealColumn get currentBalance => real().withDefault(const Constant(0.0))();
  TextColumn get linkedAccountId => text().nullable().references(AccountsTable, #id)();
  IntColumn get billingDayOfMonth => integer().nullable()(); // 1-31 for credit cards
  IntColumn get colorValue => integer().withDefault(const Constant(0xFF3B82F6))();
  TextColumn get iconName => text().withDefault(const Constant('bank'))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

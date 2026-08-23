import 'package:drift/drift.dart';

/// Securities table (Stocks, ETFs, Bonds, Benchmarks)
@DataClassName('SecurityEntry')
class SecuritiesTable extends Table {
  @override
  String get tableName => 'securities';

  TextColumn get id => text()();
  TextColumn get ticker => text().withLength(min: 1, max: 20)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get securityType => text()(); // 'stock', 'etf', 'bond', 'benchmark'
  TextColumn get exchange => text().nullable()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
  RealColumn get currentPrice => real().withDefault(const Constant(0.0))();
  DateTimeColumn get lastPriceUpdate => dateTime().nullable()();
  BoolColumn get isBenchmark => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Holdings table (Current portfolio positions)
@DataClassName('HoldingEntry')
class HoldingsTable extends Table {
  @override
  String get tableName => 'holdings';

  TextColumn get id => text()();
  TextColumn get securityId => text().references(SecuritiesTable, #id, onDelete: KeyAction.cascade)();
  RealColumn get quantity => real()();
  RealColumn get averageCostBasis => real()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Investment Transactions table (Buy, Sell, Dividends)
@DataClassName('InvestmentTransactionEntry')
class InvestmentTransactionsTable extends Table {
  @override
  String get tableName => 'investment_transactions';

  TextColumn get id => text()();
  TextColumn get securityId => text().references(SecuritiesTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get holdingId => text().nullable().references(HoldingsTable, #id, onDelete: KeyAction.setNull)();
  TextColumn get type => text()(); // 'buy', 'sell', 'dividend'
  RealColumn get quantity => real()();
  RealColumn get pricePerUnit => real()();
  RealColumn get fee => real().withDefault(const Constant(0.0))();
  DateTimeColumn get date => dateTime()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
  RealColumn get exchangeRateToIls => real().withDefault(const Constant(1.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

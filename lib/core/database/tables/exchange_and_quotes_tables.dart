import 'package:drift/drift.dart';

/// Exchange Rates table (Multi-currency tracking)
@DataClassName('ExchangeRateEntry')
class ExchangeRatesTable extends Table {
  @override
  String get tableName => 'exchange_rates';

  TextColumn get id => text()();
  TextColumn get baseCurrency => text()(); // e.g. 'USD'
  TextColumn get targetCurrency => text().withDefault(const Constant('ILS'))();
  RealColumn get rate => real()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  TextColumn get source => text().withDefault(const Constant('manual'))(); // 'finnhub', 'manual'
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Price Quotes table (Stock / ETF historical quotes)
@DataClassName('PriceQuoteEntry')
class PriceQuotesTable extends Table {
  @override
  String get tableName => 'price_quotes';

  TextColumn get id => text()();
  TextColumn get ticker => text()();
  RealColumn get price => real()();
  RealColumn get changePercent => real().withDefault(const Constant(0.0))();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  TextColumn get source => text().withDefault(const Constant('finnhub'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

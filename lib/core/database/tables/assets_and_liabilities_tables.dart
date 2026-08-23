import 'package:drift/drift.dart';

/// Non-market Assets table (Real estate, Vehicles, Other physical assets)
@DataClassName('AssetEntry')
class AssetsTable extends Table {
  @override
  String get tableName => 'assets';

  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get assetType => text()(); // 'real_estate', 'vehicle', 'other'
  RealColumn get estimatedValue => real()();
  DateTimeColumn get lastValuationDate => dateTime().withDefault(currentDateAndTime)();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Liabilities table (Mortgages, Personal loans, Car loans)
@DataClassName('LiabilityEntry')
class LiabilitiesTable extends Table {
  @override
  String get tableName => 'liabilities';

  TextColumn get id => text()();
  TextColumn get assetId => text().nullable().references(AssetsTable, #id, onDelete: KeyAction.setNull)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get liabilityType => text()(); // 'mortgage', 'personal_loan', 'car_loan', 'other'
  RealColumn get initialPrincipal => real()();
  RealColumn get currentPrincipal => real()();
  RealColumn get interestRate => real()(); // e.g. 4.5 for 4.5%
  RealColumn get monthlyPayment => real()();
  IntColumn get remainingPayments => integer()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Loan Schedules table (Amortization schedule items)
@DataClassName('LoanScheduleEntry')
class LoanSchedulesTable extends Table {
  @override
  String get tableName => 'loan_schedules';

  TextColumn get id => text()();
  TextColumn get liabilityId => text().references(LiabilitiesTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get paymentNumber => integer()();
  DateTimeColumn get paymentDate => dateTime()();
  RealColumn get principalComponent => real()();
  RealColumn get interestComponent => real()();
  RealColumn get remainingBalance => real()();
  BoolColumn get isPaid => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

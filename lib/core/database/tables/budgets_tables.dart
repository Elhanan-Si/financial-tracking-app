import 'package:drift/drift.dart';
import 'categories_table.dart';

/// Budgets table
@DataClassName('BudgetEntry')
class BudgetsTable extends Table {
  @override
  String get tableName => 'budgets';

  TextColumn get id => text()();
  TextColumn get categoryId => text().references(CategoriesTable, #id, onDelete: KeyAction.cascade)();
  RealColumn get amount => real()();
  BoolColumn get isRolloverEnabled => boolean().withDefault(const Constant(false))();
  RealColumn get maxRolloverAmount => real().nullable()();
  BoolColumn get isDynamic => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Budget Periods table (e.g. tracking specific month allocations and rollovers)
@DataClassName('BudgetPeriodEntry')
class BudgetPeriodsTable extends Table {
  @override
  String get tableName => 'budget_periods';

  TextColumn get id => text()();
  TextColumn get budgetId => text().references(BudgetsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get monthYear => text()(); // Format: 'YYYY-MM'
  RealColumn get allocatedAmount => real()();
  RealColumn get rolloverAmount => real().withDefault(const Constant(0.0))();
  RealColumn get actualSpent => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

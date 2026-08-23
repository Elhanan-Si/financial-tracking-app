import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/models/budget_model.dart';
import '../../domain/repositories/budgets_repository.dart';

/// Concrete Drift implementation of BudgetsRepository
class BudgetsRepositoryImpl implements BudgetsRepository {
  final AppDatabase _db;

  BudgetsRepositoryImpl(this._db);

  DateTime _getMonthStartDate(String yearMonth) {
    final parts = yearMonth.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    return DateTime(year, month, 1);
  }

  DateTime _getMonthEndDate(String yearMonth) {
    final parts = yearMonth.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final nextMonth = month == 12 ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);
    return nextMonth.subtract(const Duration(milliseconds: 1));
  }

  String _getPreviousYearMonth(String yearMonth) {
    final start = _getMonthStartDate(yearMonth);
    final prev = DateTime(start.year, start.month - 1, 1);
    return DateFormat('yyyy-MM').format(prev);
  }

  int _getDaysInMonth(String yearMonth) {
    final start = _getMonthStartDate(yearMonth);
    final nextMonth = DateTime(start.year, start.month + 1, 1);
    return nextMonth.difference(start).inDays;
  }

  @override
  Stream<List<BudgetModel>> watchBudgetsForMonth(String yearMonth) {
    final query = _db.select(_db.budgetsTable).join([
      innerJoin(_db.categoriesTable, _db.categoriesTable.id.equalsExp(_db.budgetsTable.categoryId)),
      leftOuterJoin(
        _db.budgetPeriodsTable,
        _db.budgetPeriodsTable.budgetId.equalsExp(_db.budgetsTable.id) &
            _db.budgetPeriodsTable.monthYear.equals(yearMonth),
      ),
    ]);
    query.orderBy([OrderingTerm(expression: _db.categoriesTable.name, mode: OrderingMode.asc)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final b = row.readTable(_db.budgetsTable);
        final cat = row.readTable(_db.categoriesTable);
        final period = row.readTableOrNull(_db.budgetPeriodsTable);

        final amount = period?.allocatedAmount ?? b.amount;

        return BudgetModel(
          id: b.id,
          categoryId: b.categoryId,
          categoryName: cat.name,
          categoryColor: cat.colorValue,
          categoryIcon: cat.iconName,
          yearMonth: yearMonth,
          baseAmount: amount,
          isRolloverEnabled: b.isRolloverEnabled,
          maxRolloverAmount: b.maxRolloverAmount,
          createdAt: b.createdAt,
          updatedAt: b.updatedAt,
        );
      }).toList();
    });
  }

  @override
  Future<List<BudgetModel>> getBudgetsForMonth(String yearMonth) async {
    final query = _db.select(_db.budgetsTable).join([
      innerJoin(_db.categoriesTable, _db.categoriesTable.id.equalsExp(_db.budgetsTable.categoryId)),
      leftOuterJoin(
        _db.budgetPeriodsTable,
        _db.budgetPeriodsTable.budgetId.equalsExp(_db.budgetsTable.id) &
            _db.budgetPeriodsTable.monthYear.equals(yearMonth),
      ),
    ]);
    query.orderBy([OrderingTerm(expression: _db.categoriesTable.name, mode: OrderingMode.asc)]);

    final rows = await query.get();
    return rows.map((row) {
      final b = row.readTable(_db.budgetsTable);
      final cat = row.readTable(_db.categoriesTable);
      final period = row.readTableOrNull(_db.budgetPeriodsTable);

      final amount = period?.allocatedAmount ?? b.amount;

      return BudgetModel(
        id: b.id,
        categoryId: b.categoryId,
        categoryName: cat.name,
        categoryColor: cat.colorValue,
        categoryIcon: cat.iconName,
        yearMonth: yearMonth,
        baseAmount: amount,
        isRolloverEnabled: b.isRolloverEnabled,
        maxRolloverAmount: b.maxRolloverAmount,
        createdAt: b.createdAt,
        updatedAt: b.updatedAt,
      );
    }).toList();
  }

  @override
  Future<BudgetModel?> getBudgetById(String id) async {
    final query = _db.select(_db.budgetsTable).join([
      innerJoin(_db.categoriesTable, _db.categoriesTable.id.equalsExp(_db.budgetsTable.categoryId)),
    ]);
    query.where(_db.budgetsTable.id.equals(id));

    final row = await query.getSingleOrNull();
    if (row == null) return null;

    final b = row.readTable(_db.budgetsTable);
    final cat = row.readTable(_db.categoriesTable);
    final nowYm = DateFormat('yyyy-MM').format(DateTime.now());

    return BudgetModel(
      id: b.id,
      categoryId: b.categoryId,
      categoryName: cat.name,
      categoryColor: cat.colorValue,
      categoryIcon: cat.iconName,
      yearMonth: nowYm,
      baseAmount: b.amount,
      isRolloverEnabled: b.isRolloverEnabled,
      maxRolloverAmount: b.maxRolloverAmount,
      createdAt: b.createdAt,
      updatedAt: b.updatedAt,
    );
  }

  @override
  Future<BudgetModel?> getBudgetByCategoryAndMonth(String categoryId, String yearMonth) async {
    final query = _db.select(_db.budgetsTable).join([
      innerJoin(_db.categoriesTable, _db.categoriesTable.id.equalsExp(_db.budgetsTable.categoryId)),
      leftOuterJoin(
        _db.budgetPeriodsTable,
        _db.budgetPeriodsTable.budgetId.equalsExp(_db.budgetsTable.id) &
            _db.budgetPeriodsTable.monthYear.equals(yearMonth),
      ),
    ]);
    query.where(_db.budgetsTable.categoryId.equals(categoryId));

    final row = await query.getSingleOrNull();
    if (row == null) return null;

    final b = row.readTable(_db.budgetsTable);
    final cat = row.readTable(_db.categoriesTable);
    final period = row.readTableOrNull(_db.budgetPeriodsTable);

    final amount = period?.allocatedAmount ?? b.amount;

    return BudgetModel(
      id: b.id,
      categoryId: b.categoryId,
      categoryName: cat.name,
      categoryColor: cat.colorValue,
      categoryIcon: cat.iconName,
      yearMonth: yearMonth,
      baseAmount: amount,
      isRolloverEnabled: b.isRolloverEnabled,
      maxRolloverAmount: b.maxRolloverAmount,
      createdAt: b.createdAt,
      updatedAt: b.updatedAt,
    );
  }

  @override
  Future<String> setCategoryBudget({
    required String categoryId,
    required String yearMonth,
    required double baseAmount,
    bool isRolloverEnabled = false,
    double? maxRolloverAmount,
    String? notes,
  }) async {
    return await _db.transaction(() async {
      final now = DateTime.now();

      final existingBudget = await (_db.select(_db.budgetsTable)..where((tbl) => tbl.categoryId.equals(categoryId))).getSingleOrNull();

      String budgetId;
      if (existingBudget != null) {
        budgetId = existingBudget.id;
        await (_db.update(_db.budgetsTable)..where((tbl) => tbl.id.equals(budgetId))).write(
          BudgetsTableCompanion(
            amount: Value(baseAmount),
            isRolloverEnabled: Value(isRolloverEnabled),
            maxRolloverAmount: Value(maxRolloverAmount),
            updatedAt: Value(now),
          ),
        );
      } else {
        budgetId = 'bg_${DateTime.now().millisecondsSinceEpoch}_${categoryId.substring(0, categoryId.length > 5 ? 5 : categoryId.length)}';
        await _db.into(_db.budgetsTable).insert(
              BudgetsTableCompanion.insert(
                id: budgetId,
                categoryId: categoryId,
                amount: baseAmount,
                isRolloverEnabled: Value(isRolloverEnabled),
                maxRolloverAmount: Value(maxRolloverAmount),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
      }

      // Upsert into BudgetPeriodsTable for this specific month
      final periodId = 'bp_${budgetId}_$yearMonth';
      final existingPeriod = await (_db.select(_db.budgetPeriodsTable)..where((tbl) => tbl.id.equals(periodId))).getSingleOrNull();

      if (existingPeriod != null) {
        await (_db.update(_db.budgetPeriodsTable)..where((tbl) => tbl.id.equals(periodId))).write(
          BudgetPeriodsTableCompanion(
            allocatedAmount: Value(baseAmount),
            updatedAt: Value(now),
          ),
        );
      } else {
        await _db.into(_db.budgetPeriodsTable).insert(
              BudgetPeriodsTableCompanion.insert(
                id: periodId,
                budgetId: budgetId,
                monthYear: yearMonth,
                allocatedAmount: baseAmount,
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );
      }

      return budgetId;
    });
  }

  @override
  Future<void> deleteBudget(String id) async {
    await (_db.delete(_db.budgetsTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<int> copyBudgetsFromMonth({
    required String sourceYearMonth,
    required String targetYearMonth,
  }) async {
    final sourceBudgets = await getBudgetsForMonth(sourceYearMonth);
    if (sourceBudgets.isEmpty) return 0;

    int copiedCount = 0;
    for (final b in sourceBudgets) {
      await setCategoryBudget(
        categoryId: b.categoryId,
        yearMonth: targetYearMonth,
        baseAmount: b.baseAmount,
        isRolloverEnabled: b.isRolloverEnabled,
        maxRolloverAmount: b.maxRolloverAmount,
      );
      copiedCount++;
    }
    return copiedCount;
  }

  @override
  Future<double> calculateActualSpentForCategory({
    required String categoryId,
    required String yearMonth,
  }) async {
    final startDate = _getMonthStartDate(yearMonth);
    final endDate = _getMonthEndDate(yearMonth);

    // 1. Direct non-split transactions
    final directTxQuery = _db.select(_db.transactionsTable)
      ..where((tbl) =>
          tbl.categoryId.equals(categoryId) &
          tbl.type.equals('expense') &
          tbl.isExcludedFromReports.equals(false) &
          tbl.hasSplits.equals(false) &
          tbl.date.isBiggerOrEqualValue(startDate) &
          tbl.date.isSmallerOrEqualValue(endDate));

    final directTransactions = await directTxQuery.get();
    double directSum = 0.0;
    for (final tx in directTransactions) {
      directSum += (tx.amount * tx.exchangeRateToIls);
    }

    // 2. Split items belonging to this category
    final splitQuery = _db.select(_db.transactionSplitsTable).join([
      innerJoin(_db.transactionsTable, _db.transactionsTable.id.equalsExp(_db.transactionSplitsTable.transactionId)),
    ]);
    splitQuery.where(
      _db.transactionSplitsTable.categoryId.equals(categoryId) &
          _db.transactionsTable.type.equals('expense') &
          _db.transactionsTable.isExcludedFromReports.equals(false) &
          _db.transactionsTable.date.isBiggerOrEqualValue(startDate) &
          _db.transactionsTable.date.isSmallerOrEqualValue(endDate),
    );

    final splitRows = await splitQuery.get();
    double splitSum = 0.0;
    for (final row in splitRows) {
      final s = row.readTable(_db.transactionSplitsTable);
      splitSum += s.amount;
    }

    return directSum + splitSum;
  }

  @override
  Future<double> calculateSuggestedBudget({
    required String categoryId,
    required String currentYearMonth,
  }) async {
    final start = _getMonthStartDate(currentYearMonth);
    double totalSpent = 0.0;

    for (int i = 1; i <= 3; i++) {
      final prevMonthDate = DateTime(start.year, start.month - i, 1);
      final ym = DateFormat('yyyy-MM').format(prevMonthDate);
      final spent = await calculateActualSpentForCategory(categoryId: categoryId, yearMonth: ym);
      totalSpent += spent;
    }

    return totalSpent / 3.0;
  }

  @override
  Future<double> calculateRolloverBalance({
    required String categoryId,
    required String yearMonth,
  }) async {
    final currentBudget = await getBudgetByCategoryAndMonth(categoryId, yearMonth);
    if (currentBudget == null || !currentBudget.isRolloverEnabled) {
      return 0.0;
    }

    final prevYm = _getPreviousYearMonth(yearMonth);
    final prevBudget = await getBudgetByCategoryAndMonth(categoryId, prevYm);
    if (prevBudget == null) return 0.0;

    // Previous month spent
    final prevSpent = await calculateActualSpentForCategory(categoryId: categoryId, yearMonth: prevYm);
    final prevEffectiveBudget = prevBudget.baseAmount;

    // Difference: Positive = surplus, Negative = deficit
    double diff = prevEffectiveBudget - prevSpent;

    if (diff > 0 && currentBudget.maxRolloverAmount != null && currentBudget.maxRolloverAmount! > 0) {
      if (diff > currentBudget.maxRolloverAmount!) {
        diff = currentBudget.maxRolloverAmount!;
      }
    }

    return diff;
  }

  @override
  Future<MonthlyBudgetSummary> getMonthlyBudgetSummary(String yearMonth) async {
    final budgets = await getBudgetsForMonth(yearMonth);
    final daysInMonth = _getDaysInMonth(yearMonth);
    final now = DateTime.now();
    final currentYm = DateFormat('yyyy-MM').format(now);
    final currentDay = (yearMonth == currentYm) ? now.day : (yearMonth.compareTo(currentYm) < 0 ? daysInMonth : 1);

    double totalPlanned = 0.0;
    double totalEffective = 0.0;
    double totalSpent = 0.0;
    final items = <BudgetProgressModel>[];

    for (final b in budgets) {
      final rollover = await calculateRolloverBalance(categoryId: b.categoryId, yearMonth: yearMonth);
      final spent = await calculateActualSpentForCategory(categoryId: b.categoryId, yearMonth: yearMonth);

      final progress = BudgetProgressModel(
        budget: b,
        rolloverBalance: rollover,
        actualSpent: spent,
        daysInMonth: daysInMonth,
        currentDayOfMonth: currentDay,
      );

      items.add(progress);
      totalPlanned += b.baseAmount;
      totalEffective += progress.effectiveBudget;
      totalSpent += spent;
    }

    // Expected monthly income
    final startDate = _getMonthStartDate(yearMonth);
    final endDate = _getMonthEndDate(yearMonth);
    final incomeTx = await (_db.select(_db.transactionsTable)
          ..where((tbl) =>
              tbl.type.equals('income') &
              tbl.isExcludedFromReports.equals(false) &
              tbl.date.isBiggerOrEqualValue(startDate) &
              tbl.date.isSmallerOrEqualValue(endDate)))
        .get();

    double totalIncome = 0.0;
    for (final tx in incomeTx) {
      totalIncome += (tx.amount * tx.exchangeRateToIls);
    }

    return MonthlyBudgetSummary(
      yearMonth: yearMonth,
      totalPlannedBudget: totalPlanned,
      totalEffectiveBudget: totalEffective,
      totalActualSpent: totalSpent,
      totalExpectedIncome: totalIncome,
      items: items,
    );
  }
}

import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../budgets/domain/repositories/budgets_repository.dart';
import '../../domain/models/comparative_analytics_model.dart';
import '../../domain/models/financial_brief_model.dart';
import '../../domain/models/savings_rate_model.dart';
import '../../domain/models/spending_classification_model.dart';
import '../../domain/repositories/insights_repository.dart';
import '../services/financial_brief_generator.dart';

class InsightsRepositoryImpl implements InsightsRepository {
  final AppDatabase _db;
  final BudgetsRepository _budgetsRepo;

  InsightsRepositoryImpl(this._db, this._budgetsRepo);

  @override
  Future<SpendingClassificationModel> getSpendingClassification({DateTime? month}) async {
    final targetMonth = month ?? DateTime.now();
    final start = DateTime(targetMonth.year, targetMonth.month, 1);
    final end = DateTime(targetMonth.year, targetMonth.month + 1, 1);

    // 1. Fetch categories
    final categories = await _db.select(_db.categoriesTable).get();
    final catMap = {for (final c in categories) c.id: c};

    // 2. Fetch transactions for month
    final txRows = await (_db.select(_db.transactionsTable)
          ..where((tbl) =>
              tbl.date.isBiggerOrEqualValue(start) &
              tbl.date.isSmallerThanValue(end) &
              tbl.isExcludedFromReports.equals(false)))
        .get();

    double income = 0.0;
    double expenses = 0.0;
    double needs = 0.0;
    double wants = 0.0;
    double fixed = 0.0;
    double variable = 0.0;

    for (final tx in txRows) {
      if (tx.type == 'income') {
        income += tx.amount;
      } else if (tx.type == 'expense') {
        expenses += tx.amount;
        final cat = tx.categoryId != null ? catMap[tx.categoryId] : null;

        if (cat != null) {
          if (cat.spendingClassification == 'wants') {
            wants += tx.amount;
          } else {
            needs += tx.amount;
          }

          if (cat.flexibility == 'fixed') {
            fixed += tx.amount;
          } else {
            variable += tx.amount;
          }
        } else {
          // Default unclassified
          needs += tx.amount;
          variable += tx.amount;
        }
      }
    }

    final savings = (income - expenses).clamp(0.0, double.infinity);

    return SpendingClassificationModel(
      totalIncome: income,
      totalExpenses: expenses,
      needsAmount: needs,
      wantsAmount: wants,
      savingsAmount: savings,
      fixedAmount: fixed,
      variableAmount: variable,
    );
  }

  @override
  Future<ComparativeAnalyticsModel> getComparativeAnalytics({
    DateTime? currentMonth,
    DateTime? previousMonth,
  }) async {
    final cur = currentMonth ?? DateTime.now();
    final curStart = DateTime(cur.year, cur.month, 1);
    final curEnd = DateTime(cur.year, cur.month + 1, 1);

    final prev = previousMonth ?? DateTime(cur.year, cur.month - 1, 1);
    final prevStart = DateTime(prev.year, prev.month, 1);
    final prevEnd = DateTime(prev.year, prev.month + 1, 1);

    final categories = await _db.select(_db.categoriesTable).get();
    final catNameMap = {for (final c in categories) c.id: c.name};

    // Fetch Current Period
    final curTx = await (_db.select(_db.transactionsTable)
          ..where((tbl) =>
              tbl.date.isBiggerOrEqualValue(curStart) &
              tbl.date.isSmallerThanValue(curEnd) &
              tbl.isExcludedFromReports.equals(false)))
        .get();

    // Fetch Previous Period
    final prevTx = await (_db.select(_db.transactionsTable)
          ..where((tbl) =>
              tbl.date.isBiggerOrEqualValue(prevStart) &
              tbl.date.isSmallerThanValue(prevEnd) &
              tbl.isExcludedFromReports.equals(false)))
        .get();

    double curExpenses = 0.0;
    double curIncome = 0.0;
    final curCatExpenses = <String, double>{};

    for (final tx in curTx) {
      if (tx.type == 'expense') {
        curExpenses += tx.amount;
        final cId = tx.categoryId ?? 'uncategorized';
        curCatExpenses[cId] = (curCatExpenses[cId] ?? 0.0) + tx.amount;
      } else if (tx.type == 'income') {
        curIncome += tx.amount;
      }
    }

    double prevExpenses = 0.0;
    double prevIncome = 0.0;
    final prevCatExpenses = <String, double>{};

    for (final tx in prevTx) {
      if (tx.type == 'expense') {
        prevExpenses += tx.amount;
        final cId = tx.categoryId ?? 'uncategorized';
        prevCatExpenses[cId] = (prevCatExpenses[cId] ?? 0.0) + tx.amount;
      } else if (tx.type == 'income') {
        prevIncome += tx.amount;
      }
    }

    // Compare all categories
    final allCategoryIds = {...curCatExpenses.keys, ...prevCatExpenses.keys};
    final movers = <CategoryMover>[];

    for (final cId in allCategoryIds) {
      final cAmount = curCatExpenses[cId] ?? 0.0;
      final pAmount = prevCatExpenses[cId] ?? 0.0;
      final delta = cAmount - pAmount;
      final deltaPct = pAmount > 0 ? (delta / pAmount) * 100 : (cAmount > 0 ? 100.0 : 0.0);

      movers.add(
        CategoryMover(
          categoryId: cId,
          categoryName: catNameMap[cId] ?? 'ללא קטגוריה',
          currentAmount: cAmount,
          previousAmount: pAmount,
          deltaAmount: delta,
          deltaPercent: deltaPct,
        ),
      );
    }

    // Sort Top Increasing (spent more)
    final topIncreasing = movers.where((m) => m.deltaAmount > 0).toList()
      ..sort((a, b) => b.deltaAmount.compareTo(a.deltaAmount));

    // Sort Top Decreasing (saved more)
    final topDecreasing = movers.where((m) => m.deltaAmount < 0).toList()
      ..sort((a, b) => a.deltaAmount.compareTo(b.deltaAmount));

    return ComparativeAnalyticsModel(
      currentPeriodLabel: '${cur.month}/${cur.year}',
      previousPeriodLabel: '${prev.month}/${prev.year}',
      currentTotalExpenses: curExpenses,
      previousTotalExpenses: prevExpenses,
      currentTotalIncome: curIncome,
      previousTotalIncome: prevIncome,
      topIncreasingCategories: topIncreasing.take(5).toList(),
      topDecreasingCategories: topDecreasing.take(5).toList(),
    );
  }

  @override
  Future<SavingsRateModel> getSavingsRateMetrics({DateTime? month}) async {
    final targetMonth = month ?? DateTime.now();

    // 1. Current month
    final currentStats = await _getMonthIncomeExpenses(targetMonth.year, targetMonth.month);
    final curSavingsRate = currentStats.income > 0
        ? ((currentStats.income - currentStats.expenses) / currentStats.income) * 100
        : 0.0;

    // 2. Multi-month moving averages
    final monthlyRates = <double>[];
    final monthlyExpenses = <double>[];

    for (int i = 0; i < 12; i++) {
      final mDate = DateTime(targetMonth.year, targetMonth.month - i, 1);
      final stats = await _getMonthIncomeExpenses(mDate.year, mDate.month);
      if (stats.income > 0) {
        final rate = ((stats.income - stats.expenses) / stats.income) * 100;
        monthlyRates.add(rate);
      }
      if (stats.expenses > 0) {
        monthlyExpenses.add(stats.expenses);
      }
    }

    double avg3 = curSavingsRate;
    if (monthlyRates.isNotEmpty) {
      final slice3 = monthlyRates.take(3).toList();
      avg3 = slice3.reduce((a, b) => a + b) / slice3.length;
    }

    double avg6 = avg3;
    if (monthlyRates.isNotEmpty) {
      final slice6 = monthlyRates.take(6).toList();
      avg6 = slice6.reduce((a, b) => a + b) / slice6.length;
    }

    double avg12 = avg6;
    if (monthlyRates.isNotEmpty) {
      avg12 = monthlyRates.reduce((a, b) => a + b) / monthlyRates.length;
    }

    double burnRate = currentStats.expenses;
    if (monthlyExpenses.isNotEmpty) {
      burnRate = monthlyExpenses.reduce((a, b) => a + b) / monthlyExpenses.length;
    }

    return SavingsRateModel(
      currentMonthIncome: currentStats.income,
      currentMonthExpenses: currentStats.expenses,
      currentMonthSavingsRate: curSavingsRate,
      threeMonthMovingAverage: avg3,
      sixMonthMovingAverage: avg6,
      twelveMonthMovingAverage: avg12,
      monthlyBurnRate: burnRate,
    );
  }

  @override
  Future<FinancialBriefModel> getMonthlyFinancialBrief({DateTime? month}) async {
    final spending = await getSpendingClassification(month: month);
    final comparative = await getComparativeAnalytics(currentMonth: month);
    final savings = await getSavingsRateMetrics(month: month);

    // Count at-risk budgets
    int atRiskCount = 0;
    try {
      final now = month ?? DateTime.now();
      final yearMonth = '${now.year}-${now.month.toString().padLeft(2, '0')}';
      final summary = await _budgetsRepo.getMonthlyBudgetSummary(yearMonth);
      atRiskCount = summary.items.where((b) => b.isOverBudget || b.burnRateStatus != 'safe').length;
    } catch (_) {}

    return FinancialBriefGenerator.generate(
      spending: spending,
      comparative: comparative,
      savings: savings,
      budgetsAtRiskCount: atRiskCount,
    );
  }

  Future<({double income, double expenses})> _getMonthIncomeExpenses(int year, int month) async {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 1);

    final txRows = await (_db.select(_db.transactionsTable)
          ..where((tbl) =>
              tbl.date.isBiggerOrEqualValue(start) &
              tbl.date.isSmallerThanValue(end) &
              tbl.isExcludedFromReports.equals(false)))
        .get();

    double income = 0.0;
    double expenses = 0.0;

    for (final tx in txRows) {
      if (tx.type == 'income') {
        income += tx.amount;
      } else if (tx.type == 'expense') {
        expenses += tx.amount;
      }
    }

    return (income: income, expenses: expenses);
  }
}

import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/models/cash_flow_model.dart';
import '../../domain/models/credit_card_forecast_model.dart';
import '../../domain/repositories/cash_flow_repository.dart';

/// Drift implementation of CashFlowRepository
class CashFlowRepositoryImpl implements CashFlowRepository {
  final AppDatabase _db;

  CashFlowRepositoryImpl(this._db);

  DateTime _getNextBillingDate(DateTime fromDate, int billingDay) {
    if (fromDate.day < billingDay) {
      return DateTime(fromDate.year, fromDate.month, billingDay);
    } else {
      final nextMonth = fromDate.month == 12 ? DateTime(fromDate.year + 1, 1, 1) : DateTime(fromDate.year, fromDate.month + 1, 1);
      final daysInMonth = DateTime(nextMonth.year, nextMonth.month + 1, 0).day;
      final safeDay = billingDay > daysInMonth ? daysInMonth : billingDay;
      return DateTime(nextMonth.year, nextMonth.month, safeDay);
    }
  }

  DateTime _getPreviousBillingDate(DateTime billingDate, int billingDay) {
    final prevMonth = billingDate.month == 1 ? DateTime(billingDate.year - 1, 12, 1) : DateTime(billingDate.year, billingDate.month - 1, 1);
    final daysInMonth = DateTime(prevMonth.year, prevMonth.month + 1, 0).day;
    final safeDay = billingDay > daysInMonth ? daysInMonth : billingDay;
    return DateTime(prevMonth.year, prevMonth.month, safeDay);
  }

  @override
  Future<List<CreditCardForecastModel>> getCreditCardForecasts() async {
    final cards = await (_db.select(_db.accountsTable)
          ..where((tbl) => tbl.type.equals('creditCard') & tbl.isArchived.equals(false)))
        .get();

    final now = DateTime.now();
    final forecasts = <CreditCardForecastModel>[];

    for (final card in cards) {
      final billingDay = card.billingDayOfMonth ?? 10;
      final nextBillingDate = _getNextBillingDate(now, billingDay);
      final cycleStartDate = _getPreviousBillingDate(nextBillingDate, billingDay);
      final prevCycleStartDate = _getPreviousBillingDate(cycleStartDate, billingDay);

      // 1. Current Cycle Regular Transactions
      final currentTx = await (_db.select(_db.transactionsTable)
            ..where((tbl) =>
                tbl.accountId.equals(card.id) &
                tbl.type.equals('expense') &
                tbl.isExcludedFromReports.equals(false) &
                tbl.date.isBiggerOrEqualValue(cycleStartDate) &
                tbl.date.isSmallerOrEqualValue(nextBillingDate)))
          .get();

      double currentRegularSpending = 0.0;
      for (final tx in currentTx) {
        currentRegularSpending += (tx.amount * tx.exchangeRateToIls);
      }

      // 2. Upcoming Installments due on this card
      final installmentQuery = _db.select(_db.installmentItemsTable).join([
        innerJoin(_db.installmentPlansTable, _db.installmentPlansTable.id.equalsExp(_db.installmentItemsTable.installmentPlanId)),
      ]);
      installmentQuery.where(
        _db.installmentPlansTable.accountId.equals(card.id) &
            _db.installmentItemsTable.dueDate.isBiggerOrEqualValue(cycleStartDate) &
            _db.installmentItemsTable.dueDate.isSmallerOrEqualValue(nextBillingDate),
      );
      final installmentItems = await installmentQuery.get();

      double installmentsDue = 0.0;
      for (final row in installmentItems) {
        final item = row.readTable(_db.installmentItemsTable);
        installmentsDue += item.amount;
      }

      // 3. Recurring Rules on this card
      final recurringRules = await (_db.select(_db.recurringRulesTable)
            ..where((tbl) => tbl.accountId.equals(card.id) & tbl.isPaused.equals(false)))
          .get();

      double recurringCharges = 0.0;
      for (final rule in recurringRules) {
        recurringCharges += rule.amount;
      }

      // Total projected charge
      final totalProjected = currentRegularSpending + installmentsDue + recurringCharges;

      // 4. Previous Month Actual Charge
      final prevTx = await (_db.select(_db.transactionsTable)
            ..where((tbl) =>
                tbl.accountId.equals(card.id) &
                tbl.type.equals('expense') &
                tbl.isExcludedFromReports.equals(false) &
                tbl.date.isBiggerOrEqualValue(prevCycleStartDate) &
                tbl.date.isSmallerOrEqualValue(cycleStartDate)))
          .get();

      double prevTotal = 0.0;
      for (final tx in prevTx) {
        prevTotal += (tx.amount * tx.exchangeRateToIls);
      }

      forecasts.add(
        CreditCardForecastModel(
          accountId: card.id,
          cardName: card.name,
          colorValue: card.colorValue,
          billingDayOfMonth: billingDay,
          nextBillingDate: nextBillingDate,
          currentCycleSpending: currentRegularSpending,
          installmentsDueAmount: installmentsDue,
          recurringChargesAmount: recurringCharges,
          totalProjectedCharge: totalProjected,
          transactionsCount: currentTx.length,
          previousMonthTotalCharge: prevTotal,
        ),
      );
    }

    return forecasts;
  }

  @override
  Future<CashFlowForecastSummary> calculateCashFlowForecast({
    int days = 30,
    List<WhatIfScenarioModel> whatIfScenarios = const [],
  }) async {
    // 1. Initial liquid balance
    final liquidAccounts = await (_db.select(_db.accountsTable)
          ..where((tbl) =>
              (tbl.type.equals('bank') | tbl.type.equals('cash') | tbl.type.equals('digitalWallet')) &
              tbl.isArchived.equals(false)))
        .get();

    double startingBalance = 0.0;
    for (final acc in liquidAccounts) {
      startingBalance += acc.currentBalance;
    }

    // 2. Load recurring rules, categories & credit card forecasts
    final activeRecurring = await (_db.select(_db.recurringRulesTable)..where((tbl) => tbl.isPaused.equals(false))).get();
    final allCategories = await _db.select(_db.categoriesTable).get();
    final categoriesMap = {for (final c in allCategories) c.id: c};
    final cardForecasts = await getCreditCardForecasts();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    double runningBalance = startingBalance;
    double lowestBalance = startingBalance;
    DateTime lowestBalanceDate = today;
    int deficitDaysCount = 0;

    final points = <CashFlowPointModel>[];

    for (int dayOffset = 0; dayOffset <= days; dayOffset++) {
      final currentDate = today.add(Duration(days: dayOffset));
      final openingBalance = runningBalance;
      double dailyInflow = 0.0;
      double dailyOutflow = 0.0;
      final events = <String>[];

      // A. Recurring Incomes and Expenses on this day of month
      for (final rule in activeRecurring) {
        if (rule.dayOfMonth == currentDate.day && rule.amount > 0) {
          final cat = rule.categoryId != null ? categoriesMap[rule.categoryId] : null;
          final isIncome = cat != null
              ? (cat.type == 'income')
              : (rule.name.contains('משכורת') ||
                  rule.name.contains('שכר') ||
                  rule.name.contains('הכנסה') ||
                  rule.name.contains('קצבה'));

          if (isIncome) {
            dailyInflow += rule.amount;
            events.add('${rule.name}: +₪${rule.amount.toStringAsFixed(0)}');
          } else {
            dailyOutflow += rule.amount;
            events.add('${rule.name}: -₪${rule.amount.toStringAsFixed(0)}');
          }
        }
      }

      // B. Credit Card charges hitting bank on billing date
      for (final card in cardForecasts) {
        if (card.billingDayOfMonth == currentDate.day && card.totalProjectedCharge > 0) {
          dailyOutflow += card.totalProjectedCharge;
          events.add('חיוב ${card.cardName}: -₪${card.totalProjectedCharge.toStringAsFixed(0)}');
        }
      }

      // C. Active What-If Scenarios on this date
      for (final scenario in whatIfScenarios) {
        if (scenario.isEnabled) {
          final sDate = DateTime(scenario.date.year, scenario.date.month, scenario.date.day);
          if (sDate.isAtSameMomentAs(currentDate)) {
            if (scenario.isIncome) {
              dailyInflow += scenario.amount;
              events.add('(תרחיש) ${scenario.name}: +₪${scenario.amount.toStringAsFixed(0)}');
            } else {
              dailyOutflow += scenario.amount;
              events.add('(תרחיש) ${scenario.name}: -₪${scenario.amount.toStringAsFixed(0)}');
            }
          }
        }
      }

      runningBalance = openingBalance + dailyInflow - dailyOutflow;

      if (runningBalance < lowestBalance) {
        lowestBalance = runningBalance;
        lowestBalanceDate = currentDate;
      }

      if (runningBalance < 0) {
        deficitDaysCount++;
      }

      points.add(
        CashFlowPointModel(
          date: currentDate,
          openingBalance: openingBalance,
          totalInflow: dailyInflow,
          totalOutflow: dailyOutflow,
          closingBalance: runningBalance,
          eventDescriptions: events,
        ),
      );
    }

    return CashFlowForecastSummary(
      daysHorizon: days,
      startingBalance: startingBalance,
      lowestBalance: lowestBalance,
      lowestBalanceDate: lowestBalanceDate,
      endingBalance: runningBalance,
      deficitDaysCount: deficitDaysCount,
      points: points,
      activeScenarios: whatIfScenarios.where((s) => s.isEnabled).toList(),
    );
  }
}

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../data/repositories/budgets_repository_impl.dart';
import '../../domain/models/budget_model.dart';
import '../../domain/repositories/budgets_repository.dart';

import '../../../backup_settings/presentation/controllers/salary_tax_settings_controller.dart';

final selectedBudgetMonthProvider = StateProvider<String>((ref) {
  return DateFormat('yyyy-MM').format(DateTime.now());
});

final budgetsRepositoryProvider = Provider<BudgetsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return BudgetsRepositoryImpl(db);
});

final budgetsStreamProvider = StreamProvider.family<List<BudgetModel>, String>((ref, yearMonth) {
  final repo = ref.watch(budgetsRepositoryProvider);
  return repo.watchBudgetsForMonth(yearMonth);
});

final monthlyBudgetSummaryProvider = FutureProvider.family<MonthlyBudgetSummary, String>((ref, yearMonth) async {
  ref.watch(dbTableChangeSignalProvider);
  final repo = ref.watch(budgetsRepositoryProvider);
  return await repo.getMonthlyBudgetSummary(yearMonth);
});

final dynamicMonthlyNetIncomeProvider =
    FutureProvider.family<({double baseSalary, double additionalIncome, double totalNetIncome}), String>(
        (ref, yearMonth) async {
  ref.watch(dbTableChangeSignalProvider);
  final db = ref.watch(appDatabaseProvider);
  final salarySettings = ref.watch(salaryTaxSettingsProvider);

  final parts = yearMonth.split('-');
  final year = int.parse(parts[0]);
  final month = int.parse(parts[1]);
  final start = DateTime(year, month, 1);
  final end = DateTime(year, month + 1, 0, 23, 59, 59);

  final incomeTx = await (db.select(db.transactionsTable)
        ..where((tbl) =>
            tbl.type.equals('income') &
            tbl.isExcludedFromReports.equals(false) &
            tbl.date.isBiggerOrEqualValue(start) &
            tbl.date.isSmallerOrEqualValue(end)))
      .get();

  double additional = 0.0;
  for (final tx in incomeTx) {
    additional += (tx.amount * tx.exchangeRateToIls);
  }

  final total = salarySettings.baseSalary + additional;
  return (baseSalary: salarySettings.baseSalary, additionalIncome: additional, totalNetIncome: total);
});

final budgetsControllerProvider = Provider<BudgetsController>((ref) {
  final repo = ref.watch(budgetsRepositoryProvider);
  return BudgetsController(repo, ref);
});

class BudgetsController {
  final BudgetsRepository _repo;
  final Ref _ref;

  BudgetsController(this._repo, this._ref);

  Future<String> setCategoryBudget({
    required String categoryId,
    required String yearMonth,
    required double baseAmount,
    bool isRolloverEnabled = false,
    double? maxRolloverAmount,
    String? notes,
  }) async {
    final id = await _repo.setCategoryBudget(
      categoryId: categoryId,
      yearMonth: yearMonth,
      baseAmount: baseAmount,
      isRolloverEnabled: isRolloverEnabled,
      maxRolloverAmount: maxRolloverAmount,
      notes: notes,
    );
    _ref.invalidate(monthlyBudgetSummaryProvider(yearMonth));
    return id;
  }

  Future<void> deleteBudget(String id, String yearMonth) async {
    await _repo.deleteBudget(id);
    _ref.invalidate(monthlyBudgetSummaryProvider(yearMonth));
  }

  Future<int> copyFromPreviousMonth(String currentYearMonth) async {
    final parts = currentYearMonth.split('-');
    final current = DateTime(int.parse(parts[0]), int.parse(parts[1]), 1);
    final prev = DateTime(current.year, current.month - 1, 1);
    final prevYm = DateFormat('yyyy-MM').format(prev);

    final count = await _repo.copyBudgetsFromMonth(
      sourceYearMonth: prevYm,
      targetYearMonth: currentYearMonth,
    );
    _ref.invalidate(monthlyBudgetSummaryProvider(currentYearMonth));
    return count;
  }

  Future<double> getSuggestedBudget(String categoryId, String currentYearMonth) async {
    return await _repo.calculateSuggestedBudget(
      categoryId: categoryId,
      currentYearMonth: currentYearMonth,
    );
  }
}

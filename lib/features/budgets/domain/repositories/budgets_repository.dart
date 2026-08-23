import '../models/budget_model.dart';

/// Repository interface for Budget Planning and Tracking
abstract class BudgetsRepository {
  Stream<List<BudgetModel>> watchBudgetsForMonth(String yearMonth);
  Future<List<BudgetModel>> getBudgetsForMonth(String yearMonth);
  Future<BudgetModel?> getBudgetById(String id);
  Future<BudgetModel?> getBudgetByCategoryAndMonth(String categoryId, String yearMonth);

  Future<String> setCategoryBudget({
    required String categoryId,
    required String yearMonth,
    required double baseAmount,
    bool isRolloverEnabled = false,
    double? maxRolloverAmount,
    String? notes,
  });

  Future<void> deleteBudget(String id);

  /// Clones all budgets from source month to target month
  Future<int> copyBudgetsFromMonth({
    required String sourceYearMonth,
    required String targetYearMonth,
  });

  /// Calculates actual spent for a category in a specific month (including splits)
  Future<double> calculateActualSpentForCategory({
    required String categoryId,
    required String yearMonth,
  });

  /// Calculates smart suggested budget based on 3-month historical average
  Future<double> calculateSuggestedBudget({
    required String categoryId,
    required String currentYearMonth,
  });

  /// Calculates rollover balance from previous month for category
  Future<double> calculateRolloverBalance({
    required String categoryId,
    required String yearMonth,
  });

  /// Returns full progress and burn rate breakdown for all budgets in a month
  Future<MonthlyBudgetSummary> getMonthlyBudgetSummary(String yearMonth);
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../budgets/presentation/controllers/budgets_controller.dart';
import '../../data/repositories/insights_repository_impl.dart';
import '../../domain/models/comparative_analytics_model.dart';
import '../../domain/models/financial_brief_model.dart';
import '../../domain/models/savings_rate_model.dart';
import '../../domain/models/spending_classification_model.dart';
import '../../domain/repositories/insights_repository.dart';

final insightsRepositoryProvider = Provider<InsightsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final budgetsRepo = ref.watch(budgetsRepositoryProvider);
  return InsightsRepositoryImpl(db, budgetsRepo);
});

final spendingClassificationFutureProvider =
    FutureProvider.family<SpendingClassificationModel, DateTime?>((ref, month) {
  final repo = ref.watch(insightsRepositoryProvider);
  return repo.getSpendingClassification(month: month);
});

final comparativeAnalyticsFutureProvider =
    FutureProvider.family<ComparativeAnalyticsModel, ({DateTime? current, DateTime? previous})>(
        (ref, periods) {
  final repo = ref.watch(insightsRepositoryProvider);
  return repo.getComparativeAnalytics(
    currentMonth: periods.current,
    previousMonth: periods.previous,
  );
});

final savingsRateMetricsFutureProvider =
    FutureProvider.family<SavingsRateModel, DateTime?>((ref, month) {
  final repo = ref.watch(insightsRepositoryProvider);
  return repo.getSavingsRateMetrics(month: month);
});

final monthlyFinancialBriefFutureProvider =
    FutureProvider.family<FinancialBriefModel, DateTime?>((ref, month) {
  final repo = ref.watch(insightsRepositoryProvider);
  return repo.getMonthlyFinancialBrief(month: month);
});

import '../models/comparative_analytics_model.dart';
import '../models/financial_brief_model.dart';
import '../models/savings_rate_model.dart';
import '../models/spending_classification_model.dart';

abstract class InsightsRepository {
  Future<SpendingClassificationModel> getSpendingClassification({DateTime? month});
  Future<ComparativeAnalyticsModel> getComparativeAnalytics({
    DateTime? currentMonth,
    DateTime? previousMonth,
  });
  Future<SavingsRateModel> getSavingsRateMetrics({DateTime? month});
  Future<FinancialBriefModel> getMonthlyFinancialBrief({DateTime? month});
}

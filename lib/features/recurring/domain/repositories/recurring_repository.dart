import '../models/recurring_rule_model.dart';

/// Repository interface for recurring subscriptions and standing orders
abstract class RecurringRepository {
  Stream<List<RecurringRuleModel>> watchRecurringRules({bool includePaused = true});
  Future<RecurringRuleModel?> getRecurringRuleById(String id);
  Future<String> createRecurringRule(RecurringRuleModel rule);
  Future<void> updateRecurringRule(RecurringRuleModel rule);
  Future<void> setPaused(String id, bool isPaused);
  Future<void> deleteRecurringRule(String id);
  Future<int> executeDueRules();
  Future<double> calculateTotalMonthlyCommitments();
}

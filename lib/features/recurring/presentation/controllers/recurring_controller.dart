import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../accounts/presentation/controllers/accounts_controller.dart';
import '../../../categories_tags/presentation/controllers/categories_controller.dart';
import '../../data/repositories/recurring_repository_impl.dart';
import '../../domain/models/recurring_rule_model.dart';
import '../../domain/repositories/recurring_repository.dart';

final recurringRepositoryProvider = Provider<RecurringRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final accountsRepo = ref.watch(accountsRepositoryProvider);
  final categoriesRepo = ref.watch(categoriesRepositoryProvider);
  return RecurringRepositoryImpl(db, accountsRepo, categoriesRepo);
});

final recurringRulesStreamProvider = StreamProvider.family<List<RecurringRuleModel>, bool>((ref, includePaused) {
  final repo = ref.watch(recurringRepositoryProvider);
  return repo.watchRecurringRules(includePaused: includePaused);
});

final totalMonthlyCommitmentsProvider = FutureProvider<double>((ref) async {
  final repo = ref.watch(recurringRepositoryProvider);
  return repo.calculateTotalMonthlyCommitments();
});

final recurringControllerProvider = Provider<RecurringController>((ref) {
  final repo = ref.watch(recurringRepositoryProvider);
  return RecurringController(repo);
});

class RecurringController {
  final RecurringRepository _repo;

  RecurringController(this._repo);

  Future<String> addRecurringRule(RecurringRuleModel rule) async {
    return await _repo.createRecurringRule(rule);
  }

  Future<void> updateRecurringRule(RecurringRuleModel rule) async {
    await _repo.updateRecurringRule(rule);
  }

  Future<void> togglePause(String id, bool currentlyPaused) async {
    await _repo.setPaused(id, !currentlyPaused);
  }

  Future<void> deleteRule(String id) async {
    await _repo.deleteRecurringRule(id);
  }

  Future<int> checkAndExecuteDueRules() async {
    return await _repo.executeDueRules();
  }
}

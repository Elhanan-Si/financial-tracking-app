import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../accounts/presentation/controllers/accounts_controller.dart';
import '../../../categories_tags/presentation/controllers/categories_controller.dart';
import '../../data/repositories/installments_repository_impl.dart';
import '../../domain/models/installment_plan_model.dart';
import '../../domain/repositories/installments_repository.dart';

final installmentsRepositoryProvider = Provider<InstallmentsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final accountsRepo = ref.watch(accountsRepositoryProvider);
  final categoriesRepo = ref.watch(categoriesRepositoryProvider);
  return InstallmentsRepositoryImpl(db, accountsRepo, categoriesRepo);
});

final installmentPlansStreamProvider = StreamProvider.family<List<InstallmentPlanModel>, bool>((ref, activeOnly) {
  final repo = ref.watch(installmentsRepositoryProvider);
  return repo.watchInstallmentPlans(activeOnly: activeOnly);
});

final installmentsControllerProvider = Provider<InstallmentsController>((ref) {
  final repo = ref.watch(installmentsRepositoryProvider);
  return InstallmentsController(repo);
});

class InstallmentsController {
  final InstallmentsRepository _repo;

  InstallmentsController(this._repo);

  Future<String> createInstallmentPlan({
    required String accountId,
    String? categoryId,
    String? merchantName,
    required double totalAmount,
    double? firstInstallmentAmount,
    required int numberOfInstallments,
    required DateTime firstDueDate,
    String? note,
  }) async {
    return await _repo.createInstallmentPlan(
      accountId: accountId,
      categoryId: categoryId,
      merchantName: merchantName,
      totalAmount: totalAmount,
      firstInstallmentAmount: firstInstallmentAmount,
      numberOfInstallments: numberOfInstallments,
      firstDueDate: firstDueDate,
      note: note,
    );
  }

  Future<void> cancelRemaining(String planId) async {
    await _repo.cancelRemainingInstallments(planId);
  }

  Future<void> deletePlan(String planId) async {
    await _repo.deleteInstallmentPlan(planId);
  }
}

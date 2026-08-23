import '../models/installment_plan_model.dart';

/// Repository interface for Installment plans and scheduled items
abstract class InstallmentsRepository {
  Stream<List<InstallmentPlanModel>> watchInstallmentPlans({bool activeOnly = false});
  Future<InstallmentPlanModel?> getInstallmentPlanById(String planId);
  Future<List<InstallmentItemModel>> getInstallmentItems(String planId);
  Future<String> createInstallmentPlan({
    required String accountId,
    String? categoryId,
    String? merchantName,
    required double totalAmount,
    double? firstInstallmentAmount,
    required int numberOfInstallments,
    required DateTime firstDueDate,
    String? note,
  });
  Future<void> cancelRemainingInstallments(String planId);
  Future<void> deleteInstallmentPlan(String planId);
}

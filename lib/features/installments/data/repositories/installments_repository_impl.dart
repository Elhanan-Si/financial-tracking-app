import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../accounts/domain/repositories/accounts_repository.dart';
import '../../../categories_tags/domain/repositories/categories_repository.dart';
import '../../domain/models/installment_plan_model.dart';
import '../../domain/repositories/installments_repository.dart';

/// Drift implementation of InstallmentsRepository
class InstallmentsRepositoryImpl implements InstallmentsRepository {
  final AppDatabase _db;
  final AccountsRepository _accountsRepo;
  final CategoriesRepository _categoriesRepo;

  InstallmentsRepositoryImpl(this._db, this._accountsRepo, this._categoriesRepo);

  @override
  Stream<List<InstallmentPlanModel>> watchInstallmentPlans({bool activeOnly = false}) {
    final query = _db.select(_db.installmentPlansTable).join([
      innerJoin(_db.accountsTable, _db.accountsTable.id.equalsExp(_db.installmentPlansTable.accountId)),
      leftOuterJoin(_db.categoriesTable, _db.categoriesTable.id.equalsExp(_db.installmentPlansTable.categoryId)),
      leftOuterJoin(_db.merchantsTable, _db.merchantsTable.id.equalsExp(_db.installmentPlansTable.merchantId)),
    ]);

    query.orderBy([OrderingTerm(expression: _db.installmentPlansTable.createdAt, mode: OrderingMode.desc)]);

    return query.watch().asyncMap((rows) async {
      final plans = <InstallmentPlanModel>[];

      for (final row in rows) {
        final plan = row.readTable(_db.installmentPlansTable);
        final acc = row.readTable(_db.accountsTable);
        final cat = row.readTableOrNull(_db.categoriesTable);
        final mer = row.readTableOrNull(_db.merchantsTable);

        final items = await getInstallmentItems(plan.id);
        final model = InstallmentPlanModel(
          id: plan.id,
          accountId: plan.accountId,
          accountName: acc.name,
          categoryId: plan.categoryId,
          categoryName: cat?.name,
          merchantId: plan.merchantId,
          merchantName: mer?.name,
          totalAmount: plan.totalAmount,
          firstInstallmentAmount: plan.firstInstallmentAmount,
          numberOfInstallments: plan.numberOfInstallments,
          firstDueDate: plan.firstDueDate,
          note: plan.note,
          items: items,
          createdAt: plan.createdAt,
        );

        if (!activeOnly || !model.isCompleted) {
          plans.add(model);
        }
      }

      return plans;
    });
  }

  @override
  Future<InstallmentPlanModel?> getInstallmentPlanById(String planId) async {
    final query = _db.select(_db.installmentPlansTable).join([
      innerJoin(_db.accountsTable, _db.accountsTable.id.equalsExp(_db.installmentPlansTable.accountId)),
      leftOuterJoin(_db.categoriesTable, _db.categoriesTable.id.equalsExp(_db.installmentPlansTable.categoryId)),
      leftOuterJoin(_db.merchantsTable, _db.merchantsTable.id.equalsExp(_db.installmentPlansTable.merchantId)),
    ]);
    query.where(_db.installmentPlansTable.id.equals(planId));

    final row = await query.getSingleOrNull();
    if (row == null) return null;

    final plan = row.readTable(_db.installmentPlansTable);
    final acc = row.readTable(_db.accountsTable);
    final cat = row.readTableOrNull(_db.categoriesTable);
    final mer = row.readTableOrNull(_db.merchantsTable);

    final items = await getInstallmentItems(plan.id);

    return InstallmentPlanModel(
      id: plan.id,
      accountId: plan.accountId,
      accountName: acc.name,
      categoryId: plan.categoryId,
      categoryName: cat?.name,
      merchantId: plan.merchantId,
      merchantName: mer?.name,
      totalAmount: plan.totalAmount,
      firstInstallmentAmount: plan.firstInstallmentAmount,
      numberOfInstallments: plan.numberOfInstallments,
      firstDueDate: plan.firstDueDate,
      note: plan.note,
      items: items,
      createdAt: plan.createdAt,
    );
  }

  @override
  Future<List<InstallmentItemModel>> getInstallmentItems(String planId) async {
    final query = _db.select(_db.installmentItemsTable)..where((tbl) => tbl.installmentPlanId.equals(planId));
    query.orderBy([(tbl) => OrderingTerm(expression: tbl.installmentNumber, mode: OrderingMode.asc)]);

    final rows = await query.get();
    return rows.map((item) {
      return InstallmentItemModel(
        id: item.id,
        installmentPlanId: item.installmentPlanId,
        transactionId: item.transactionId,
        installmentNumber: item.installmentNumber,
        amount: item.amount,
        dueDate: item.dueDate,
        isPaid: item.isPaid,
        createdAt: item.createdAt,
      );
    }).toList();
  }

  @override
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
    if (numberOfInstallments < 2) {
      throw Exception('עסקת תשלומים דורשת לפחות 2 תשלומים');
    }
    if (totalAmount <= 0) {
      throw Exception('סכום כולל חייב להיות גדול מ-0');
    }

    String? merchantId;
    if (merchantName != null && merchantName.trim().isNotEmpty) {
      final merchant = await _categoriesRepo.findOrCreateMerchant(merchantName.trim(), defaultCategoryId: categoryId);
      merchantId = merchant.id;
    }

    final planId = 'plan_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();

    // Calculate installment amounts
    final firstAmt = firstInstallmentAmount ?? (totalAmount / numberOfInstallments);
    final remainingCount = numberOfInstallments - 1;
    final otherAmt = remainingCount > 0 ? (totalAmount - firstAmt) / remainingCount : 0.0;

    await _db.transaction(() async {
      // 1. Insert plan
      await _db.into(_db.installmentPlansTable).insert(
            InstallmentPlansTableCompanion.insert(
              id: planId,
              accountId: accountId,
              categoryId: Value(categoryId),
              merchantId: Value(merchantId),
              totalAmount: totalAmount,
              firstInstallmentAmount: Value(firstInstallmentAmount),
              numberOfInstallments: numberOfInstallments,
              firstDueDate: firstDueDate,
              note: Value(note),
              createdAt: Value(now),
            ),
          );

      // 2. Generate items & 1st active transaction
      for (int i = 1; i <= numberOfInstallments; i++) {
        final itemId = 'item_${planId}_$i';
        final itemAmt = (i == 1) ? firstAmt : otherAmt;
        final itemDueDate = DateTime(
          firstDueDate.year,
          firstDueDate.month + (i - 1),
          firstDueDate.day,
        );

        String? txId;
        bool isPaid = false;

        // First installment is charged immediately
        if (i == 1) {
          isPaid = true;
          txId = 'tx_$itemId';
          await _db.into(_db.transactionsTable).insert(
                TransactionsTableCompanion.insert(
                  id: txId,
                  accountId: accountId,
                  categoryId: Value(categoryId),
                  merchantId: Value(merchantId),
                  amount: itemAmt,
                  type: 'expense',
                  date: firstDueDate,
                  note: Value('$note (תשלום 1 מתוך $numberOfInstallments)'),
                  installmentPlanId: Value(planId),
                  installmentNumber: Value(i),
                  createdAt: Value(now),
                  updatedAt: Value(now),
                ),
              );
        }

        await _db.into(_db.installmentItemsTable).insert(
              InstallmentItemsTableCompanion.insert(
                id: itemId,
                installmentPlanId: planId,
                transactionId: Value(txId),
                installmentNumber: i,
                amount: itemAmt,
                dueDate: itemDueDate,
                isPaid: Value(isPaid),
                createdAt: Value(now),
              ),
            );
      }

      await _accountsRepo.calculateAccountBalance(accountId);
    });

    return planId;
  }

  @override
  Future<void> cancelRemainingInstallments(String planId) async {
    // Delete unpaid items
    await (_db.delete(_db.installmentItemsTable)
          ..where((tbl) => tbl.installmentPlanId.equals(planId) & tbl.isPaid.equals(false)))
        .go();
  }

  @override
  Future<void> deleteInstallmentPlan(String planId) async {
    final plan = await getInstallmentPlanById(planId);
    if (plan == null) return;

    await _db.transaction(() async {
      // Delete associated transactions
      await (_db.delete(_db.transactionsTable)..where((tbl) => tbl.installmentPlanId.equals(planId))).go();
      // Cascade removes items & plan
      await (_db.delete(_db.installmentPlansTable)..where((tbl) => tbl.id.equals(planId))).go();

      await _accountsRepo.calculateAccountBalance(plan.accountId);
    });
  }
}

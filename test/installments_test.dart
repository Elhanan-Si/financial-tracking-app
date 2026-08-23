import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/categories_tags/data/repositories/categories_repository_impl.dart';
import 'package:financial_tracking/features/installments/data/repositories/installments_repository_impl.dart';

void main() {
  late AppDatabase db;
  late AccountsRepositoryImpl accountsRepo;
  late CategoriesRepositoryImpl categoriesRepo;
  late InstallmentsRepositoryImpl installmentsRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    accountsRepo = AccountsRepositoryImpl(db);
    categoriesRepo = CategoriesRepositoryImpl(db);
    installmentsRepo = InstallmentsRepositoryImpl(db, accountsRepo, categoriesRepo);
  });

  tearDown(() async {
    await db.close();
  });

  group('TASK-10: Installments Engine Tests', () {
    test('Creating 6-installment plan generates 6 items with 1st charged immediately', () async {
      final now = DateTime.now();
      final planId = await installmentsRepo.createInstallmentPlan(
        accountId: 'acc_main_credit',
        categoryId: 'cat_shopping_electronics',
        merchantName: 'KSP מחשבים',
        totalAmount: 1200.0,
        numberOfInstallments: 6,
        firstDueDate: now,
        note: 'מחשב נייד',
      );

      expect(planId.isNotEmpty, isTrue);

      final plan = await installmentsRepo.getInstallmentPlanById(planId);
      expect(plan, isNotNull);
      expect(plan!.numberOfInstallments, equals(6));
      expect(plan.totalAmount, equals(1200.0));
      expect(plan.paidCount, equals(1));
      expect(plan.paidAmount, equals(200.0));
      expect(plan.remainingAmount, equals(1000.0));

      final items = await installmentsRepo.getInstallmentItems(planId);
      expect(items.length, equals(6));
      expect(items[0].installmentNumber, equals(1));
      expect(items[0].isPaid, isTrue);
      expect(items[0].amount, equals(200.0));
      expect(items[1].installmentNumber, equals(2));
      expect(items[1].isPaid, isFalse);
      expect(items[1].amount, equals(200.0));

      // Account balance should only be charged the first installment (200 ILS)
      final cardBal = await accountsRepo.calculateAccountBalance('acc_main_credit');
      expect(cardBal, equals(-200.0));
    });

    test('Cancel remaining installments deletes only unpaid items', () async {
      final planId = await installmentsRepo.createInstallmentPlan(
        accountId: 'acc_main_credit',
        totalAmount: 900.0,
        numberOfInstallments: 3,
        firstDueDate: DateTime.now(),
      );

      var items = await installmentsRepo.getInstallmentItems(planId);
      expect(items.length, equals(3));

      // Cancel remaining
      await installmentsRepo.cancelRemainingInstallments(planId);

      items = await installmentsRepo.getInstallmentItems(planId);
      expect(items.length, equals(1)); // Only the paid 1st installment remains
      expect(items.first.isPaid, isTrue);
    });
  });
}

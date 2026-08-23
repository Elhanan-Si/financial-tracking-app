import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracking/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:financial_tracking/features/transactions/domain/models/transaction_model.dart';

void main() {
  late AppDatabase db;
  late AccountsRepositoryImpl accountsRepo;
  late TransactionsRepositoryImpl txRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    accountsRepo = AccountsRepositoryImpl(db);
    txRepo = TransactionsRepositoryImpl(db, accountsRepo);
  });

  tearDown(() async {
    await db.close();
  });

  group('AccountsRepository Tests', () {
    test('Can create and retrieve accounts of all 4 types', () async {
      final cardId = await accountsRepo.createAccount(
        AccountModel(
          id: 'test_card_1',
          name: 'מאסטרקארד חו"ל',
          type: AccountType.creditCard,
          initialBalance: 0.0,
          billingDayOfMonth: 15,
          colorValue: 0xFF8B5CF6,
          iconName: 'creditCard',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final walletId = await accountsRepo.createAccount(
        AccountModel(
          id: 'test_wallet_1',
          name: 'PayBox ארנק',
          type: AccountType.digitalWallet,
          initialBalance: 250.0,
          colorValue: 0xFFF59E0B,
          iconName: 'wallet',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final accounts = await accountsRepo.watchAccounts().first;
      expect(accounts.any((a) => a.id == cardId && a.type == AccountType.creditCard), isTrue);
      expect(accounts.any((a) => a.id == walletId && a.type == AccountType.digitalWallet), isTrue);
    });

    test('Dynamic balance recalculation on income and expense transactions', () async {
      // Create a bank account with initial balance 1,000 ILS
      final accId = await accountsRepo.createAccount(
        AccountModel(
          id: 'test_calc_acc',
          name: 'חשבון בדיקת יתרה',
          type: AccountType.bank,
          initialBalance: 1000.0,
          colorValue: 0xFF3B82F6,
          iconName: 'bank',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Add income 5,000 ILS
      await txRepo.createTransaction(
        TransactionModel(
          id: 'tx_inc_1',
          accountId: accId,
          amount: 5000.0,
          type: TransactionType.income,
          date: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      var balance = await accountsRepo.calculateAccountBalance(accId);
      expect(balance, equals(6000.0));

      // Add expense 1,500 ILS
      await txRepo.createTransaction(
        TransactionModel(
          id: 'tx_exp_1',
          accountId: accId,
          amount: 1500.0,
          type: TransactionType.expense,
          date: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      balance = await accountsRepo.calculateAccountBalance(accId);
      expect(balance, equals(4500.0));

      // Delete income transaction -> balance should drop by 5,000
      await txRepo.deleteTransaction('tx_inc_1');
      balance = await accountsRepo.calculateAccountBalance(accId);
      expect(balance, equals(-500.0)); // 1000 initial - 1500 expense
    });

    test('Archiving account hides it from active stream without deleting history', () async {
      final accId = await accountsRepo.createAccount(
        AccountModel(
          id: 'test_archive_acc',
          name: 'חשבון ישן',
          type: AccountType.cash,
          initialBalance: 100.0,
          colorValue: 0xFF10B981,
          iconName: 'cash',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Verify present in active stream
      var activeAccounts = await accountsRepo.watchAccounts(includeArchived: false).first;
      expect(activeAccounts.any((a) => a.id == accId), isTrue);

      // Archive account
      await accountsRepo.setAccountArchived(accId, true);

      // Verify hidden from active stream
      activeAccounts = await accountsRepo.watchAccounts(includeArchived: false).first;
      expect(activeAccounts.any((a) => a.id == accId), isFalse);

      // Verify present in full stream with includeArchived: true
      final allAccounts = await accountsRepo.watchAccounts(includeArchived: true).first;
      expect(allAccounts.any((a) => a.id == accId && a.isArchived), isTrue);
    });
  });
}

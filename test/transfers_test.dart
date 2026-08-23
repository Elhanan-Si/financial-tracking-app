import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financial_tracking/core/database/app_database.dart';
import 'package:financial_tracking/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:financial_tracking/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracking/features/transfers/data/repositories/transfers_repository_impl.dart';

void main() {
  late AppDatabase db;
  late AccountsRepositoryImpl accountsRepo;
  late TransfersRepositoryImpl transfersRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    accountsRepo = AccountsRepositoryImpl(db);
    transfersRepo = TransfersRepositoryImpl(db, accountsRepo);
  });

  tearDown(() async {
    await db.close();
  });

  group('TASK-09: Internal Transfers Tests', () {
    test('Executing transfer updates balances of both source and destination accounts', () async {
      // Create source checking account with 10,000 ILS
      final srcId = await accountsRepo.createAccount(
        AccountModel(
          id: 'acc_trans_src',
          name: 'עו"ש מקור',
          type: AccountType.bank,
          initialBalance: 10000.0,
          colorValue: 0xFF3B82F6,
          iconName: 'bank',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Create destination wallet with 500 ILS
      final dstId = await accountsRepo.createAccount(
        AccountModel(
          id: 'acc_trans_dst',
          name: 'ארנק מזומן יעד',
          type: AccountType.cash,
          initialBalance: 500.0,
          colorValue: 0xFF10B981,
          iconName: 'cash',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      // Execute transfer of 2,000 ILS
      final linkId = await transfersRepo.createTransfer(
        sourceAccountId: srcId,
        destinationAccountId: dstId,
        amount: 2000.0,
        date: DateTime.now(),
        note: 'משיכת מזומן לכספת',
      );

      expect(linkId.isNotEmpty, isTrue);

      // Check balances: Source should be 8,000 and Destination should be 2,500
      final srcBal = await accountsRepo.calculateAccountBalance(srcId);
      final dstBal = await accountsRepo.calculateAccountBalance(dstId);

      expect(srcBal, equals(8000.0));
      expect(dstBal, equals(2500.0));

      // Verify transfer link
      final link = await transfersRepo.getTransferById(linkId);
      expect(link, isNotNull);
      expect(link!.amount, equals(2000.0));
      expect(link.sourceAccountId, equals(srcId));
      expect(link.destinationAccountId, equals(dstId));
    });

    test('Cannot execute transfer between account and itself', () async {
      expect(
        () => transfersRepo.createTransfer(
          sourceAccountId: 'acc_main_checking',
          destinationAccountId: 'acc_main_checking',
          amount: 500.0,
          date: DateTime.now(),
        ),
        throwsException,
      );
    });

    test('Deleting transfer reverts balances on both accounts', () async {
      final srcId = await accountsRepo.createAccount(
        AccountModel(
          id: 'acc_rev_src',
          name: 'חשבון מקור לשחזור',
          type: AccountType.bank,
          initialBalance: 5000.0,
          colorValue: 0xFF3B82F6,
          iconName: 'bank',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final dstId = await accountsRepo.createAccount(
        AccountModel(
          id: 'acc_rev_dst',
          name: 'חשבון יעד לשחזור',
          type: AccountType.digitalWallet,
          initialBalance: 1000.0,
          colorValue: 0xFFF59E0B,
          iconName: 'wallet',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      final linkId = await transfersRepo.createTransfer(
        sourceAccountId: srcId,
        destinationAccountId: dstId,
        amount: 1500.0,
        date: DateTime.now(),
      );

      // Delete the transfer
      await transfersRepo.deleteTransfer(linkId);

      // Check balances are back to original
      final srcBal = await accountsRepo.calculateAccountBalance(srcId);
      final dstBal = await accountsRepo.calculateAccountBalance(dstId);

      expect(srcBal, equals(5000.0));
      expect(dstBal, equals(1000.0));
    });
  });
}

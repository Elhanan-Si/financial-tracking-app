import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../accounts/domain/repositories/accounts_repository.dart';
import '../../domain/models/transfer_model.dart';
import '../../domain/repositories/transfers_repository.dart';

/// Concrete implementation of TransfersRepository
class TransfersRepositoryImpl implements TransfersRepository {
  final AppDatabase _db;
  final AccountsRepository _accountsRepo;

  TransfersRepositoryImpl(this._db, this._accountsRepo);

  @override
  Stream<List<TransferModel>> watchTransfers({int limit = 50}) {
    final sourceAccount = _db.alias(_db.accountsTable, 'source_acc');
    final destAccount = _db.alias(_db.accountsTable, 'dest_acc');

    final query = _db.select(_db.transferLinksTable).join([
      innerJoin(sourceAccount, sourceAccount.id.equalsExp(_db.transferLinksTable.sourceAccountId)),
      innerJoin(destAccount, destAccount.id.equalsExp(_db.transferLinksTable.destinationAccountId)),
    ]);

    query.orderBy([OrderingTerm(expression: _db.transferLinksTable.createdAt, mode: OrderingMode.desc)]);
    query.limit(limit);

    return query.watch().map((rows) {
      return rows.map((row) {
        final link = row.readTable(_db.transferLinksTable);
        final src = row.readTable(sourceAccount);
        final dst = row.readTable(destAccount);

        return TransferModel(
          id: link.id,
          sourceTransactionId: link.sourceTransactionId,
          destinationTransactionId: link.destinationTransactionId,
          sourceAccountId: link.sourceAccountId,
          sourceAccountName: src.name,
          destinationAccountId: link.destinationAccountId,
          destinationAccountName: dst.name,
          amount: link.amount,
          destinationAmount: link.amount * link.exchangeRate,
          exchangeRate: link.exchangeRate,
          date: link.createdAt,
          createdAt: link.createdAt,
        );
      }).toList();
    });
  }

  @override
  Future<TransferModel?> getTransferById(String id) async {
    final sourceAccount = _db.alias(_db.accountsTable, 'source_acc');
    final destAccount = _db.alias(_db.accountsTable, 'dest_acc');

    final query = _db.select(_db.transferLinksTable).join([
      innerJoin(sourceAccount, sourceAccount.id.equalsExp(_db.transferLinksTable.sourceAccountId)),
      innerJoin(destAccount, destAccount.id.equalsExp(_db.transferLinksTable.destinationAccountId)),
    ]);
    query.where(_db.transferLinksTable.id.equals(id));

    final row = await query.getSingleOrNull();
    if (row == null) return null;

    final link = row.readTable(_db.transferLinksTable);
    final src = row.readTable(sourceAccount);
    final dst = row.readTable(destAccount);

    return TransferModel(
      id: link.id,
      sourceTransactionId: link.sourceTransactionId,
      destinationTransactionId: link.destinationTransactionId,
      sourceAccountId: link.sourceAccountId,
      sourceAccountName: src.name,
      destinationAccountId: link.destinationAccountId,
      destinationAccountName: dst.name,
      amount: link.amount,
      destinationAmount: link.amount * link.exchangeRate,
      exchangeRate: link.exchangeRate,
      date: link.createdAt,
      createdAt: link.createdAt,
    );
  }

  @override
  Future<String> createTransfer({
    required String sourceAccountId,
    required String destinationAccountId,
    required double amount,
    double? destinationAmount,
    double exchangeRate = 1.0,
    required DateTime date,
    String? note,
  }) async {
    if (sourceAccountId == destinationAccountId) {
      throw Exception('לא ניתן לבצע העברה בין חשבון לעצמו');
    }
    if (amount <= 0) {
      throw Exception('סכום ההעברה חייב להיות גדול מ-0');
    }

    final destAmt = destinationAmount ?? (amount * exchangeRate);
    final linkId = 'trans_link_${DateTime.now().millisecondsSinceEpoch}';
    final srcTxId = 'tx_out_$linkId';
    final dstTxId = 'tx_in_$linkId';
    final now = DateTime.now();

    final srcAcc = await _accountsRepo.getAccountById(sourceAccountId);
    final dstAcc = await _accountsRepo.getAccountById(destinationAccountId);

    await _db.transaction(() async {
      // 1. Withdrawal transaction in source account
      await _db.into(_db.transactionsTable).insert(
            TransactionsTableCompanion.insert(
              id: srcTxId,
              accountId: sourceAccountId,
              amount: amount,
              type: 'transfer',
              date: date,
              note: Value(note ?? 'העברה אל ${dstAcc?.name ?? 'חשבון יעד'}'),
              isExcludedFromReports: const Value(true),
              transferLinkId: Value(linkId),
              exchangeRateToIls: Value(exchangeRate),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );

      // 2. Deposit transaction in destination account
      await _db.into(_db.transactionsTable).insert(
            TransactionsTableCompanion.insert(
              id: dstTxId,
              accountId: destinationAccountId,
              amount: destAmt,
              type: 'transfer',
              date: date,
              note: Value(note ?? 'העברה מאת ${srcAcc?.name ?? 'חשבון מקור'}'),
              isExcludedFromReports: const Value(true),
              transferLinkId: Value(linkId),
              exchangeRateToIls: Value(exchangeRate),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );

      // 3. Transfer link
      await _db.into(_db.transferLinksTable).insert(
            TransferLinksTableCompanion.insert(
              id: linkId,
              sourceTransactionId: srcTxId,
              destinationTransactionId: dstTxId,
              sourceAccountId: sourceAccountId,
              destinationAccountId: destinationAccountId,
              amount: amount,
              exchangeRate: Value(exchangeRate),
              createdAt: Value(now),
            ),
          );

      // 4. Recalculate balances for both accounts
      await _accountsRepo.calculateAccountBalance(sourceAccountId);
      await _accountsRepo.calculateAccountBalance(destinationAccountId);
    });

    return linkId;
  }

  @override
  Future<void> deleteTransfer(String transferLinkId) async {
    final link = await (_db.select(_db.transferLinksTable)..where((tbl) => tbl.id.equals(transferLinkId))).getSingleOrNull();
    if (link == null) return;

    await _db.transaction(() async {
      // Delete transactions
      await (_db.delete(_db.transactionsTable)..where((tbl) => tbl.id.equals(link.sourceTransactionId))).go();
      await (_db.delete(_db.transactionsTable)..where((tbl) => tbl.id.equals(link.destinationTransactionId))).go();

      // Delete link
      await (_db.delete(_db.transferLinksTable)..where((tbl) => tbl.id.equals(transferLinkId))).go();

      // Recalculate balances
      await _accountsRepo.calculateAccountBalance(link.sourceAccountId);
      await _accountsRepo.calculateAccountBalance(link.destinationAccountId);
    });
  }
}

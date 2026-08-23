import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../accounts/domain/repositories/accounts_repository.dart';
import '../../domain/models/transaction_model.dart';
import '../../domain/models/transaction_split_model.dart';
import '../../domain/repositories/transactions_repository.dart';

/// Concrete Drift implementation of TransactionsRepository
class TransactionsRepositoryImpl implements TransactionsRepository {
  final AppDatabase _db;
  final AccountsRepository _accountsRepo;

  TransactionsRepositoryImpl(this._db, this._accountsRepo);

  JoinedSelectStatement _buildFilterQuery({
    String? type,
    String? accountId,
    List<String>? accountIds,
    String? categoryId,
    List<String>? categoryIds,
    DateTime? startDate,
    DateTime? endDate,
    double? minAmount,
    double? maxAmount,
    String? searchQuery,
  }) {
    final query = _db.select(_db.transactionsTable).join([
      innerJoin(_db.accountsTable, _db.accountsTable.id.equalsExp(_db.transactionsTable.accountId)),
      leftOuterJoin(_db.categoriesTable, _db.categoriesTable.id.equalsExp(_db.transactionsTable.categoryId)),
      leftOuterJoin(_db.merchantsTable, _db.merchantsTable.id.equalsExp(_db.transactionsTable.merchantId)),
    ]);

    if (type != null && type != 'all') {
      query.where(_db.transactionsTable.type.equals(type));
    }

    if (accountId != null && accountId.isNotEmpty) {
      query.where(_db.transactionsTable.accountId.equals(accountId));
    } else if (accountIds != null && accountIds.isNotEmpty) {
      query.where(_db.transactionsTable.accountId.isIn(accountIds));
    }

    if (categoryId != null && categoryId.isNotEmpty) {
      query.where(_db.transactionsTable.categoryId.equals(categoryId));
    } else if (categoryIds != null && categoryIds.isNotEmpty) {
      query.where(_db.transactionsTable.categoryId.isIn(categoryIds));
    }

    if (startDate != null) {
      query.where(_db.transactionsTable.date.isBiggerOrEqualValue(startDate));
    }

    if (endDate != null) {
      query.where(_db.transactionsTable.date.isSmallerOrEqualValue(endDate));
    }

    if (minAmount != null && minAmount > 0) {
      query.where(_db.transactionsTable.amount.isBiggerOrEqualValue(minAmount));
    }

    if (maxAmount != null && maxAmount > 0) {
      query.where(_db.transactionsTable.amount.isSmallerOrEqualValue(maxAmount));
    }

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final q = '%${searchQuery.trim()}%';
      query.where(
        _db.transactionsTable.note.like(q) |
            _db.merchantsTable.name.like(q) |
            _db.categoriesTable.name.like(q),
      );
    }

    query.orderBy([OrderingTerm(expression: _db.transactionsTable.date, mode: OrderingMode.desc)]);
    return query;
  }

  TransactionModel _mapRowToModel(TypedResult row) {
    final tx = row.readTable(_db.transactionsTable);
    final acc = row.readTable(_db.accountsTable);
    final cat = row.readTableOrNull(_db.categoriesTable);
    final mer = row.readTableOrNull(_db.merchantsTable);

    return TransactionModel(
      id: tx.id,
      accountId: tx.accountId,
      accountName: acc.name,
      categoryId: tx.categoryId,
      categoryName: cat?.name,
      categoryColor: cat?.colorValue,
      categoryIcon: cat?.iconName,
      merchantId: tx.merchantId,
      merchantName: mer?.name,
      amount: tx.amount,
      type: TransactionType.fromString(tx.type),
      date: tx.date,
      note: tx.note,
      isExcludedFromReports: tx.isExcludedFromReports,
      hasSplits: tx.hasSplits,
      isRecurringInstance: tx.isRecurringInstance,
      recurringRuleId: tx.recurringRuleId,
      installmentPlanId: tx.installmentPlanId,
      installmentNumber: tx.installmentNumber,
      transferLinkId: tx.transferLinkId,
      isAutoCategorized: tx.isAutoCategorized,
      originalCurrency: tx.originalCurrency,
      originalAmount: tx.originalAmount,
      exchangeRateToIls: tx.exchangeRateToIls,
      createdAt: tx.createdAt,
      updatedAt: tx.updatedAt,
    );
  }

  @override
  Stream<List<TransactionModel>> watchTransactions({
    String? type,
    String? accountId,
    List<String>? accountIds,
    String? categoryId,
    List<String>? categoryIds,
    DateTime? startDate,
    DateTime? endDate,
    double? minAmount,
    double? maxAmount,
    String? searchQuery,
    int limit = 200,
  }) {
    final query = _buildFilterQuery(
      type: type,
      accountId: accountId,
      accountIds: accountIds,
      categoryId: categoryId,
      categoryIds: categoryIds,
      startDate: startDate,
      endDate: endDate,
      minAmount: minAmount,
      maxAmount: maxAmount,
      searchQuery: searchQuery,
    );
    query.limit(limit);

    return query.watch().map((rows) => rows.map(_mapRowToModel).toList());
  }

  @override
  Future<List<TransactionModel>> getTransactions({
    String? type,
    String? accountId,
    List<String>? accountIds,
    String? categoryId,
    List<String>? categoryIds,
    DateTime? startDate,
    DateTime? endDate,
    double? minAmount,
    double? maxAmount,
    String? searchQuery,
    int limit = 200,
  }) async {
    final query = _buildFilterQuery(
      type: type,
      accountId: accountId,
      accountIds: accountIds,
      categoryId: categoryId,
      categoryIds: categoryIds,
      startDate: startDate,
      endDate: endDate,
      minAmount: minAmount,
      maxAmount: maxAmount,
      searchQuery: searchQuery,
    );
    query.limit(limit);

    final rows = await query.get();
    return rows.map(_mapRowToModel).toList();
  }

  @override
  Future<TransactionModel?> getTransactionById(String id) async {
    final query = _db.select(_db.transactionsTable).join([
      innerJoin(_db.accountsTable, _db.accountsTable.id.equalsExp(_db.transactionsTable.accountId)),
      leftOuterJoin(_db.categoriesTable, _db.categoriesTable.id.equalsExp(_db.transactionsTable.categoryId)),
      leftOuterJoin(_db.merchantsTable, _db.merchantsTable.id.equalsExp(_db.transactionsTable.merchantId)),
    ]);
    query.where(_db.transactionsTable.id.equals(id));

    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return _mapRowToModel(row);
  }

  @override
  Future<String> createTransaction(TransactionModel transaction) async {
    final id = transaction.id.isNotEmpty ? transaction.id : 'tx_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();

    final companion = TransactionsTableCompanion.insert(
      id: id,
      accountId: transaction.accountId,
      categoryId: Value(transaction.categoryId),
      merchantId: Value(transaction.merchantId),
      amount: transaction.amount,
      type: transaction.type.name,
      date: transaction.date,
      note: Value(transaction.note),
      isExcludedFromReports: Value(transaction.isExcludedFromReports),
      hasSplits: Value(transaction.hasSplits),
      isRecurringInstance: Value(transaction.isRecurringInstance),
      recurringRuleId: Value(transaction.recurringRuleId),
      installmentPlanId: Value(transaction.installmentPlanId),
      installmentNumber: Value(transaction.installmentNumber),
      transferLinkId: Value(transaction.transferLinkId),
      isAutoCategorized: Value(transaction.isAutoCategorized),
      originalCurrency: Value(transaction.originalCurrency),
      originalAmount: Value(transaction.originalAmount),
      exchangeRateToIls: Value(transaction.exchangeRateToIls),
      createdAt: Value(now),
      updatedAt: Value(now),
    );

    await _db.into(_db.transactionsTable).insert(companion);
    await _accountsRepo.calculateAccountBalance(transaction.accountId);
    return id;
  }

  @override
  Future<String> createTransactionWithSplits(
    TransactionModel transaction,
    List<TransactionSplitModel> splits,
  ) async {
    return await _db.transaction(() async {
      final txId = transaction.id.isNotEmpty ? transaction.id : 'tx_${DateTime.now().millisecondsSinceEpoch}';
      final now = DateTime.now();

      final companion = TransactionsTableCompanion.insert(
        id: txId,
        accountId: transaction.accountId,
        categoryId: Value(transaction.categoryId ?? (splits.isNotEmpty ? splits.first.categoryId : null)),
        merchantId: Value(transaction.merchantId),
        amount: transaction.amount,
        type: transaction.type.name,
        date: transaction.date,
        note: Value(transaction.note),
        isExcludedFromReports: Value(transaction.isExcludedFromReports),
        hasSplits: const Value(true),
        isRecurringInstance: Value(transaction.isRecurringInstance),
        recurringRuleId: Value(transaction.recurringRuleId),
        installmentPlanId: Value(transaction.installmentPlanId),
        installmentNumber: Value(transaction.installmentNumber),
        transferLinkId: Value(transaction.transferLinkId),
        isAutoCategorized: Value(transaction.isAutoCategorized),
        originalCurrency: Value(transaction.originalCurrency),
        originalAmount: Value(transaction.originalAmount),
        exchangeRateToIls: Value(transaction.exchangeRateToIls),
        createdAt: Value(now),
        updatedAt: Value(now),
      );

      await _db.into(_db.transactionsTable).insert(companion);

      for (int i = 0; i < splits.length; i++) {
        final split = splits[i];
        final splitId = split.id.isNotEmpty ? split.id : 'split_${txId}_$i';
        await _db.into(_db.transactionSplitsTable).insert(
              TransactionSplitsTableCompanion.insert(
                id: splitId,
                transactionId: txId,
                categoryId: split.categoryId,
                amount: split.amount,
                note: Value(split.note),
                createdAt: Value(now),
              ),
            );
      }

      await _accountsRepo.calculateAccountBalance(transaction.accountId);
      return txId;
    });
  }

  @override
  Future<List<TransactionSplitModel>> getSplitsForTransaction(String transactionId) async {
    final query = _db.select(_db.transactionSplitsTable).join([
      innerJoin(_db.categoriesTable, _db.categoriesTable.id.equalsExp(_db.transactionSplitsTable.categoryId)),
    ]);
    query.where(_db.transactionSplitsTable.transactionId.equals(transactionId));

    final rows = await query.get();
    return rows.map((row) {
      final split = row.readTable(_db.transactionSplitsTable);
      final cat = row.readTable(_db.categoriesTable);

      return TransactionSplitModel(
        id: split.id,
        transactionId: split.transactionId,
        categoryId: split.categoryId,
        categoryName: cat.name,
        categoryColor: cat.colorValue,
        categoryIcon: cat.iconName,
        amount: split.amount,
        note: split.note,
        createdAt: split.createdAt,
      );
    }).toList();
  }

  @override
  Future<void> updateTransaction(
    TransactionModel transaction, {
    List<TransactionSplitModel>? splits,
  }) async {
    await _db.transaction(() async {
      final old = await (_db.select(_db.transactionsTable)..where((tbl) => tbl.id.equals(transaction.id))).getSingleOrNull();

      final companion = TransactionsTableCompanion(
        accountId: Value(transaction.accountId),
        categoryId: Value(transaction.categoryId),
        merchantId: Value(transaction.merchantId),
        amount: Value(transaction.amount),
        type: Value(transaction.type.name),
        date: Value(transaction.date),
        note: Value(transaction.note),
        isExcludedFromReports: Value(transaction.isExcludedFromReports),
        hasSplits: Value(splits != null && splits.isNotEmpty),
        isRecurringInstance: Value(transaction.isRecurringInstance),
        originalCurrency: Value(transaction.originalCurrency),
        originalAmount: Value(transaction.originalAmount),
        exchangeRateToIls: Value(transaction.exchangeRateToIls),
        updatedAt: Value(DateTime.now()),
      );

      await (_db.update(_db.transactionsTable)..where((tbl) => tbl.id.equals(transaction.id))).write(companion);

      if (splits != null) {
        await (_db.delete(_db.transactionSplitsTable)..where((tbl) => tbl.transactionId.equals(transaction.id))).go();
        final now = DateTime.now();
        for (int i = 0; i < splits.length; i++) {
          final split = splits[i];
          final splitId = split.id.isNotEmpty ? split.id : 'split_${transaction.id}_$i';
          await _db.into(_db.transactionSplitsTable).insert(
                TransactionSplitsTableCompanion.insert(
                  id: splitId,
                  transactionId: transaction.id,
                  categoryId: split.categoryId,
                  amount: split.amount,
                  note: Value(split.note),
                  createdAt: Value(now),
                ),
              );
        }
      }

      await _accountsRepo.calculateAccountBalance(transaction.accountId);
      if (old != null && old.accountId != transaction.accountId) {
        await _accountsRepo.calculateAccountBalance(old.accountId);
      }
    });
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final old = await (_db.select(_db.transactionsTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    await (_db.delete(_db.transactionsTable)..where((tbl) => tbl.id.equals(id))).go();

    if (old != null) {
      await _accountsRepo.calculateAccountBalance(old.accountId);
    }
  }

  @override
  Future<void> batchUpdateCategory(List<String> transactionIds, String categoryId) async {
    if (transactionIds.isEmpty) return;

    await _db.transaction(() async {
      await (_db.update(_db.transactionsTable)..where((tbl) => tbl.id.isIn(transactionIds))).write(
        TransactionsTableCompanion(
          categoryId: Value(categoryId),
          updatedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  @override
  Future<void> batchDeleteTransactions(List<String> transactionIds) async {
    if (transactionIds.isEmpty) return;

    await _db.transaction(() async {
      final affectedAccounts = await (_db.selectOnly(_db.transactionsTable, distinct: true)
            ..addColumns([_db.transactionsTable.accountId])
            ..where(_db.transactionsTable.id.isIn(transactionIds)))
          .map((row) => row.read(_db.transactionsTable.accountId)!)
          .get();

      await (_db.delete(_db.transactionsTable)..where((tbl) => tbl.id.isIn(transactionIds))).go();

      for (final accId in affectedAccounts) {
        await _accountsRepo.calculateAccountBalance(accId);
      }
    });
  }
}

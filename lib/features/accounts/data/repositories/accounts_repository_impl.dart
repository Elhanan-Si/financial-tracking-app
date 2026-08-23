import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/models/account_model.dart';
import '../../domain/repositories/accounts_repository.dart';

/// Drift implementation of AccountsRepository
class AccountsRepositoryImpl implements AccountsRepository {
  final AppDatabase _db;

  AccountsRepositoryImpl(this._db);

  @override
  Stream<List<AccountModel>> watchAccounts({bool includeArchived = false}) {
    final query = _db.select(_db.accountsTable);
    if (!includeArchived) {
      query.where((tbl) => tbl.isArchived.equals(false));
    }
    query.orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.asc)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return AccountModel(
          id: row.id,
          name: row.name,
          type: AccountType.fromString(row.type),
          currency: row.currency,
          initialBalance: row.initialBalance,
          currentBalance: row.currentBalance,
          linkedAccountId: row.linkedAccountId,
          billingDayOfMonth: row.billingDayOfMonth,
          colorValue: row.colorValue,
          iconName: row.iconName,
          isArchived: row.isArchived,
          createdAt: row.createdAt,
          updatedAt: row.updatedAt,
        );
      }).toList();
    });
  }

  @override
  Future<List<AccountModel>> getAccounts({bool includeArchived = false}) async {
    final query = _db.select(_db.accountsTable);
    if (!includeArchived) {
      query.where((tbl) => tbl.isArchived.equals(false));
    }
    query.orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.asc)]);

    final rows = await query.get();
    return rows.map((row) {
      return AccountModel(
        id: row.id,
        name: row.name,
        type: AccountType.fromString(row.type),
        currency: row.currency,
        initialBalance: row.initialBalance,
        currentBalance: row.currentBalance,
        linkedAccountId: row.linkedAccountId,
        billingDayOfMonth: row.billingDayOfMonth,
        colorValue: row.colorValue,
        iconName: row.iconName,
        isArchived: row.isArchived,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
    }).toList();
  }

  @override
  Future<AccountModel?> getAccountById(String id) async {
    final query = _db.select(_db.accountsTable)..where((tbl) => tbl.id.equals(id));
    final row = await query.getSingleOrNull();
    if (row == null) return null;

    return AccountModel(
      id: row.id,
      name: row.name,
      type: AccountType.fromString(row.type),
      currency: row.currency,
      initialBalance: row.initialBalance,
      currentBalance: row.currentBalance,
      linkedAccountId: row.linkedAccountId,
      billingDayOfMonth: row.billingDayOfMonth,
      colorValue: row.colorValue,
      iconName: row.iconName,
      isArchived: row.isArchived,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  @override
  Future<String> createAccount(AccountModel account) async {
    final id = account.id.isNotEmpty ? account.id : 'acc_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();

    final companion = AccountsTableCompanion.insert(
      id: id,
      name: account.name,
      type: account.type.name,
      currency: Value(account.currency),
      initialBalance: Value(account.initialBalance),
      currentBalance: Value(account.initialBalance),
      linkedAccountId: Value(account.linkedAccountId),
      billingDayOfMonth: Value(account.billingDayOfMonth),
      colorValue: Value(account.colorValue),
      iconName: Value(account.iconName),
      isArchived: Value(account.isArchived),
      createdAt: Value(now),
      updatedAt: Value(now),
    );

    await _db.into(_db.accountsTable).insert(companion);
    return id;
  }

  @override
  Future<void> updateAccount(AccountModel account) async {
    final companion = AccountsTableCompanion(
      name: Value(account.name),
      type: Value(account.type.name),
      currency: Value(account.currency),
      initialBalance: Value(account.initialBalance),
      linkedAccountId: Value(account.linkedAccountId),
      billingDayOfMonth: Value(account.billingDayOfMonth),
      colorValue: Value(account.colorValue),
      iconName: Value(account.iconName),
      isArchived: Value(account.isArchived),
      updatedAt: Value(DateTime.now()),
    );

    await (_db.update(_db.accountsTable)..where((tbl) => tbl.id.equals(account.id))).write(companion);
    await calculateAccountBalance(account.id);
  }

  @override
  Future<void> setAccountArchived(String id, bool isArchived) async {
    await (_db.update(_db.accountsTable)..where((tbl) => tbl.id.equals(id))).write(
      AccountsTableCompanion(
        isArchived: Value(isArchived),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> deleteAccount(String id) async {
    await (_db.delete(_db.accountsTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<double> calculateAccountBalance(String accountId) async {
    final account = await (_db.select(_db.accountsTable)..where((tbl) => tbl.id.equals(accountId))).getSingleOrNull();
    if (account == null) return 0.0;

    // Sum transactions for this account
    final transactions = await (_db.select(_db.transactionsTable)..where((tbl) => tbl.accountId.equals(accountId))).get();

    double incomeSum = 0.0;
    double expenseSum = 0.0;

    for (final tx in transactions) {
      if (tx.type == 'income') {
        incomeSum += (tx.amount * tx.exchangeRateToIls);
      } else if (tx.type == 'expense') {
        expenseSum += (tx.amount * tx.exchangeRateToIls);
      } else if (tx.type == 'transfer' && tx.transferLinkId != null) {
        final link = await (_db.select(_db.transferLinksTable)..where((tbl) => tbl.id.equals(tx.transferLinkId!))).getSingleOrNull();
        if (link != null) {
          if (link.sourceTransactionId == tx.id) {
            expenseSum += (tx.amount * tx.exchangeRateToIls);
          } else if (link.destinationTransactionId == tx.id) {
            incomeSum += (tx.amount * tx.exchangeRateToIls);
          }
        }
      }
    }

    final calculated = account.initialBalance + incomeSum - expenseSum;

    // Update current balance on account
    await (_db.update(_db.accountsTable)..where((tbl) => tbl.id.equals(accountId))).write(
      AccountsTableCompanion(
        currentBalance: Value(calculated),
        updatedAt: Value(DateTime.now()),
      ),
    );

    return calculated;
  }
}

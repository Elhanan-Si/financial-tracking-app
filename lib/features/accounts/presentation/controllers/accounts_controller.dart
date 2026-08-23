import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../data/repositories/accounts_repository_impl.dart';
import '../../domain/models/account_model.dart';
import '../../domain/repositories/accounts_repository.dart';

final accountsRepositoryProvider = Provider<AccountsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return AccountsRepositoryImpl(db);
});

final accountsStreamProvider = StreamProvider.family<List<AccountModel>, bool>((ref, includeArchived) {
  final repo = ref.watch(accountsRepositoryProvider);
  return repo.watchAccounts(includeArchived: includeArchived);
});

final totalLiquidBalanceProvider = Provider<double>((ref) {
  final accountsAsync = ref.watch(accountsStreamProvider(false));
  final accounts = accountsAsync.value ?? [];
  return accounts.fold<double>(0.0, (sum, acc) => sum + acc.currentBalance);
});

final accountsControllerProvider = Provider<AccountsController>((ref) {
  final repo = ref.watch(accountsRepositoryProvider);
  return AccountsController(repo);
});

class AccountsController {
  final AccountsRepository _repo;

  AccountsController(this._repo);

  Future<String> createAccount({
    required String name,
    required AccountType type,
    String currency = 'ILS',
    double initialBalance = 0.0,
    String? linkedAccountId,
    int? billingDayOfMonth,
    required int colorValue,
    required String iconName,
  }) async {
    final acc = AccountModel(
      id: '',
      name: name.trim(),
      type: type,
      currency: currency,
      initialBalance: initialBalance,
      currentBalance: initialBalance,
      linkedAccountId: linkedAccountId,
      billingDayOfMonth: billingDayOfMonth,
      colorValue: colorValue,
      iconName: iconName,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return await _repo.createAccount(acc);
  }

  Future<void> updateAccount(AccountModel account) async {
    await _repo.updateAccount(account);
  }

  Future<void> setAccountArchived(String id, bool isArchived) async {
    await _repo.setAccountArchived(id, isArchived);
  }

  Future<void> deleteAccount(String id) async {
    await _repo.deleteAccount(id);
  }

  Future<double> recalculateBalance(String id) async {
    return await _repo.calculateAccountBalance(id);
  }
}

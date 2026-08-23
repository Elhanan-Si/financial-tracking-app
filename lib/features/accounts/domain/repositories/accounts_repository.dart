import '../models/account_model.dart';

/// Repository interface for Payment Accounts and Wallets
abstract class AccountsRepository {
  Stream<List<AccountModel>> watchAccounts({bool includeArchived = false});
  Future<List<AccountModel>> getAccounts({bool includeArchived = false});
  Future<AccountModel?> getAccountById(String id);
  Future<String> createAccount(AccountModel account);
  Future<void> updateAccount(AccountModel account);
  Future<void> setAccountArchived(String id, bool isArchived);
  Future<void> deleteAccount(String id);
  Future<double> calculateAccountBalance(String accountId);
}

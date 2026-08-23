import '../models/transaction_model.dart';
import '../models/transaction_split_model.dart';

/// Repository interface for Transactions
abstract class TransactionsRepository {
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
  });

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
  });

  Future<TransactionModel?> getTransactionById(String id);
  Future<String> createTransaction(TransactionModel transaction);
  Future<String> createTransactionWithSplits(TransactionModel transaction, List<TransactionSplitModel> splits);
  Future<List<TransactionSplitModel>> getSplitsForTransaction(String transactionId);
  Future<void> updateTransaction(TransactionModel transaction, {List<TransactionSplitModel>? splits});
  Future<void> deleteTransaction(String id);
  Future<void> batchUpdateCategory(List<String> transactionIds, String categoryId);
  Future<void> batchDeleteTransactions(List<String> transactionIds);
}

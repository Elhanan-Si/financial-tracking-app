import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../accounts/presentation/controllers/accounts_controller.dart';
import '../../../categories_tags/presentation/controllers/categories_controller.dart';
import '../../data/repositories/transactions_repository_impl.dart';
import '../../domain/models/transaction_model.dart';
import '../../domain/models/transaction_split_model.dart';
import '../../domain/repositories/transactions_repository.dart';

class TransactionsFilter {
  final String type; // 'all', 'expense', 'income', 'transfer'
  final String? accountId;
  final List<String> accountIds;
  final String? categoryId;
  final List<String> categoryIds;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minAmount;
  final double? maxAmount;
  final String searchQuery;

  const TransactionsFilter({
    this.type = 'all',
    this.accountId,
    this.accountIds = const [],
    this.categoryId,
    this.categoryIds = const [],
    this.startDate,
    this.endDate,
    this.minAmount,
    this.maxAmount,
    this.searchQuery = '',
  });

  bool get hasAdvancedFilters =>
      accountIds.isNotEmpty ||
      categoryIds.isNotEmpty ||
      startDate != null ||
      endDate != null ||
      minAmount != null ||
      maxAmount != null;

  TransactionsFilter copyWith({
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
    bool clearDates = false,
    bool clearAmounts = false,
  }) {
    return TransactionsFilter(
      type: type ?? this.type,
      accountId: accountId ?? this.accountId,
      accountIds: accountIds ?? this.accountIds,
      categoryId: categoryId ?? this.categoryId,
      categoryIds: categoryIds ?? this.categoryIds,
      startDate: clearDates ? null : (startDate ?? this.startDate),
      endDate: clearDates ? null : (endDate ?? this.endDate),
      minAmount: clearAmounts ? null : (minAmount ?? this.minAmount),
      maxAmount: clearAmounts ? null : (maxAmount ?? this.maxAmount),
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  TransactionsFilter clearAll() {
    return const TransactionsFilter();
  }
}

final transactionsFilterProvider = StateProvider<TransactionsFilter>((ref) {
  return const TransactionsFilter();
});

final selectedTransactionIdsProvider = StateProvider<Set<String>>((ref) {
  return <String>{};
});

final isMultiSelectModeProvider = Provider<bool>((ref) {
  return ref.watch(selectedTransactionIdsProvider).isNotEmpty;
});

final transactionsRepositoryProvider = Provider<TransactionsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final accountsRepo = ref.watch(accountsRepositoryProvider);
  return TransactionsRepositoryImpl(db, accountsRepo);
});

final transactionsStreamProvider = StreamProvider<List<TransactionModel>>((ref) {
  final repo = ref.watch(transactionsRepositoryProvider);
  final filter = ref.watch(transactionsFilterProvider);

  return repo.watchTransactions(
    type: filter.type,
    accountId: filter.accountId,
    accountIds: filter.accountIds.isNotEmpty ? filter.accountIds : null,
    categoryId: filter.categoryId,
    categoryIds: filter.categoryIds.isNotEmpty ? filter.categoryIds : null,
    startDate: filter.startDate,
    endDate: filter.endDate,
    minAmount: filter.minAmount,
    maxAmount: filter.maxAmount,
    searchQuery: filter.searchQuery,
  );
});

final transactionSplitsProvider = FutureProvider.family<List<TransactionSplitModel>, String>((ref, txId) async {
  final repo = ref.watch(transactionsRepositoryProvider);
  return repo.getSplitsForTransaction(txId);
});

final transactionsControllerProvider = Provider<TransactionsController>((ref) {
  final repo = ref.watch(transactionsRepositoryProvider);
  final categoriesRepo = ref.watch(categoriesRepositoryProvider);
  return TransactionsController(repo, categoriesRepo);
});

class TransactionsController {
  final TransactionsRepository _repo;
  final dynamic _categoriesRepo;

  TransactionsController(this._repo, this._categoriesRepo);

  /// Fast entry with Optimistic UI execution and Merchant auto-learning
  Future<String> addTransaction({
    required String accountId,
    String? categoryId,
    String? merchantName,
    required double amount,
    required TransactionType type,
    required DateTime date,
    String? note,
    List<TransactionSplitModel>? splits,
  }) async {
    if (amount <= 0) {
      throw Exception('סכום העסקה חייב להיות גדול מ-0');
    }
    if (accountId.isEmpty) {
      throw Exception('חובה לבחור חשבון לעסקה');
    }

    if (splits != null && splits.isNotEmpty) {
      final sumSplits = splits.fold<double>(0.0, (sum, s) => sum + s.amount);
      if ((sumSplits - amount).abs() > 0.01) {
        throw Exception('סכום הפיצולים (${sumSplits.toStringAsFixed(2)}) חייב להשתוות לסכום העסקה (${amount.toStringAsFixed(2)})');
      }
    }

    String? merchantId;
    String? resolvedCategoryId = categoryId;
    bool isAutoCategorized = false;

    if (merchantName != null && merchantName.trim().isNotEmpty) {
      final merchant = await _categoriesRepo.findOrCreateMerchant(
        merchantName.trim(),
        defaultCategoryId: categoryId,
      );
      merchantId = merchant.id;

      if (resolvedCategoryId == null && merchant.defaultCategoryId != null) {
        resolvedCategoryId = merchant.defaultCategoryId;
        isAutoCategorized = true;
      }
    }

    final tx = TransactionModel(
      id: '',
      accountId: accountId,
      categoryId: resolvedCategoryId,
      merchantId: merchantId,
      merchantName: merchantName?.trim(),
      amount: amount,
      type: type,
      date: date,
      note: note?.trim(),
      hasSplits: splits != null && splits.isNotEmpty,
      isAutoCategorized: isAutoCategorized,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (splits != null && splits.isNotEmpty) {
      return await _repo.createTransactionWithSplits(tx, splits);
    } else {
      return await _repo.createTransaction(tx);
    }
  }

  Future<void> updateTransaction(TransactionModel transaction, {List<TransactionSplitModel>? splits}) async {
    if (splits != null && splits.isNotEmpty) {
      final sumSplits = splits.fold<double>(0.0, (sum, s) => sum + s.amount);
      if ((sumSplits - transaction.amount).abs() > 0.01) {
        throw Exception('סכום הפיצולים חייב להשתוות לסכום העסקה');
      }
    }
    await _repo.updateTransaction(transaction, splits: splits);
  }

  Future<void> deleteTransaction(String id) async {
    await _repo.deleteTransaction(id);
  }

  Future<void> batchUpdateCategory(List<String> transactionIds, String categoryId) async {
    await _repo.batchUpdateCategory(transactionIds, categoryId);
  }

  Future<void> batchDeleteTransactions(List<String> transactionIds) async {
    await _repo.batchDeleteTransactions(transactionIds);
  }

  Future<List<TransactionSplitModel>> getSplits(String transactionId) async {
    return await _repo.getSplitsForTransaction(transactionId);
  }
}

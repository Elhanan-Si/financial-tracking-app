import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../security/secure_storage_service.dart';
import 'connection/native_connection.dart';
import 'seed/initial_seed_data.dart';
import 'tables/accounts_table.dart';
import 'tables/assets_and_liabilities_tables.dart';
import 'tables/budgets_tables.dart';
import 'tables/categories_table.dart';
import 'tables/exchange_and_quotes_tables.dart';
import 'tables/import_tables.dart';
import 'tables/installment_tables.dart';
import 'tables/investments_tables.dart';
import 'tables/net_worth_snapshots_table.dart';
import 'tables/pension_tables.dart';
import 'tables/recurring_rules_table.dart';
import 'tables/tags_and_merchants_tables.dart';
import 'tables/transaction_splits_table.dart';
import 'tables/transactions_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    AccountsTable,
    CategoriesTable,
    TagsTable,
    MerchantsTable,
    TransactionsTable,
    TransactionSplitsTable,
    InstallmentPlansTable,
    InstallmentItemsTable,
    RecurringRulesTable,
    TransferLinksTable,
    BudgetsTable,
    BudgetPeriodsTable,
    ImportBatchesTable,
    ImportMappingsTable,
    SecuritiesTable,
    HoldingsTable,
    InvestmentTransactionsTable,
    PensionAssetsTable,
    PensionSnapshotsTable,
    AssetsTable,
    LiabilitiesTable,
    LoanSchedulesTable,
    ExchangeRatesTable,
    PriceQuotesTable,
    NetWorthSnapshotsTable,
    AppSettingsTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          // Populate initial Hebrew categories and seed defaults
          await InitialSeedData.seed(this);
        },
        beforeOpen: (details) async {
          // Enable Foreign Keys in SQLite
          await customStatement('PRAGMA foreign_keys = ON;');
        },
      );

  // === COMMON HELPER QUERIES & STREAMS ===

  /// Stream of all active accounts
  Stream<List<AccountEntry>> watchActiveAccounts() {
    return (select(accountsTable)
          ..where((tbl) => tbl.isArchived.equals(false))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt)]))
        .watch();
  }

  /// Stream of all categories
  Stream<List<CategoryEntry>> watchAllCategories() {
    return (select(categoriesTable)
          ..where((tbl) => tbl.isArchived.equals(false))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .watch();
  }

  /// Stream of parent categories
  Stream<List<CategoryEntry>> watchParentCategories({String? type}) {
    return (select(categoriesTable)
          ..where((tbl) {
            final isParent = tbl.parentId.isNull();
            final notArchived = tbl.isArchived.equals(false);
            if (type != null) {
              return isParent & notArchived & tbl.type.equals(type);
            }
            return isParent & notArchived;
          })
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .watch();
  }

  /// Stream of child subcategories for a given parent
  Stream<List<CategoryEntry>> watchSubCategories(String parentId) {
    return (select(categoriesTable)
          ..where((tbl) => tbl.parentId.equals(parentId) & tbl.isArchived.equals(false))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .watch();
  }

  /// Stream of recent transactions
  Stream<List<TransactionEntry>> watchRecentTransactions({int limit = 50}) {
    return (select(transactionsTable)
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.date, mode: OrderingMode.desc)])
          ..limit(limit))
        .watch();
  }

  /// Quick insert transaction
  Future<int> addTransaction(TransactionsTableCompanion transaction) {
    return into(transactionsTable).insert(transaction);
  }

  /// Delete transaction
  Future<int> deleteTransaction(String id) {
    return (delete(transactionsTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}

/// Provider for AppDatabase initialized with the secure encryption key
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  // In synchronous setup, we use an in-memory or lazy native connection
  final secureStorage = SecureStorageService();
  final executor = LazyDatabase(() async {
    final key = await secureStorage.getOrCreateDatabaseEncryptionKey();
    return openEncryptedConnection(encryptionKey: key);
  });
  return AppDatabase(executor);
});

import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../accounts/domain/repositories/accounts_repository.dart';
import '../../../categories_tags/domain/repositories/categories_repository.dart';
import '../../domain/models/recurring_rule_model.dart';
import '../../domain/repositories/recurring_repository.dart';

/// Drift implementation of RecurringRepository
class RecurringRepositoryImpl implements RecurringRepository {
  final AppDatabase _db;
  final AccountsRepository _accountsRepo;
  final CategoriesRepository _categoriesRepo;

  RecurringRepositoryImpl(this._db, this._accountsRepo, this._categoriesRepo);

  @override
  Stream<List<RecurringRuleModel>> watchRecurringRules({bool includePaused = true}) {
    final query = _db.select(_db.recurringRulesTable).join([
      innerJoin(_db.accountsTable, _db.accountsTable.id.equalsExp(_db.recurringRulesTable.accountId)),
      leftOuterJoin(_db.categoriesTable, _db.categoriesTable.id.equalsExp(_db.recurringRulesTable.categoryId)),
      leftOuterJoin(_db.merchantsTable, _db.merchantsTable.id.equalsExp(_db.recurringRulesTable.merchantId)),
    ]);

    if (!includePaused) {
      query.where(_db.recurringRulesTable.isPaused.equals(false));
    }

    query.orderBy([OrderingTerm(expression: _db.recurringRulesTable.nextExecutionDate, mode: OrderingMode.asc)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final rule = row.readTable(_db.recurringRulesTable);
        final acc = row.readTable(_db.accountsTable);
        final cat = row.readTableOrNull(_db.categoriesTable);
        final mer = row.readTableOrNull(_db.merchantsTable);

        return RecurringRuleModel(
          id: rule.id,
          accountId: rule.accountId,
          accountName: acc.name,
          categoryId: rule.categoryId,
          categoryName: cat?.name,
          categoryColor: cat?.colorValue,
          categoryIcon: cat?.iconName,
          merchantId: rule.merchantId,
          merchantName: mer?.name,
          name: rule.name,
          amount: rule.amount,
          frequency: RecurringFrequency.fromString(rule.frequency),
          dayOfMonth: rule.dayOfMonth,
          startDate: rule.startDate,
          endDate: rule.endDate,
          isAutoExecute: rule.isAutoExecute,
          isPaused: rule.isPaused,
          lastExecutedDate: rule.lastExecutedDate,
          nextExecutionDate: rule.nextExecutionDate,
          createdAt: rule.createdAt,
          updatedAt: rule.updatedAt,
        );
      }).toList();
    });
  }

  @override
  Future<RecurringRuleModel?> getRecurringRuleById(String id) async {
    final query = _db.select(_db.recurringRulesTable).join([
      innerJoin(_db.accountsTable, _db.accountsTable.id.equalsExp(_db.recurringRulesTable.accountId)),
      leftOuterJoin(_db.categoriesTable, _db.categoriesTable.id.equalsExp(_db.recurringRulesTable.categoryId)),
      leftOuterJoin(_db.merchantsTable, _db.merchantsTable.id.equalsExp(_db.recurringRulesTable.merchantId)),
    ]);
    query.where(_db.recurringRulesTable.id.equals(id));

    final row = await query.getSingleOrNull();
    if (row == null) return null;

    final rule = row.readTable(_db.recurringRulesTable);
    final acc = row.readTable(_db.accountsTable);
    final cat = row.readTableOrNull(_db.categoriesTable);
    final mer = row.readTableOrNull(_db.merchantsTable);

    return RecurringRuleModel(
      id: rule.id,
      accountId: rule.accountId,
      accountName: acc.name,
      categoryId: rule.categoryId,
      categoryName: cat?.name,
      categoryColor: cat?.colorValue,
      categoryIcon: cat?.iconName,
      merchantId: rule.merchantId,
      merchantName: mer?.name,
      name: rule.name,
      amount: rule.amount,
      frequency: RecurringFrequency.fromString(rule.frequency),
      dayOfMonth: rule.dayOfMonth,
      startDate: rule.startDate,
      endDate: rule.endDate,
      isAutoExecute: rule.isAutoExecute,
      isPaused: rule.isPaused,
      lastExecutedDate: rule.lastExecutedDate,
      nextExecutionDate: rule.nextExecutionDate,
      createdAt: rule.createdAt,
      updatedAt: rule.updatedAt,
    );
  }

  @override
  Future<String> createRecurringRule(RecurringRuleModel rule) async {
    final id = rule.id.isNotEmpty ? rule.id : 'rec_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();

    String? merchantId = rule.merchantId;
    if (merchantId == null && rule.merchantName != null && rule.merchantName!.trim().isNotEmpty) {
      final merchant = await _categoriesRepo.findOrCreateMerchant(rule.merchantName!.trim(), defaultCategoryId: rule.categoryId);
      merchantId = merchant.id;
    }

    final companion = RecurringRulesTableCompanion.insert(
      id: id,
      accountId: rule.accountId,
      categoryId: Value(rule.categoryId),
      merchantId: Value(merchantId),
      name: rule.name,
      amount: rule.amount,
      frequency: rule.frequency.dbValue,
      dayOfMonth: rule.dayOfMonth,
      startDate: rule.startDate,
      endDate: Value(rule.endDate),
      isAutoExecute: Value(rule.isAutoExecute),
      isPaused: Value(rule.isPaused),
      lastExecutedDate: Value(rule.lastExecutedDate),
      nextExecutionDate: rule.nextExecutionDate,
      createdAt: Value(now),
      updatedAt: Value(now),
    );

    await _db.into(_db.recurringRulesTable).insert(companion);
    return id;
  }

  @override
  Future<void> updateRecurringRule(RecurringRuleModel rule) async {
    final companion = RecurringRulesTableCompanion(
      accountId: Value(rule.accountId),
      categoryId: Value(rule.categoryId),
      merchantId: Value(rule.merchantId),
      name: Value(rule.name),
      amount: Value(rule.amount),
      frequency: Value(rule.frequency.dbValue),
      dayOfMonth: Value(rule.dayOfMonth),
      startDate: Value(rule.startDate),
      endDate: Value(rule.endDate),
      isAutoExecute: Value(rule.isAutoExecute),
      isPaused: Value(rule.isPaused),
      nextExecutionDate: Value(rule.nextExecutionDate),
      updatedAt: Value(DateTime.now()),
    );

    await (_db.update(_db.recurringRulesTable)..where((tbl) => tbl.id.equals(rule.id))).write(companion);
  }

  @override
  Future<void> setPaused(String id, bool isPaused) async {
    await (_db.update(_db.recurringRulesTable)..where((tbl) => tbl.id.equals(id))).write(
      RecurringRulesTableCompanion(
        isPaused: Value(isPaused),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> deleteRecurringRule(String id) async {
    await (_db.delete(_db.recurringRulesTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<int> executeDueRules() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final dueRules = await (_db.select(_db.recurringRulesTable)
          ..where((tbl) => tbl.isPaused.equals(false) & tbl.isAutoExecute.equals(true) & tbl.nextExecutionDate.isSmallerOrEqualValue(today)))
        .get();

    int executedCount = 0;

    for (final rule in dueRules) {
      final txId = 'tx_rec_${rule.id}_${DateTime.now().millisecondsSinceEpoch}';

      await _db.transaction(() async {
        final cat = rule.categoryId != null ? await _categoriesRepo.getCategoryById(rule.categoryId!) : null;
        final isIncome = (cat != null && cat.type == 'income') ||
            rule.name.contains('משכורת') ||
            rule.name.contains('שכר') ||
            rule.name.contains('קצבה') ||
            rule.name.contains('הכנסה');

        // Insert transaction
        await _db.into(_db.transactionsTable).insert(
              TransactionsTableCompanion.insert(
                id: txId,
                accountId: rule.accountId,
                categoryId: Value(rule.categoryId),
                merchantId: Value(rule.merchantId),
                amount: rule.amount,
                type: isIncome ? 'income' : 'expense',
                date: rule.nextExecutionDate,
                note: Value(isIncome ? 'הכנסה קבועה: ${rule.name}' : 'חיוב קבוע: ${rule.name}'),
                isRecurringInstance: const Value(true),
                recurringRuleId: Value(rule.id),
                createdAt: Value(now),
                updatedAt: Value(now),
              ),
            );

        // Calculate next date
        final freq = RecurringFrequency.fromString(rule.frequency);
        final nextDate = DateTime(
          rule.nextExecutionDate.year,
          rule.nextExecutionDate.month + freq.monthsInterval,
          rule.dayOfMonth,
        );

        // Update rule
        await (_db.update(_db.recurringRulesTable)..where((tbl) => tbl.id.equals(rule.id))).write(
          RecurringRulesTableCompanion(
            lastExecutedDate: Value(now),
            nextExecutionDate: Value(nextDate),
            updatedAt: Value(now),
          ),
        );

        await _accountsRepo.calculateAccountBalance(rule.accountId);
      });

      executedCount++;
    }

    return executedCount;
  }

  @override
  Future<double> calculateTotalMonthlyCommitments() async {
    final activeRules = await (_db.select(_db.recurringRulesTable)..where((tbl) => tbl.isPaused.equals(false))).get();

    double total = 0.0;
    for (final rule in activeRules) {
      final freq = RecurringFrequency.fromString(rule.frequency);
      switch (freq) {
        case RecurringFrequency.monthly:
          total += rule.amount;
          break;
        case RecurringFrequency.biMonthly:
          total += rule.amount / 2.0;
          break;
        case RecurringFrequency.quarterly:
          total += rule.amount / 3.0;
          break;
        case RecurringFrequency.yearly:
          total += rule.amount / 12.0;
          break;
      }
    }

    return total;
  }
}

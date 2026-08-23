import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show OrderingMode, OrderingTerm;
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/database/app_database.dart';
import '../controllers/accounts_controller.dart';

/// Screen for Detailed Account View & Filtered Transactions History
class AccountDetailScreen extends ConsumerWidget {
  final String accountId;

  const AccountDetailScreen({super.key, required this.accountId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsRepo = ref.watch(accountsRepositoryProvider);
    final db = ref.watch(appDatabaseProvider);

    return FutureBuilder(
      future: accountsRepo.getAccountById(accountId),
      builder: (context, snapshot) {
        final account = snapshot.data;
        if (account == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(account.name),
            actions: [
              IconButton(
                icon: const Icon(AppIcons.refresh),
                tooltip: 'חישוב מחדש של היתרה',
                onPressed: () async {
                  await ref.read(accountsControllerProvider).recalculateBalance(account.id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('יתרת החשבון חושבה מחדש לפי כלל התנועות ההיסטוריות'),
                        backgroundColor: AppColors.income,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
          ),
          body: ListView(
            padding: AppSpacing.screenPadding,
            children: [
              // Account Hero Card
              Card(
                child: Padding(
                  padding: AppSpacing.cardPadding,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: account.color.withValues(alpha: 0.15),
                        child: Icon(account.icon, color: account.color, size: 28),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        account.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        account.type.label,
                        style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        CurrencyFormatter.formatILS(account.currentBalance),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'יתרה ראשונית: ${CurrencyFormatter.formatILS(account.initialBalance)}',
                            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                          ),
                          if (account.billingDayOfMonth != null) ...[
                            const SizedBox(width: AppSpacing.md),
                            Text(
                              'חיוב ב-${account.billingDayOfMonth} לחודש',
                              style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Filtered Transactions Header
              const Text(
                'היסטוריית תנועות בחשבון',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: AppSpacing.sm),

              // Stream of transactions for this account
              StreamBuilder<List<TransactionEntry>>(
                stream: (db.select(db.transactionsTable)
                      ..where((tbl) => tbl.accountId.equals(account.id))
                      ..orderBy([(tbl) => OrderingTerm(expression: tbl.date, mode: OrderingMode.desc)]))
                    .watch(),
                builder: (context, txSnapshot) {
                  final transactions = txSnapshot.data ?? [];
                  if (transactions.isEmpty) {
                    return const Card(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.xl),
                        child: Center(
                          child: Text('אין תנועות בחשבון זה עדיין'),
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: transactions.map((tx) {
                      final isExpense = tx.type == 'expense';
                      final isIncome = tx.type == 'income';
                      final color = isExpense
                          ? AppColors.expense
                          : isIncome
                              ? AppColors.income
                              : AppColors.transfer;

                      return Card(
                        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: color.withValues(alpha: 0.12),
                            child: Icon(
                              isExpense
                                  ? AppIcons.expense
                                  : isIncome
                                      ? AppIcons.income
                                      : AppIcons.transfer,
                              color: color,
                              size: 18,
                            ),
                          ),
                          title: Text(
                            tx.note?.isNotEmpty == true ? tx.note! : (isExpense ? 'הוצאה' : 'הכנסה'),
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          subtitle: Text(
                            '${tx.date.day}/${tx.date.month}/${tx.date.year}',
                            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                          ),
                          trailing: Text(
                            CurrencyFormatter.formatSignedILS(tx.amount, isExpense: isExpense),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: color,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

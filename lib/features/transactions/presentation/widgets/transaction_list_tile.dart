import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/models/transaction_model.dart';

/// Clean list tile for a transaction with category badges and RTL layout
class TransactionListTile extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback? onTap;

  const TransactionListTile({
    super.key,
    required this.transaction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final title = transaction.merchantName?.isNotEmpty == true
        ? transaction.merchantName!
        : (transaction.note?.isNotEmpty == true
            ? transaction.note!
            : (transaction.isExpense
                ? 'הוצאה'
                : (transaction.isIncome ? 'הכנסה' : 'העברה פנימית')));

    final subtextParts = <String>[];
    if (transaction.categoryName != null) {
      subtextParts.add(transaction.categoryName!);
    }
    if (transaction.accountName != null) {
      subtextParts.add(transaction.accountName!);
    }
    subtextParts.add(AppDateFormatter.formatRelativeDate(transaction.date));

    final iconColor = transaction.categoryColor != null
        ? Color(transaction.categoryColor!)
        : transaction.displayColor;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 4),
        leading: CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.12),
          child: Icon(transaction.displayIcon, color: iconColor, size: 20),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (transaction.isAutoCategorized) ...[
              const SizedBox(width: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: AppSpacing.roundedSm,
                ),
                child: const Text(
                  'אוטומטי',
                  style: TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          subtextParts.join(' • '),
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          CurrencyFormatter.formatSignedILS(transaction.amount, isExpense: transaction.isExpense),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: transaction.displayColor,
          ),
        ),
      ),
    );
  }
}

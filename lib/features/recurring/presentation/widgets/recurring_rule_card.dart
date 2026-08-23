import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/models/recurring_rule_model.dart';

/// Card component for recurring rule / subscription
class RecurringRuleCard extends StatelessWidget {
  final RecurringRuleModel rule;
  final VoidCallback onEdit;
  final VoidCallback onTogglePause;
  final VoidCallback onDelete;

  const RecurringRuleCard({
    super.key,
    required this.rule,
    required this.onEdit,
    required this.onTogglePause,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: Column(
          children: [
            Row(
              children: [
                // Category Icon
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: rule.isPaused ? AppColors.surfaceVariant : rule.color.withAlpha(30),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    rule.icon,
                    color: rule.isPaused ? AppColors.textSecondary : rule.color,
                    size: 22,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),

                // Name, Account & Frequency
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              rule.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                decoration: rule.isPaused ? TextDecoration.lineThrough : null,
                              ),
                            ),
                          ),
                          if (rule.isPaused) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceVariant,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('מושהה', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${rule.frequency.label} • ${rule.accountName ?? 'חשבון'} • ב-${rule.dayOfMonth} לחודש',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),

                // Amount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${rule.isIncome ? '+' : ''}${CurrencyFormatter.formatILS(rule.amount)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: rule.isPaused
                            ? AppColors.textSecondary
                            : (rule.isIncome ? AppColors.income : AppColors.expense),
                      ),
                    ),
                    if (rule.frequency != RecurringFrequency.monthly)
                      Text(
                        '(${CurrencyFormatter.formatILS(rule.monthlyNormalizedAmount)} /חודש)',
                        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      ),
                  ],
                ),
              ],
            ),
            const Divider(height: AppSpacing.md),

            // Footer: Next Execution & Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      const Icon(AppIcons.calendar, size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '${rule.isIncome ? 'זיכוי הבא' : 'חיוב הבא'}: ${AppDateFormatter.formatShortDate(rule.nextExecutionDate)}',
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        rule.isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                        size: 18,
                        color: rule.isPaused ? AppColors.success : AppColors.warning,
                      ),
                      tooltip: rule.isPaused ? 'הפעל מחדש' : 'השהה הוראת קבע',
                      onPressed: onTogglePause,
                    ),
                    IconButton(
                      icon: const Icon(AppIcons.edit, size: 18),
                      tooltip: 'עריכה',
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: const Icon(AppIcons.delete, size: 18, color: AppColors.error),
                      tooltip: 'מחיקה',
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

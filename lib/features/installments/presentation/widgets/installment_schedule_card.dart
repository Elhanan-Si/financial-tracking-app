import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/models/installment_plan_model.dart';

/// Card showing Installment Plan schedule & payment progress
class InstallmentScheduleCard extends StatelessWidget {
  final InstallmentPlanModel plan;
  final VoidCallback? onCancelRemaining;
  final VoidCallback? onDelete;

  const InstallmentScheduleCard({
    super.key,
    required this.plan,
    this.onCancelRemaining,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final progress = plan.numberOfInstallments > 0 ? plan.paidCount / plan.numberOfInstallments : 0.0;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Merchant / Note & Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.merchantName ?? (plan.note ?? 'עסקת תשלומים'),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '${plan.accountName ?? 'חשבון'} • ${plan.categoryName ?? 'ללא קטגוריה'}',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                Text(
                  CurrencyFormatter.formatILS(plan.totalAmount),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.expense),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Progress Bar & Stats
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: AppColors.divider,
                valueColor: AlwaysStoppedAnimation<Color>(
                  plan.isCompleted ? AppColors.success : AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'שולמו ${plan.paidCount} מתוך ${plan.numberOfInstallments} תשלומים',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Text(
                  'נותר: ${CurrencyFormatter.formatILS(plan.remainingAmount)}',
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
            const Divider(height: AppSpacing.lg),

            // Schedule Items Expansion
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                leading: const Icon(AppIcons.calendar, size: 20, color: AppColors.primary),
                title: const Text('לוח חיובים עתידי', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                children: plan.items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              item.isPaid ? AppIcons.check : AppIcons.time,
                              size: 16,
                              color: item.isPaid ? AppColors.success : AppColors.textSecondary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'תשלום ${item.installmentNumber}/${plan.numberOfInstallments}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: item.isPaid ? FontWeight.w700 : FontWeight.normal,
                                color: item.isPaid ? AppColors.textPrimary : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          AppDateFormatter.formatShortDate(item.dueDate),
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        Text(
                          CurrencyFormatter.formatILS(item.amount),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: item.isPaid ? AppColors.expense : AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Actions
            if (!plan.isCompleted && onCancelRemaining != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: onCancelRemaining,
                  icon: const Icon(AppIcons.close, size: 16, color: AppColors.warning),
                  label: const Text('ביטול יתרת התשלומים העתידיים', style: TextStyle(color: AppColors.warning, fontSize: 12)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../domain/models/account_model.dart';

/// Interactive Card displaying an Account with balance and metadata
class AccountCard extends StatelessWidget {
  final AccountModel account;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onToggleArchive;

  const AccountCard({
    super.key,
    required this.account,
    this.onTap,
    this.onEdit,
    this.onToggleArchive,
  });

  @override
  Widget build(BuildContext context) {
    final isNegative = account.currentBalance < 0;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppSpacing.roundedLg,
        child: Padding(
          padding: AppSpacing.cardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Icon, Name, Type Badge, Menu
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: account.color.withValues(alpha: 0.15),
                    child: Icon(account.icon, color: account.color, size: 22),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account.name,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceVariant,
                                borderRadius: AppSpacing.roundedSm,
                              ),
                              child: Text(
                                account.type.label,
                                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                              ),
                            ),
                            if (account.isArchived) ...[
                              const SizedBox(width: AppSpacing.xs),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                decoration: BoxDecoration(
                                  color: AppColors.warningLight,
                                  borderRadius: AppSpacing.roundedSm,
                                ),
                                child: const Text(
                                  'בארכיון',
                                  style: TextStyle(fontSize: 10, color: AppColors.warning, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (onEdit != null || onToggleArchive != null)
                    PopupMenuButton<String>(
                      icon: const Icon(AppIcons.more, color: AppColors.textMuted),
                      onSelected: (val) {
                        if (val == 'edit' && onEdit != null) onEdit!();
                        if (val == 'archive' && onToggleArchive != null) onToggleArchive!();
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'edit', child: Text('עריכת חשבון')),
                        PopupMenuItem(
                          value: 'archive',
                          child: Text(account.isArchived ? 'שחזור מארכיון' : 'העבר לארכיון'),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // Balance Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text(
                    'יתרה נוכחית:',
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                  Text(
                    CurrencyFormatter.formatILS(account.currentBalance),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: isNegative ? AppColors.expense : AppColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),

              // Credit Card Extra Details (Billing day & payoff account)
              if (account.type == AccountType.creditCard) ...[
                const SizedBox(height: AppSpacing.sm),
                const Divider(height: 1),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'יום חיוב: ${account.billingDayOfMonth ?? 10} לחודש',
                      style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                    ),
                    if (account.linkedAccountName != null)
                      Text(
                        'מקושר ל: ${account.linkedAccountName}',
                        style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

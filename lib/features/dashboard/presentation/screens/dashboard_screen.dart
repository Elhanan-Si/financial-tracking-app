import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_names.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../transactions/presentation/screens/fast_entry_modal.dart';
import '../../../../core/database/app_database.dart';
import '../../../budgets/presentation/controllers/budgets_controller.dart';
import '../../../insights_analytics/domain/models/financial_brief_model.dart';
import '../../../insights_analytics/presentation/controllers/insights_controller.dart';
import '../../../net_worth/presentation/controllers/net_worth_controller.dart';

/// Screen 1: Main Dashboard (דשבורד ראשי משודרג - TASK-30)
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);
    final now = DateTime.now();
    final yearMonth = '${now.year}-${now.month.toString().padLeft(2, '0')}';

    final netWorthAsync = ref.watch(netWorthSummaryStreamProvider);
    final briefAsync = ref.watch(monthlyFinancialBriefFutureProvider(now));
    final budgetsAsync = ref.watch(monthlyBudgetSummaryProvider(yearMonth));
    final savingsAsync = ref.watch(savingsRateMetricsFutureProvider(now));

    return Scaffold(
      appBar: AppBar(
        title: const Text('דשבורד פיננסי'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.netWorth),
            tooltip: 'שווי נקי כולל',
            onPressed: () => context.push('/investments/net-worth'),
          ),
          IconButton(
            icon: const Icon(AppIcons.trendingUp),
            tooltip: 'תובנות וניתוחים',
            onPressed: () => context.push('/investments/insights'),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'dashboard_fab',
        onPressed: () => FastEntryModal.show(context),
        icon: const Icon(AppIcons.add),
        label: const Text('הזנה מהירה'),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          // 1. Hebrew Natural Language Financial Brief Hero
          briefAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (brief) => _buildFinancialBriefCard(brief),
          ),
          const SizedBox(height: AppSpacing.md),

          // 2. Net Worth & Financial Balance Hero Card
          netWorthAsync.when(
            loading: () => _buildBalanceHeroSkeleton(),
            error: (err, _) => Center(child: Text('שגיאה: $err')),
            data: (nw) {
              return savingsAsync.maybeWhen(
                data: (savings) => _buildBalanceHeroCard(context, nw.totalNetWorth, savings.currentMonthSavingsRate, nw.totalShortTermLiabilities),
                orElse: () => _buildBalanceHeroCard(context, nw.totalNetWorth, 0.0, nw.totalShortTermLiabilities),
              );
            },
          ),
          const SizedBox(height: AppSpacing.lg),

          // 3. Budgets At-Risk Alert Banner (Live)
          budgetsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (summary) {
              final atRisk = summary.items.where((b) => b.isOverBudget || b.burnRateStatus != 'safe').toList();
              if (atRisk.isEmpty) return const SizedBox.shrink();
              return _buildBudgetRiskBanner(context, atRisk);
            },
          ),

          // 4. Current Month Income vs Expense
          savingsAsync.maybeWhen(
            data: (savings) => _buildIncomeExpenseRow(savings.currentMonthIncome, savings.currentMonthExpenses),
            orElse: () => _buildIncomeExpenseRow(0.0, 0.0),
          ),
          const SizedBox(height: AppSpacing.xl),

          // 5. Active Accounts Section
          _buildSectionHeader('חשבונות פעילים', onAction: () => context.go(AppRoutes.transactions)),
          const SizedBox(height: AppSpacing.sm),
          _buildAccountsList(db),
          const SizedBox(height: AppSpacing.xl),

          // 6. Quick Insights Entry Tiles
          _buildSectionHeader('תובנות וניתוחים מהירים'),
          const SizedBox(height: AppSpacing.sm),
          _buildQuickNavigationTiles(context),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildFinancialBriefCard(FinancialBriefModel brief) {
    Color cardBg;
    Color iconColor;
    IconData icon;

    switch (brief.sentiment) {
      case BriefSentiment.positive:
        cardBg = AppColors.incomeLight;
        iconColor = AppColors.income;
        icon = AppIcons.successCircle;
        break;
      case BriefSentiment.warning:
        cardBg = AppColors.warningLight;
        iconColor = AppColors.warning;
        icon = AppIcons.alert;
        break;
      case BriefSentiment.neutral:
        cardBg = AppColors.primaryLight;
        iconColor = AppColors.primary;
        icon = AppIcons.infoCircle;
        break;
    }

    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: AppSpacing.roundedMd,
        border: Border.all(color: iconColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  brief.headline,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: iconColor),
                ),
              ),
            ],
          ),
          if (brief.bulletPoints.isNotEmpty) ...[
            const SizedBox(height: 6),
            ...brief.bulletPoints.map((bp) => Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                      Expanded(
                        child: Text(bp, style: const TextStyle(fontSize: 12, color: AppColors.textPrimary)),
                      ),
                    ],
                  ),
                )),
          ],
        ],
      ),
    );
  }

  Widget _buildBalanceHeroSkeleton() {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.roundedXl,
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildBalanceHeroCard(BuildContext context, double netWorth, double savingsRate, double shortTermDebt) {
    return InkWell(
      onTap: () => context.push('/investments/net-worth'),
      borderRadius: AppSpacing.roundedXl,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: AppSpacing.roundedXl,
          boxShadow: AppSpacing.elevatedShadow,
        ),
        padding: AppSpacing.modalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'סה"כ שווי נקי כולל',
                  style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: AppSpacing.roundedSm,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(AppIcons.netWorth, size: 14, color: Colors.white),
                      SizedBox(width: 4),
                      Text('למאזן המלא', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              CurrencyFormatter.formatILS(netWorth, showDecimals: false),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.5),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Divider(color: Colors.white24, height: 1),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeroStat('שיעור חיסכון החודש', '${savingsRate.toStringAsFixed(1)}%'),
                _buildHeroStat('חיובי אשראי והלוואות קצרות', CurrencyFormatter.formatILS(shortTermDebt)),
                _buildHeroStat('מאזן פיננסי', 'תקין'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroStat(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white60, fontSize: 11)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _buildBudgetRiskBanner(BuildContext context, List<dynamic> atRisk) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.expenseLight,
        borderRadius: AppSpacing.roundedMd,
        border: Border.all(color: AppColors.expense.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(AppIcons.alert, color: AppColors.expense, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'שים לב: ישנם ${atRisk.length} תקציבים בסיכון חריגה החודש',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.expense),
            ),
          ),
          TextButton(
            onPressed: () => context.go(AppRoutes.budgets),
            child: const Text('לתקציבים', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeExpenseRow(double income, double expenses) {
    final net = income - expenses;
    final isPositive = net >= 0;

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            title: 'הכנסות החודש',
            amount: income,
            icon: AppIcons.income,
            color: AppColors.income,
            lightColor: AppColors.incomeLight,
            subtext: 'תקבולים שוטפים',
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _buildSummaryCard(
            title: 'הוצאות החודש',
            amount: expenses,
            icon: AppIcons.expense,
            color: AppColors.expense,
            lightColor: AppColors.expenseLight,
            subtext: isPositive ? 'מאזן חיובי: ${CurrencyFormatter.formatCompactILS(net)}' : 'גירעון: ${CurrencyFormatter.formatCompactILS(net.abs())}',
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required double amount,
    required IconData icon,
    required Color color,
    required Color lightColor,
    required String subtext,
  }) {
    return Card(
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: lightColor, borderRadius: AppSpacing.roundedSm),
                  child: Icon(icon, color: color, size: 18),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              CurrencyFormatter.formatILS(amount, showDecimals: false),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: color),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(subtext, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onAction}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        if (onAction != null)
          TextButton(
            onPressed: onAction,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('הצג הכל', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                SizedBox(width: 4),
                Icon(AppIcons.chevronRight, size: 14),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildAccountsList(AppDatabase db) {
    return StreamBuilder<List<AccountEntry>>(
      stream: db.watchActiveAccounts(),
      builder: (context, snapshot) {
        final accounts = snapshot.data ?? [];
        if (accounts.isEmpty) {
          return const Card(
            child: Padding(
              padding: AppSpacing.cardPadding,
              child: Center(child: Text('טוען חשבונות...')),
            ),
          );
        }

        return Column(
          children: accounts.map((acc) {
            final icon = AppIcons.fromString(acc.iconName, fallback: AppIcons.bank);
            return Card(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(acc.colorValue).withValues(alpha: 0.15),
                  child: Icon(icon, color: Color(acc.colorValue)),
                ),
                title: Text(acc.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(
                  acc.type == 'creditCard' ? 'חיוב ב-${acc.billingDayOfMonth ?? 10} לחודש' : 'חשבון שקלי',
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: Text(
                  CurrencyFormatter.formatILS(acc.currentBalance),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildQuickNavigationTiles(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => context.push('/investments/insights'),
            borderRadius: AppSpacing.roundedMd,
            child: Card(
              child: Padding(
                padding: AppSpacing.cardPadding,
                child: Column(
                  children: [
                    const Icon(AppIcons.budgets, size: 28, color: AppColors.primary),
                    const SizedBox(height: 8),
                    const Text('מודל 50/30/20', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                    const SizedBox(height: 2),
                    const Text('צרכים ומותרות', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: InkWell(
            onTap: () => context.push('/investments/insights'),
            borderRadius: AppSpacing.roundedMd,
            child: Card(
              child: Padding(
                padding: AppSpacing.cardPadding,
                child: Column(
                  children: [
                    const Icon(AppIcons.trendingUp, size: 28, color: AppColors.income),
                    const SizedBox(height: 8),
                    const Text('שיעור חיסכון', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                    const SizedBox(height: 2),
                    const Text('ממוצעים נעים', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: InkWell(
            onTap: () => context.push('/investments/net-worth'),
            borderRadius: AppSpacing.roundedMd,
            child: Card(
              child: Padding(
                padding: AppSpacing.cardPadding,
                child: Column(
                  children: [
                    const Icon(AppIcons.netWorth, size: 28, color: AppColors.secondary),
                    const SizedBox(height: 8),
                    const Text('שווי נקי', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                    const SizedBox(height: 2),
                    const Text('פילוח נכסים', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

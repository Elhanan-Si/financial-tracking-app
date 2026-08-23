import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../cash_flow/presentation/screens/cash_flow_forecast_screen.dart';
import '../../../cash_flow/presentation/screens/credit_card_forecast_screen.dart';
import '../controllers/budgets_controller.dart';
import 'budget_planning_screen.dart';

/// Screen 13: Real-Time Budget Tracking & Burn Rate (מעקב ניצול תקציב חודשי בזמן אמת)
class BudgetsScreen extends ConsumerWidget {
  const BudgetsScreen({super.key});

  String _formatHebrewMonth(String yearMonth) {
    final parts = yearMonth.split('-');
    final date = DateTime(int.parse(parts[0]), int.parse(parts[1]), 1);
    final monthName = DateFormat('MMMM', 'he_IL').format(date);
    return '$monthName ${date.year}';
  }

  void _changeMonth(WidgetRef ref, String currentYm, int offset) {
    final parts = currentYm.split('-');
    final current = DateTime(int.parse(parts[0]), int.parse(parts[1]), 1);
    final newDate = DateTime(current.year, current.month + offset, 1);
    ref.read(selectedBudgetMonthProvider.notifier).state = DateFormat('yyyy-MM').format(newDate);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMonth = ref.watch(selectedBudgetMonthProvider);
    final summaryAsync = ref.watch(monthlyBudgetSummaryProvider(selectedMonth));

    return Scaffold(
      appBar: AppBar(
        title: const Text('תקציב ומעקב יעדים'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.edit),
            tooltip: 'תכנון תקציב חודשי',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BudgetPlanningScreen(initialYearMonth: selectedMonth),
                ),
              );
            },
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'budgets_plan_fab',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BudgetPlanningScreen(initialYearMonth: selectedMonth),
            ),
          );
        },
        icon: const Icon(AppIcons.edit),
        label: const Text('הגדרת תקציב'),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          // 1. Month Selector Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(AppIcons.chevronLeft),
                  tooltip: 'חודש קודם',
                  onPressed: () => _changeMonth(ref, selectedMonth, -1),
                ),
                Text(
                  _formatHebrewMonth(selectedMonth),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                IconButton(
                  icon: const Icon(AppIcons.chevronRight),
                  tooltip: 'חודש הבא',
                  onPressed: () => _changeMonth(ref, selectedMonth, 1),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Quick Forecast Nav Bar
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreditCardForecastScreen()),
                    );
                  },
                  icon: const Icon(AppIcons.creditCard, size: 16),
                  label: const Text('חיובי אשראי', style: TextStyle(fontSize: 12)),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CashFlowForecastScreen()),
                    );
                  },
                  icon: const Icon(AppIcons.trendingUp, size: 16),
                  label: const Text('תחזית תזרים', style: TextStyle(fontSize: 12)),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // 2. Summary Async Data
          summaryAsync.when(
            data: (summary) {
              if (summary.items.isEmpty) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Column(
                      children: [
                        const Icon(AppIcons.budgets, size: 48, color: AppColors.primary),
                        const SizedBox(height: AppSpacing.md),
                        const Text(
                          'טרם הוגדר תקציב לחודש זה',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        const Text(
                          'לחץ על "הגדרת תקציב" או שכפל את התקציב מהחודש הקודם.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BudgetPlanningScreen(initialYearMonth: selectedMonth),
                              ),
                            );
                          },
                          icon: const Icon(AppIcons.add),
                          label: const Text('תכנן תקציב עכשיו'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final percent = summary.totalPercentageUtilized.clamp(0.0, 1.0);
              final isOver = summary.totalActualSpent > summary.totalEffectiveBudget;
              final daysLeft = summary.items.first.daysInMonth - summary.items.first.currentDayOfMonth + 1;
              final dailyAllowance = daysLeft > 0 ? (summary.totalRemaining / daysLeft).clamp(0.0, double.infinity) : 0.0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overall Budget Card
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isOver
                            ? [const Color(0xFFEF4444), const Color(0xFF991B1B)]
                            : [AppColors.primary, AppColors.primaryDark],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: (isOver ? const Color(0xFFEF4444) : AppColors.primary).withAlpha(60),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'ניצול תקציב כולל',
                              style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(50),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${(summary.totalPercentageUtilized * 100).toStringAsFixed(1)}% נוצלו',
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              CurrencyFormatter.formatILS(summary.totalActualSpent),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              'מתוך ${CurrencyFormatter.formatILS(summary.totalEffectiveBudget)}',
                              style: const TextStyle(color: Colors.white70, fontSize: 13),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: percent,
                            minHeight: 8,
                            backgroundColor: Colors.white24,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isOver ? Colors.white : (percent > 0.85 ? const Color(0xFFFCD34D) : const Color(0xFF6EE7B7)),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isOver
                                  ? 'חריגה של ${CurrencyFormatter.formatILS(summary.totalActualSpent - summary.totalEffectiveBudget)}'
                                  : 'נותרו ${CurrencyFormatter.formatILS(summary.totalRemaining)} ל-$daysLeft ימים',
                              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            if (!isOver)
                              Text(
                                '${CurrencyFormatter.formatILS(dailyAllowance)} ליום',
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Warning Banner if any category is over budget
                  if (summary.overBudgetCategoriesCount > 0) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.expenseLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.expense.withAlpha(60)),
                      ),
                      child: Row(
                        children: [
                          const Icon(AppIcons.alert, color: AppColors.expense, size: 20),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              'שים לב: זוהתה חריגה ב-${summary.overBudgetCategoriesCount} קטגוריות החודש.',
                              style: const TextStyle(
                                color: AppColors.expenseDark,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],

                  // Category Breakdown Header
                  const Text(
                    'ניצול לפי קטגוריות הוצאה',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Category Progress Cards List
                  Column(
                    children: summary.items.map((item) {
                      final cat = item.budget;
                      final percent = item.percentageUtilized.clamp(0.0, 1.0);

                      return Card(
                        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: Padding(
                          padding: AppSpacing.cardPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: cat.color.withAlpha(35),
                                    child: Icon(cat.icon, color: cat.color, size: 20),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                cat.categoryName ?? 'קטגוריה',
                                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            if (item.rolloverBalance != 0) ...[
                                              const SizedBox(width: 4),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                                decoration: BoxDecoration(
                                                  color: item.rolloverBalance > 0
                                                      ? AppColors.incomeLight
                                                      : AppColors.expenseLight,
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  item.rolloverBalance > 0
                                                      ? '+${item.rolloverBalance.toStringAsFixed(0)} מגולגל'
                                                      : '${item.rolloverBalance.toStringAsFixed(0)} גרעון',
                                                  style: TextStyle(
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w700,
                                                    color: item.rolloverBalance > 0
                                                        ? AppColors.incomeDark
                                                        : AppColors.expenseDark,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        Text(
                                          item.isOverBudget
                                              ? 'חריגה של ${CurrencyFormatter.formatILS(item.actualSpent - item.effectiveBudget)}'
                                              : 'נותרו ${CurrencyFormatter.formatILS(item.remainingBudget)}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: item.isOverBudget ? AppColors.expense : AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${CurrencyFormatter.formatILS(item.actualSpent)} / ${CurrencyFormatter.formatILS(item.effectiveBudget)}',
                                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                                      ),
                                      Text(
                                        '${(item.percentageUtilized * 100).toStringAsFixed(0)}%',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: item.statusColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: percent,
                                  minHeight: 6,
                                  backgroundColor: AppColors.surfaceVariant,
                                  valueColor: AlwaysStoppedAnimation<Color>(item.statusColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('שגיאה בטעינת תקציב: $err')),
          ),
        ],
      ),
    );
  }
}

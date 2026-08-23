import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../accounts/presentation/controllers/accounts_controller.dart';
import '../../../categories_tags/presentation/controllers/categories_controller.dart';
import '../controllers/recurring_controller.dart';
import '../widgets/recurring_edit_dialog.dart';
import '../widgets/recurring_rule_card.dart';

/// Screen 5: Recurring Subscriptions, Standing Orders & Fixed Incomes (הוראות קבע, מנויים והכנסות קבועות)
class RecurringListScreen extends ConsumerStatefulWidget {
  const RecurringListScreen({super.key});

  @override
  ConsumerState<RecurringListScreen> createState() => _RecurringListScreenState();
}

class _RecurringListScreenState extends ConsumerState<RecurringListScreen> {
  bool _showPaused = true;
  int _selectedFilterIndex = 0; // 0: הכל, 1: הוצאות ומנויים, 2: הכנסות קבועות (משכורת)

  @override
  Widget build(BuildContext context) {
    final rulesAsync = ref.watch(recurringRulesStreamProvider(_showPaused));
    final accountsAsync = ref.watch(accountsStreamProvider(false));
    final categoriesAsync = ref.watch(allCategoriesStreamProvider(null));

    final accounts = accountsAsync.value ?? [];
    final categories = categoriesAsync.value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('הוראות קבע והכנסות קבועות'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.refresh),
            tooltip: 'בדוק ובצע חיובים והכנסות שהגיע מועדם',
            onPressed: () async {
              final count = await ref.read(recurringControllerProvider).checkAndExecuteDueRules();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(count > 0 ? 'בוצעו $count תנועות מחזוריות' : 'אין תנועות הממתינות לביצוע כעת'),
                    backgroundColor: AppColors.income,
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'recurring_add_fab',
        onPressed: () {
          RecurringEditDialog.show(
            context,
            accounts: accounts,
            categories: categories,
            onSave: (newRule) async {
              await ref.read(recurringControllerProvider).addRecurringRule(newRule);
            },
          );
        },
        icon: const Icon(AppIcons.add),
        label: const Text('הוספת הוראה קבועה / משכורת'),
      ),
      body: rulesAsync.when(
        data: (allRules) {
          final incomeRules = allRules.where((r) => r.isIncome).toList();
          final expenseRules = allRules.where((r) => !r.isIncome).toList();

          final totalIncome = incomeRules.where((r) => !r.isPaused).fold<double>(0.0, (sum, r) => sum + r.monthlyNormalizedAmount);
          final totalExpense = expenseRules.where((r) => !r.isPaused).fold<double>(0.0, (sum, r) => sum + r.monthlyNormalizedAmount);
          final netFixedCashFlow = totalIncome - totalExpense;

          List filteredRules = allRules;
          if (_selectedFilterIndex == 1) {
            filteredRules = expenseRules;
          } else if (_selectedFilterIndex == 2) {
            filteredRules = incomeRules;
          }

          return ListView(
            padding: AppSpacing.screenPadding,
            children: [
              // Total Monthly Fixed Cash Flow Card
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withAlpha(60),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(AppIcons.recurring, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'תזרים קבוע חודשי מתוכנן',
                              style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${netFixedCashFlow >= 0 ? '+' : ''}${CurrencyFormatter.formatILS(netFixedCashFlow)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const Divider(color: Colors.white24, height: 1),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('הכנסות קבועות (משכורת)', style: TextStyle(color: Colors.white70, fontSize: 11)),
                              const SizedBox(height: 2),
                              Text(
                                CurrencyFormatter.formatILS(totalIncome),
                                style: const TextStyle(color: Color(0xFF86EFAC), fontSize: 16, fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 1, height: 32, color: Colors.white24),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('התחייבויות ומנויים', style: TextStyle(color: Colors.white70, fontSize: 11)),
                              const SizedBox(height: 2),
                              Text(
                                CurrencyFormatter.formatILS(totalExpense),
                                style: const TextStyle(color: Color(0xFFFCA5A5), fontSize: 16, fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Filter Segmented Buttons
              SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 0, label: Text('הכל')),
                  ButtonSegment(value: 1, label: Text('הוצאות ומנויים')),
                  ButtonSegment(value: 2, label: Text('הכנסות (משכורת)')),
                ],
                selected: {_selectedFilterIndex},
                onSelectionChanged: (set) => setState(() => _selectedFilterIndex = set.first),
              ),
              const SizedBox(height: AppSpacing.md),

              // Filter Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedFilterIndex == 2
                        ? 'הכנסות קבועות (${incomeRules.length})'
                        : (_selectedFilterIndex == 1
                            ? 'מנויים והוראות קבע (${expenseRules.length})'
                            : 'כל ההוראות הקבועות (${allRules.length})'),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      const Text('הצג מושהים', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      Switch(
                        value: _showPaused,
                        onChanged: (val) => setState(() => _showPaused = val),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),

              // Rules Stream List
              if (filteredRules.isEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Center(
                      child: Text(
                        _selectedFilterIndex == 2
                            ? 'אין הכנסות קבועות מוגדרות.\nלחץ למטה כדי להגדיר משכורת או קצבה.'
                            : 'אין הוראות קבע פעילות.\nלחץ למטה כדי להוסיף.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  ),
                )
              else
                Column(
                  children: filteredRules.map((rule) {
                    return RecurringRuleCard(
                      rule: rule,
                      onEdit: () {
                        RecurringEditDialog.show(
                          context,
                          initialRule: rule,
                          accounts: accounts,
                          categories: categories,
                          onSave: (updated) async {
                            await ref.read(recurringControllerProvider).updateRecurringRule(updated);
                          },
                        );
                      },
                      onTogglePause: () async {
                        await ref.read(recurringControllerProvider).togglePause(rule.id, rule.isPaused);
                      },
                      onDelete: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('מחיקת הוראה קבועה'),
                            content: Text('האם למחוק את "${rule.name}"?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('ביטול')),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text('מחק'),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          await ref.read(recurringControllerProvider).deleteRule(rule.id);
                        }
                      },
                    );
                  }).toList(),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('שגיאה בטעינת הוראות קבע: $err')),
      ),
    );
  }
}

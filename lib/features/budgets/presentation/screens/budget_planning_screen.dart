import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/financial_info_tooltip.dart';
import '../../../categories_tags/domain/models/category_model.dart';
import '../../../categories_tags/presentation/controllers/categories_controller.dart';
import '../controllers/budgets_controller.dart';

/// Screen 12: Monthly Budget Planning & Configuration (תכנון תקציב חודשי לפי קטגוריות)
class BudgetPlanningScreen extends ConsumerStatefulWidget {
  final String? initialYearMonth;

  const BudgetPlanningScreen({super.key, this.initialYearMonth});

  @override
  ConsumerState<BudgetPlanningScreen> createState() => _BudgetPlanningScreenState();
}

class _BudgetPlanningScreenState extends ConsumerState<BudgetPlanningScreen> {
  late String _selectedYearMonth;
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, bool> _rolloverMap = {};
  final _incomeController = TextEditingController(text: '18000');
  String _selectedModel = '50_30_20'; // '50_30_20', '70_20_10', '60_20_20', 'history'

  @override
  void initState() {
    super.initState();
    _selectedYearMonth = widget.initialYearMonth ?? ref.read(selectedBudgetMonthProvider);
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    _incomeController.dispose();
    super.dispose();
  }

  String _formatHebrewMonth(String yearMonth) {
    final parts = yearMonth.split('-');
    final date = DateTime(int.parse(parts[0]), int.parse(parts[1]), 1);
    final monthName = DateFormat('MMMM', 'he_IL').format(date);
    return '$monthName ${date.year}';
  }

  void _changeMonth(int offset) {
    final parts = _selectedYearMonth.split('-');
    final current = DateTime(int.parse(parts[0]), int.parse(parts[1]), 1);
    final newDate = DateTime(current.year, current.month + offset, 1);
    setState(() {
      _selectedYearMonth = DateFormat('yyyy-MM').format(newDate);
      _controllers.clear();
      _rolloverMap.clear();
    });
  }

  void _applyBudgetModel(List<CategoryModel> categories) async {
    final income = double.tryParse(_incomeController.text.trim()) ?? 18000.0;
    if (income <= 0) return;

    if (_selectedModel == 'history') {
      for (final cat in categories) {
        final suggested = await ref.read(budgetsControllerProvider).getSuggestedBudget(cat.id, _selectedYearMonth);
        if (suggested > 0) {
          _controllers[cat.id]?.text = suggested.toStringAsFixed(0);
        }
      }
      setState(() {});
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('הוחל תקציב מבוסס ממוצע היסטורי חכם'), backgroundColor: AppColors.income),
        );
      }
      return;
    }

    double needsBudget;
    double wantsBudget;

    if (_selectedModel == '50_30_20') {
      needsBudget = income * 0.50;
      wantsBudget = income * 0.30;
    } else if (_selectedModel == '70_20_10') {
      needsBudget = income * 0.70;
      wantsBudget = income * 0.10;
    } else {
      // 60_20_20
      needsBudget = income * 0.60;
      wantsBudget = income * 0.20;
    }

    final needsCats = categories.where((c) => c.isNeeds).toList();
    final wantsCats = categories.where((c) => c.isWants).toList();

    final perNeed = needsCats.isNotEmpty ? (needsBudget / needsCats.length) : 0.0;
    final perWant = wantsCats.isNotEmpty ? (wantsBudget / wantsCats.length) : 0.0;

    for (final cat in categories) {
      final allocated = cat.isNeeds ? perNeed : perWant;
      _controllers[cat.id]?.text = allocated > 0 ? allocated.toStringAsFixed(0) : '';
    }

    setState(() {});
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('הוחל תכנון מומלץ (${_selectedModel.replaceAll('_', '/')}) על כלל הקטגוריות'),
          backgroundColor: AppColors.income,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(allCategoriesStreamProvider('expense'));
    final budgetsAsync = ref.watch(budgetsStreamProvider(_selectedYearMonth));

    final categories = categoriesAsync.value ?? [];
    final existingBudgets = budgetsAsync.value ?? [];

    // Map existing budgets to inputs
    final budgetByCatId = {for (final b in existingBudgets) b.categoryId: b};
    for (final cat in categories) {
      if (!_controllers.containsKey(cat.id)) {
        final b = budgetByCatId[cat.id];
        _controllers[cat.id] = TextEditingController(
          text: b != null && b.baseAmount > 0 ? b.baseAmount.toStringAsFixed(0) : '',
        );
        _rolloverMap[cat.id] = b?.isRolloverEnabled ?? false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('תכנון תקציב חודשי'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.restore),
            tooltip: 'שכפל תקציב מחודש קודם',
            onPressed: () async {
              final count = await ref.read(budgetsControllerProvider).copyFromPreviousMonth(_selectedYearMonth);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(count > 0 ? 'הועתקו בהצלחה $count קטגוריות תקציב' : 'לא נמצא תקציב בחודש הקודם לשכפול'),
                    backgroundColor: AppColors.income,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          // Month Selector Header (RTL-adapted: Right is Previous Month, Left is Next Month)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
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
                  onPressed: () => _changeMonth(-1),
                ),
                Text(
                  _formatHebrewMonth(_selectedYearMonth),
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                IconButton(
                  icon: const Icon(AppIcons.chevronRight),
                  tooltip: 'חודש הבא',
                  onPressed: () => _changeMonth(1),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Quick Planning via Popular Budget Rules Card (Item 10)
          Card(
            child: Padding(
              padding: AppSpacing.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(AppIcons.budgets, color: AppColors.primary, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'תכנון מהיר לפי מודלים נפוצים',
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                      const Spacer(),
                      const FinancialInfoTooltip(
                        title: 'מודלים נפוצים לחלוקת תקציב',
                        explanation: 'חלוקה מובנית של ההכנסה החודשית הנטו להוצאות צרכים, מותרות וחיסכון.\n\n• מודל 50/30/20: 50% צרכים, 30% מותרות, 20% חיסכון.\n• מודל 70/20/10: 70% שוטף, 20% חיסכון, 10% פנאי.\n• מודל 60/20/20: 60% צרכים, 20% מותרות, 20% חיסכון.\n• ממוצע היסטורי: חישוב חכם לפי 3 חודשים אחרונים.',
                        practicalTip: 'שימוש במודל מומלץ מונע הוצאת יתר על מותרות ומבטיח הגעה ליעדי חיסכון.',
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: _incomeController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                          decoration: const InputDecoration(
                            labelText: 'הכנסה חודשית נטו',
                            prefixText: '₪ ',
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        flex: 4,
                        child: DropdownButtonFormField<String>(
                          value: _selectedModel,
                          isDense: true,
                          style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                          decoration: const InputDecoration(
                            labelText: 'מודל תקציב',
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          ),
                          items: const [
                            DropdownMenuItem(value: '50_30_20', child: Text('מודל 50/30/20')),
                            DropdownMenuItem(value: '70_20_10', child: Text('מודל 70/20/10')),
                            DropdownMenuItem(value: '60_20_20', child: Text('מודל 60/20/20')),
                            DropdownMenuItem(value: 'history', child: Text('ממוצע 3 חודשים')),
                          ],
                          onChanged: (val) => setState(() => _selectedModel = val ?? '50_30_20'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: OutlinedButton.icon(
                      onPressed: () => _applyBudgetModel(categories),
                      icon: const Icon(Icons.auto_fix_high_rounded, size: 16),
                      label: const Text('החל תכנון מומלץ על כל הקטגוריות', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Category Budget Form Cards
          if (categories.isEmpty)
            const Center(child: CircularProgressIndicator())
          else
            Column(
              children: categories.map((cat) {
                final ctrl = _controllers[cat.id] ?? TextEditingController();
                final isRollover = _rolloverMap[cat.id] ?? false;

                return Card(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(cat.colorValue).withAlpha(35),
                              child: Icon(AppIcons.fromString(cat.iconName), color: Color(cat.colorValue), size: 20),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cat.name,
                                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                                  ),
                                  Text(
                                    cat.isNeeds ? 'צרכים בסיסיים' : 'מותרות',
                                    style: TextStyle(fontSize: 11, color: cat.isNeeds ? AppColors.primary : AppColors.warning),
                                  ),
                                ],
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () async {
                                final suggested = await ref
                                    .read(budgetsControllerProvider)
                                    .getSuggestedBudget(cat.id, _selectedYearMonth);
                                if (suggested > 0) {
                                  setState(() {
                                    ctrl.text = suggested.toStringAsFixed(0);
                                  });
                                } else {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('אין מספיק נתונים היסטוריים להצעה')),
                                    );
                                  }
                                }
                              },
                              icon: const Icon(Icons.auto_awesome_rounded, size: 14, color: AppColors.primary),
                              label: const Text('הצעה חכמה', style: TextStyle(fontSize: 11)),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: ctrl,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                decoration: const InputDecoration(
                                  labelText: 'תקציב יעד חודשי',
                                  prefixText: '₪ ',
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Row(
                              children: [
                                const Text('Rollover', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                                const FinancialInfoTooltip(
                                  title: 'תקציב מתגלגל (Rollover)',
                                  explanation: 'חישוב תקציב המעביר אוטומטית עודפים או גירעונות מחודש לחודש.\nאם חסכת 200 ₪, הם יתווספו לחודש הבא.',
                                ),
                                Switch(
                                  value: isRollover,
                                  onChanged: (val) {
                                    setState(() {
                                      _rolloverMap[cat.id] = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          const SizedBox(height: AppSpacing.xl),

          // Save All Changes Button
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () async {
                for (final cat in categories) {
                  final text = _controllers[cat.id]?.text.trim() ?? '';
                  final amount = double.tryParse(text) ?? 0.0;
                  final isRollover = _rolloverMap[cat.id] ?? false;

                  if (amount > 0 || budgetByCatId.containsKey(cat.id)) {
                    await ref.read(budgetsControllerProvider).setCategoryBudget(
                          categoryId: cat.id,
                          baseAmount: amount,
                          yearMonth: _selectedYearMonth,
                          isRolloverEnabled: isRollover,
                        );
                  }
                }

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('כל יעדי התקציב נשמרו בהצלחה!'),
                      backgroundColor: AppColors.income,
                    ),
                  );
                }
              },
              icon: const Icon(AppIcons.check, size: 18),
              label: const Text('שמור את כל יעדי התקציב', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

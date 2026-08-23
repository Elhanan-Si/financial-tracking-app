import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../accounts/domain/models/account_model.dart';
import '../../../categories_tags/domain/models/category_model.dart';
import '../../../categories_tags/presentation/widgets/category_search_picker.dart';
import '../../domain/models/recurring_rule_model.dart';

/// BottomSheet for creating or editing a recurring subscription / standing order / salary
class RecurringEditDialog extends StatefulWidget {
  final RecurringRuleModel? initialRule;
  final List<AccountModel> accounts;
  final List<CategoryModel> categories;
  final ValueChanged<RecurringRuleModel> onSave;

  const RecurringEditDialog({
    super.key,
    this.initialRule,
    required this.accounts,
    required this.categories,
    required this.onSave,
  });

  static Future<void> show(
    BuildContext context, {
    RecurringRuleModel? initialRule,
    required List<AccountModel> accounts,
    required List<CategoryModel> categories,
    required ValueChanged<RecurringRuleModel> onSave,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (context) => RecurringEditDialog(
        initialRule: initialRule,
        accounts: accounts,
        categories: categories,
        onSave: onSave,
      ),
    );
  }

  @override
  State<RecurringEditDialog> createState() => _RecurringEditDialogState();
}

class _RecurringEditDialogState extends State<RecurringEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late TextEditingController _dayOfMonthController;
  late RecurringFrequency _frequency;
  bool _isIncome = false;
  String? _accountId;
  String? _categoryId;
  late DateTime _startDate;
  DateTime? _endDate;
  bool _isAutoExecute = true;

  @override
  void initState() {
    super.initState();
    final rule = widget.initialRule;
    _nameController = TextEditingController(text: rule?.name ?? '');
    _amountController = TextEditingController(text: rule != null ? rule.amount.toString() : '');
    _dayOfMonthController = TextEditingController(text: rule != null ? rule.dayOfMonth.toString() : '1');
    _frequency = rule?.frequency ?? RecurringFrequency.monthly;
    _isIncome = rule?.isIncome ?? false;
    _accountId = rule?.accountId ?? (widget.accounts.isNotEmpty ? widget.accounts.first.id : null);
    _categoryId = rule?.categoryId;
    _startDate = rule?.startDate ?? DateTime.now();
    _endDate = rule?.endDate;
    _isAutoExecute = rule?.isAutoExecute ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _dayOfMonthController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('נא להזין שם להגדרה'), backgroundColor: AppColors.error),
      );
      return;
    }

    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('נא להזין סכום תקין גדול מ-0'), backgroundColor: AppColors.error),
      );
      return;
    }

    final dayOfMonth = int.tryParse(_dayOfMonthController.text.trim()) ?? 1;
    if (dayOfMonth < 1 || dayOfMonth > 31) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('יום בחודש חייב להיות בין 1 ל-31'), backgroundColor: AppColors.error),
      );
      return;
    }

    if (_accountId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('חובה לבחור חשבון'), backgroundColor: AppColors.error),
      );
      return;
    }

    final nextExec = DateTime(_startDate.year, _startDate.month, dayOfMonth);

    final rule = RecurringRuleModel(
      id: widget.initialRule?.id ?? '',
      accountId: _accountId!,
      categoryId: _categoryId,
      name: name,
      amount: amount,
      frequency: _frequency,
      dayOfMonth: dayOfMonth,
      startDate: _startDate,
      endDate: _endDate,
      isAutoExecute: _isAutoExecute,
      isPaused: widget.initialRule?.isPaused ?? false,
      nextExecutionDate: nextExec.isBefore(DateTime.now())
          ? DateTime(DateTime.now().year, DateTime.now().month + 1, dayOfMonth)
          : nextExec,
      createdAt: widget.initialRule?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    widget.onSave(rule);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initialRule != null;
    final relevantCategories = widget.categories.where((c) {
      if (_isIncome) return c.type == 'income';
      return c.type == 'expense';
    }).toList();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
        top: AppSpacing.md,
        left: AppSpacing.lg,
        right: AppSpacing.lg,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEdit ? 'עריכת הוראה קבועה / משכורת' : 'הוראת קבע / הכנסה קבועה חדשה',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                IconButton(
                  icon: const Icon(AppIcons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Income / Expense Type Segmented Button
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(
                  value: false,
                  label: Text('הוראת קבע / מנוי (הוצאה)'),
                  icon: Icon(AppIcons.expense),
                ),
                ButtonSegment(
                  value: true,
                  label: Text('הכנסה קבועה (משכורת)'),
                  icon: Icon(AppIcons.salary),
                ),
              ],
              selected: {_isIncome},
              onSelectionChanged: (set) {
                setState(() {
                  _isIncome = set.first;
                  _categoryId = null;
                });
              },
            ),
            const SizedBox(height: AppSpacing.md),

            // Name
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: _isIncome ? 'שם ההכנסה (למשל: משכורת הייטק, שכר דירה, קצבה)' : 'שם (למשל: נטפליקס, שכירות, ארנונה)',
                prefixIcon: Icon(_isIncome ? AppIcons.salary : AppIcons.recurring, size: 20),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Amount & Day of month
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'סכום (₪)',
                      prefixIcon: Icon(AppIcons.cash, size: 20),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _dayOfMonthController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: 'יום בחודש (1-31)',
                      prefixIcon: Icon(AppIcons.calendar, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Frequency & Account Pickers
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<RecurringFrequency>(
                    value: _frequency,
                    isDense: true,
                    style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                    decoration: const InputDecoration(
                      labelText: 'תדירות',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                    items: RecurringFrequency.values.map((f) {
                      return DropdownMenuItem(value: f, child: Text(f.label, style: const TextStyle(fontSize: 13)));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _frequency = val);
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _accountId,
                    isDense: true,
                    style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      labelText: _isIncome ? 'חשבון יעד להפקדה' : 'חשבון חיוב',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                    items: widget.accounts.map((a) {
                      return DropdownMenuItem(
                        value: a.id,
                        child: Text(a.name, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _accountId = val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Category Search Picker Button
            InkWell(
              onTap: () async {
                final selected = await CategorySearchPicker.show(
                  context: context,
                  categories: relevantCategories,
                  selectedCategoryId: _categoryId,
                  title: _isIncome ? 'בחירת קטגוריית הכנסה' : 'בחירת קטגוריית הוצאה',
                );
                if (selected != null) {
                  setState(() => _categoryId = selected.id);
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    if (_categoryId != null) ...[
                      Builder(builder: (context) {
                        final selectedCat = widget.categories.where((c) => c.id == _categoryId).firstOrNull;
                        if (selectedCat != null) {
                          return Row(
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: selectedCat.color.withValues(alpha: 0.2),
                                child: Icon(selectedCat.icon, size: 12, color: selectedCat.color),
                              ),
                              const SizedBox(width: 8),
                              Text(selectedCat.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                            ],
                          );
                        }
                        return const Text('בחר קטגוריה', style: TextStyle(fontSize: 13, color: AppColors.textSecondary));
                      }),
                    ] else ...[
                      const Icon(AppIcons.categories, size: 18, color: AppColors.textMuted),
                      const SizedBox(width: 8),
                      const Text('בחר קטגוריה (חיפוש מהיר)', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                    ],
                    const Spacer(),
                    const Icon(AppIcons.search, size: 18, color: AppColors.textMuted),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Start Date Picker & Auto-execute switch
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _startDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setState(() => _startDate = picked);
                    },
                    icon: const Icon(AppIcons.calendar, size: 16),
                    label: Text('תחילה: ${AppDateFormatter.formatShortDate(_startDate)}', style: const TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Save Button
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                isEdit ? 'שמור שינויים' : (_isIncome ? 'הוסף הכנסה קבועה (משכורת)' : 'צור הוראת קבע'),
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

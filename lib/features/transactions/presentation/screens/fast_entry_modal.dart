import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../accounts/presentation/controllers/accounts_controller.dart';
import '../../../backup_settings/presentation/controllers/salary_tax_settings_controller.dart';
import '../../../categories_tags/presentation/controllers/categories_controller.dart';
import '../../../categories_tags/presentation/widgets/category_search_picker.dart';
import '../../domain/models/transaction_model.dart';
import '../../domain/models/transaction_split_model.dart';
import '../controllers/transactions_controller.dart';
import '../widgets/merchant_autocomplete_field.dart';
import '../widgets/splits_editor_widget.dart';

/// Screen 2: Fast Transaction Entry (הזנה מהירה - Modal / BottomSheet)
class FastEntryModal extends ConsumerStatefulWidget {
  const FastEntryModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (context) => const FastEntryModal(),
    );
  }

  @override
  ConsumerState<FastEntryModal> createState() => _FastEntryModalState();
}

class _FastEntryModalState extends ConsumerState<FastEntryModal> {
  final _amountController = TextEditingController();
  final _merchantController = TextEditingController();
  final _noteController = TextEditingController();

  TransactionType _selectedType = TransactionType.expense;
  bool _isIncomeGross = false;
  String? _selectedAccountId;
  String? _selectedCategoryId;
  DateTime _selectedDate = DateTime.now();
  bool _isSplitMode = false;
  List<TransactionSplitModel> _splits = [];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    _merchantController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submit() async {
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('אנא הזן סכום תקין גדול מ-0'), backgroundColor: AppColors.error),
      );
      return;
    }

    if (_selectedAccountId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('אנא בחר חשבון לתשלום'), backgroundColor: AppColors.error),
      );
      return;
    }

    if (_isSplitMode) {
      if (_splits.length < 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('עסקה מפוצלת דורשת לפחות 2 שורות פיצול'), backgroundColor: AppColors.error),
        );
        return;
      }

      final sumSplits = _splits.fold<double>(0.0, (sum, s) => sum + s.amount);
      if ((sumSplits - amount).abs() > 0.01) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('סכום הפיצולים (₪${sumSplits.toStringAsFixed(2)}) חייב להשתוות לסכום העסקה (₪${amount.toStringAsFixed(2)})'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
    }

    setState(() => _isSubmitting = true);

    try {
      double finalAmount = amount;
      String? finalNote = _noteController.text.trim();
      if (_selectedType == TransactionType.income && _isIncomeGross) {
        final taxSettings = ref.read(salaryTaxSettingsProvider);
        final calc = taxSettings.calculateFromGross(amount);
        finalAmount = calc.net;
        final taxNote = '[ברוטו: ₪${amount.toStringAsFixed(0)}, נוכה מס: ₪${calc.tax.toStringAsFixed(0)}]';
        finalNote = finalNote.isNotEmpty ? '$finalNote $taxNote' : taxNote;
      }

      // Optimistic UI: perform operation
      await ref.read(transactionsControllerProvider).addTransaction(
            accountId: _selectedAccountId!,
            categoryId: _isSplitMode ? null : _selectedCategoryId,
            merchantName: _merchantController.text.trim(),
            amount: finalAmount,
            type: _selectedType,
            date: _selectedDate,
            note: finalNote,
            splits: _isSplitMode ? _splits : null,
          );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('העסקה נשמרה בהצלחה'),
            backgroundColor: AppColors.income,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('שגיאה בשמירת עסקה: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountsStreamProvider(false));
    final accounts = accountsAsync.value ?? [];

    // Set default account if not yet selected
    if (_selectedAccountId == null && accounts.isNotEmpty) {
      _selectedAccountId = accounts.first.id;
    }

    final categoriesAsync = ref.watch(allCategoriesStreamProvider(_selectedType.name));
    final categories = categoriesAsync.value ?? [];

    final currentAmount = double.tryParse(_amountController.text.trim()) ?? 0.0;

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
            // Modal Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'הזנת עסקה מהירה',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                ),
                IconButton(
                  icon: const Icon(AppIcons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Type Segmented Button
            SegmentedButton<TransactionType>(
              segments: const [
                ButtonSegment(
                  value: TransactionType.expense,
                  label: Text('הוצאה'),
                  icon: Icon(AppIcons.expense),
                ),
                ButtonSegment(
                  value: TransactionType.income,
                  label: Text('הכנסה'),
                  icon: Icon(AppIcons.income),
                ),
              ],
              selected: {_selectedType},
              onSelectionChanged: (set) {
                setState(() {
                  _selectedType = set.first;
                  _selectedCategoryId = null;
                });
              },
            ),
            if (_selectedType == TransactionType.income) ...[
              const SizedBox(height: AppSpacing.sm),
              Center(
                child: SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: false, label: Text('הכנסה נטו (Net)')),
                    ButtonSegment(value: true, label: Text('הכנסה ברוטו (Gross)')),
                  ],
                  selected: {_isIncomeGross},
                  onSelectionChanged: (set) => setState(() => _isIncomeGross = set.first),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),

            // Large Hero Amount Input
            TextField(
              controller: _amountController,
              autofocus: false,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: _selectedType.color,
                letterSpacing: -0.5,
              ),
              decoration: InputDecoration(
                hintText: '0.00 ₪',
                labelText: _selectedType == TransactionType.income
                    ? (_isIncomeGross ? 'סכום הכנסה ברוטו' : 'סכום הכנסה נטו')
                    : 'סכום העסקה',
                labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                fillColor: _selectedType.color.withAlpha(10),
              ),
              onChanged: (_) => setState(() {}),
            ),
            if (_selectedType == TransactionType.income && currentAmount > 0) ...[
              const SizedBox(height: 6),
              Builder(builder: (context) {
                final taxSettings = ref.watch(salaryTaxSettingsProvider);
                if (_isIncomeGross) {
                  final calc = taxSettings.calculateFromGross(currentAmount);
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.income.withAlpha(20),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.income.withAlpha(60)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'חישוב מס אוטומטי (לפי ${taxSettings.defaultTaxRate.toStringAsFixed(0)}% בהגדרות):',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ניכוי מס: -₪${calc.tax.toStringAsFixed(0)}', style: const TextStyle(fontSize: 11, color: AppColors.error, fontWeight: FontWeight.w600)),
                            Text('נטו להפקדה בחשבון: ₪${calc.net.toStringAsFixed(0)}', style: const TextStyle(fontSize: 11, color: AppColors.income, fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  final calc = taxSettings.calculateFromNet(currentAmount);
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'נטו להפקדה: ₪${currentAmount.toStringAsFixed(0)} • שווי ברוטו משוער: ₪${calc.gross.toStringAsFixed(0)} (מס: ₪${calc.tax.toStringAsFixed(0)})',
                      style: const TextStyle(fontSize: 11, color: AppColors.primaryDark, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              }),
            ],
            const SizedBox(height: AppSpacing.md),

            // Merchant Autocomplete Field
            MerchantAutocompleteField(
              controller: _merchantController,
              onMerchantSelected: (merchant) {
                if (merchant.defaultCategoryId != null && !_isSplitMode) {
                  setState(() {
                    _selectedCategoryId = merchant.defaultCategoryId;
                  });
                }
              },
            ),
            const SizedBox(height: AppSpacing.md),

            // Category & Account Pickers in Row
            Row(
              children: [
                // Account Dropdown
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedAccountId,
                    isDense: true,
                    isExpanded: true,
                    style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                    decoration: const InputDecoration(
                      labelText: 'חשבון חיוב',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                    items: accounts.map((acc) {
                      return DropdownMenuItem(
                        value: acc.id,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(acc.icon, size: 16, color: acc.color),
                            const SizedBox(width: 6),
                            Text(acc.name, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedAccountId = val),
                  ),
                ),
                if (!_isSplitMode) ...[
                  const SizedBox(width: AppSpacing.sm),
                  // Category Search Picker Button
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final selected = await CategorySearchPicker.show(
                          context: context,
                          categories: categories,
                          selectedCategoryId: _selectedCategoryId,
                        );
                        if (selected != null) {
                          setState(() => _selectedCategoryId = selected.id);
                        }
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            if (_selectedCategoryId != null) ...[
                              Builder(builder: (context) {
                                final selectedCat = categories.where((c) => c.id == _selectedCategoryId).firstOrNull;
                                if (selectedCat != null) {
                                  return Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 8,
                                        backgroundColor: selectedCat.color.withAlpha(40),
                                        child: Icon(selectedCat.icon, size: 10, color: selectedCat.color),
                                      ),
                                      const SizedBox(width: 6),
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(maxWidth: 80),
                                        child: Text(selectedCat.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  );
                                }
                                return const Text('בחר קטגוריה', style: TextStyle(fontSize: 13, color: AppColors.textSecondary));
                              }),
                            ] else ...[
                              const Icon(AppIcons.categories, size: 16, color: AppColors.textMuted),
                              const SizedBox(width: 6),
                              const Text('בחר קטגוריה', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                            ],
                            const Spacer(),
                            const Icon(AppIcons.search, size: 16, color: AppColors.textMuted),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Split Mode Switcher Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(AppIcons.split, size: 18, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Text(
                      _isSplitMode ? 'ביטול פיצול עסקה' : 'פיצול עסקה למספר קטגוריות',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Switch(
                  value: _isSplitMode,
                  onChanged: currentAmount > 0
                      ? (val) {
                          setState(() {
                            _isSplitMode = val;
                          });
                        }
                      : null,
                ),
              ],
            ),

            // Splits Editor if Split Mode is ON
            if (_isSplitMode) ...[
              const SizedBox(height: AppSpacing.sm),
              SplitsEditorWidget(
                totalAmount: currentAmount,
                categories: categories,
                initialSplits: _splits,
                onSplitsChanged: (splits) {
                  _splits = splits;
                },
              ),
            ],

            const SizedBox(height: AppSpacing.md),

            // Date & Note Row
            Row(
              children: [
                // Date Picker Button
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => _selectedDate = picked);
                      }
                    },
                    icon: const Icon(AppIcons.calendar, size: 18),
                    label: Text('${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),

                // Note Field
                Expanded(
                  child: TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      labelText: 'הערה (אופציונלי)',
                      contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Submit Button
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedType.color,
                ),
                child: _isSubmitting
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('שמור עסקה', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

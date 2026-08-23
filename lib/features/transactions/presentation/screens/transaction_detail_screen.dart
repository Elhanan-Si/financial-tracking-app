import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../accounts/presentation/controllers/accounts_controller.dart';
import '../../../categories_tags/presentation/controllers/categories_controller.dart';
import '../../../categories_tags/presentation/widgets/category_search_picker.dart';
import '../../domain/models/transaction_model.dart';
import '../controllers/transactions_controller.dart';
import '../widgets/splits_display_tile.dart';

/// Screen 4: Transaction Detail & Edit (פרטי תנועה ועריכה)
class TransactionDetailScreen extends ConsumerStatefulWidget {
  final String transactionId;

  const TransactionDetailScreen({super.key, required this.transactionId});

  @override
  ConsumerState<TransactionDetailScreen> createState() => _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends ConsumerState<TransactionDetailScreen> {
  bool _isEditing = false;
  late TextEditingController _amountController;
  late TextEditingController _merchantController;
  late TextEditingController _noteController;
  String? _accountId;
  String? _categoryId;
  late TransactionType _type;
  late DateTime _date;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _merchantController = TextEditingController();
    _noteController = TextEditingController();
    _type = TransactionType.expense;
    _date = DateTime.now();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _merchantController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _initFields(TransactionModel tx) {
    _amountController.text = tx.amount.toString();
    _merchantController.text = tx.merchantName ?? '';
    _noteController.text = tx.note ?? '';
    _accountId = tx.accountId;
    _categoryId = tx.categoryId;
    _type = tx.type;
    _date = tx.date;
  }

  Future<void> _saveChanges(TransactionModel original) async {
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('סכום לא תקין'), backgroundColor: AppColors.error),
      );
      return;
    }

    setState(() => _isLoading = true);

    final updated = original.copyWith(
      amount: amount,
      accountId: _accountId,
      categoryId: _categoryId,
      merchantName: _merchantController.text.trim(),
      note: _noteController.text.trim(),
      type: _type,
      date: _date,
      updatedAt: DateTime.now(),
    );

    try {
      await ref.read(transactionsControllerProvider).updateTransaction(updated);
      setState(() => _isEditing = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('העסקה עודכנה בהצלחה'), backgroundColor: AppColors.income),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _confirmDelete(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(AppIcons.delete, color: AppColors.error),
            SizedBox(width: AppSpacing.sm),
            Text('מחיקת תנועה'),
          ],
        ),
        content: const Text('האם אתה בטוח שברצונך למחוק תנועה זו? יתרת החשבון תעודכן בהתאם.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('ביטול')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('מחק'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(transactionsControllerProvider).deleteTransaction(id);
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('התנועה נמחקה בהצלחה'), backgroundColor: AppColors.income),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(transactionsRepositoryProvider);
    final accountsAsync = ref.watch(accountsStreamProvider(false));
    final accounts = accountsAsync.value ?? [];
    final categoriesAsync = ref.watch(allCategoriesStreamProvider(null));
    final categories = categoriesAsync.value ?? [];

    return FutureBuilder<TransactionModel?>(
      future: repo.getTransactionById(widget.transactionId),
      builder: (context, snapshot) {
        final tx = snapshot.data;
        if (tx == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (!_isEditing && _amountController.text.isEmpty) {
          _initFields(tx);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(_isEditing ? 'עריכת תנועה' : 'פרטי תנועה'),
            actions: [
              if (!_isEditing) ...[
                IconButton(
                  icon: const Icon(AppIcons.edit),
                  tooltip: 'עריכה',
                  onPressed: () {
                    _initFields(tx);
                    setState(() => _isEditing = true);
                  },
                ),
                IconButton(
                  icon: const Icon(AppIcons.delete, color: AppColors.error),
                  tooltip: 'מחיקה',
                  onPressed: () => _confirmDelete(tx.id),
                ),
              ] else ...[
                IconButton(
                  icon: const Icon(AppIcons.close),
                  tooltip: 'ביטול עריכה',
                  onPressed: () => setState(() => _isEditing = false),
                ),
              ],
              const SizedBox(width: AppSpacing.sm),
            ],
          ),
          body: ListView(
            padding: AppSpacing.screenPadding,
            children: [
              if (!_isEditing) ...[
                // Display Mode
                Card(
                  child: Padding(
                    padding: AppSpacing.cardPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: tx.displayColor.withValues(alpha: 0.12),
                          child: Icon(tx.displayIcon, color: tx.displayColor, size: 28),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          tx.merchantName ?? (tx.note ?? tx.type.label),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          CurrencyFormatter.formatSignedILS(tx.amount, isExpense: tx.isExpense),
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: tx.displayColor,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        const Divider(height: 1),
                        const SizedBox(height: AppSpacing.md),
                        _buildDetailRow('סוג תנועה', tx.type.label),
                        _buildDetailRow('חשבון משויך', tx.accountName ?? 'לא צוין'),
                        _buildDetailRow('קטגוריה', tx.categoryName ?? 'ללא סיווג'),
                        _buildDetailRow('תאריך', AppDateFormatter.formatFullDate(tx.date)),
                        if (tx.note?.isNotEmpty == true) _buildDetailRow('הערות', tx.note!),
                        if (tx.isAutoCategorized) _buildDetailRow('סיווג חכם', 'סווג אוטומטית לפי בית עסק'),
                      ],
                    ),
                  ),
                ),
                if (tx.hasSplits) ...[
                  const SizedBox(height: AppSpacing.md),
                  Consumer(
                    builder: (context, ref, child) {
                      final splitsAsync = ref.watch(transactionSplitsProvider(tx.id));
                      return splitsAsync.when(
                        data: (splits) => SplitsDisplayCard(splits: splits, totalAmount: tx.amount),
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (_, __) => const SizedBox.shrink(),
                      );
                    },
                  ),
                ],
              ] else ...[
                // Edit Form Mode
                Card(
                  child: Padding(
                    padding: AppSpacing.cardPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(labelText: 'סכום (₪)'),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _merchantController,
                          decoration: const InputDecoration(labelText: 'בית עסק'),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        DropdownButtonFormField<String>(
                          value: _accountId,
                          isDense: true,
                          style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                          decoration: const InputDecoration(
                            labelText: 'חשבון',
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          ),
                          items: accounts.map((a) => DropdownMenuItem(value: a.id, child: Text(a.name, style: const TextStyle(fontSize: 13)))).toList(),
                          onChanged: (val) => setState(() => _accountId = val),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        InkWell(
                          onTap: () async {
                            final selected = await CategorySearchPicker.show(
                              context: context,
                              categories: categories,
                              selectedCategoryId: _categoryId,
                            );
                            if (selected != null) {
                              setState(() => _categoryId = selected.id);
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'קטגוריה',
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            ),
                            child: Row(
                              children: [
                                if (_categoryId != null && categories.any((c) => c.id == _categoryId)) ...[
                                  Builder(
                                    builder: (context) {
                                      final cat = categories.firstWhere((c) => c.id == _categoryId);
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Color(cat.colorValue).withAlpha(40),
                                            child: Icon(AppIcons.fromString(cat.iconName), color: Color(cat.colorValue), size: 12),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(cat.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                                        ],
                                      );
                                    },
                                  ),
                                ] else ...[
                                  const Text('ללא קטגוריה (לחץ לבחירה וחיפוש)', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                                ],
                                const Spacer(),
                                const Icon(AppIcons.chevronEnd, size: 16, color: AppColors.textSecondary),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _noteController,
                          decoration: const InputDecoration(labelText: 'הערה'),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        ElevatedButton(
                          onPressed: _isLoading ? null : () => _saveChanges(tx),
                          child: _isLoading
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                              : const Text('שמור שינויים'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

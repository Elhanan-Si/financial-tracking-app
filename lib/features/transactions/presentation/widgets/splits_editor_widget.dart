import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../categories_tags/domain/models/category_model.dart';
import '../../domain/models/transaction_split_model.dart';

/// Interactive Split Editor Widget
class SplitsEditorWidget extends StatefulWidget {
  final double totalAmount;
  final List<CategoryModel> categories;
  final List<TransactionSplitModel> initialSplits;
  final ValueChanged<List<TransactionSplitModel>> onSplitsChanged;

  const SplitsEditorWidget({
    super.key,
    required this.totalAmount,
    required this.categories,
    this.initialSplits = const [],
    required this.onSplitsChanged,
  });

  @override
  State<SplitsEditorWidget> createState() => _SplitsEditorWidgetState();
}

class _SplitsEditorWidgetState extends State<SplitsEditorWidget> {
  late List<_SplitDraft> _drafts;

  @override
  void initState() {
    super.initState();
    if (widget.initialSplits.isNotEmpty) {
      _drafts = widget.initialSplits.map((s) {
        return _SplitDraft(
          categoryId: s.categoryId,
          amountController: TextEditingController(text: s.amount.toStringAsFixed(2)),
          noteController: TextEditingController(text: s.note ?? ''),
        );
      }).toList();
    } else {
      // Default: 2 empty split rows
      final defaultCatId = widget.categories.isNotEmpty ? widget.categories.first.id : '';
      _drafts = [
        _SplitDraft(
          categoryId: defaultCatId,
          amountController: TextEditingController(),
          noteController: TextEditingController(),
        ),
        _SplitDraft(
          categoryId: defaultCatId,
          amountController: TextEditingController(),
          noteController: TextEditingController(),
        ),
      ];
    }
  }

  @override
  void dispose() {
    for (final d in _drafts) {
      d.amountController.dispose();
      d.noteController.dispose();
    }
    super.dispose();
  }

  double get _currentSum {
    double sum = 0.0;
    for (final d in _drafts) {
      final val = double.tryParse(d.amountController.text.trim()) ?? 0.0;
      sum += val;
    }
    return sum;
  }

  double get _remaining => widget.totalAmount - _currentSum;

  void _notifyChange() {
    final splits = _drafts.map((d) {
      final amount = double.tryParse(d.amountController.text.trim()) ?? 0.0;
      return TransactionSplitModel(
        id: '',
        transactionId: '',
        categoryId: d.categoryId,
        amount: amount,
        note: d.noteController.text.trim().isNotEmpty ? d.noteController.text.trim() : null,
        createdAt: DateTime.now(),
      );
    }).toList();

    widget.onSplitsChanged(splits);
  }

  void _addSplitRow() {
    final defaultCatId = widget.categories.isNotEmpty ? widget.categories.first.id : '';
    final remainingAmount = _remaining > 0 ? _remaining : 0.0;

    setState(() {
      _drafts.add(
        _SplitDraft(
          categoryId: defaultCatId,
          amountController: TextEditingController(
            text: remainingAmount > 0 ? remainingAmount.toStringAsFixed(2) : '',
          ),
          noteController: TextEditingController(),
        ),
      );
    });
    _notifyChange();
  }

  void _removeSplitRow(int index) {
    if (_drafts.length <= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('עסקה מפוצלת דורשת לפחות 2 שורות פיצול')),
      );
      return;
    }

    setState(() {
      final removed = _drafts.removeAt(index);
      removed.amountController.dispose();
      removed.noteController.dispose();
    });
    _notifyChange();
  }

  @override
  Widget build(BuildContext context) {
    final remaining = _remaining;
    final isExactMatch = (remaining.abs() < 0.01);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExactMatch ? AppColors.success.withAlpha(80) : AppColors.warning.withAlpha(120),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header & Balance summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(AppIcons.split, color: AppColors.primary, size: 20),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    'פיצול לקטגוריות',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isExactMatch
                      ? AppColors.success.withAlpha(25)
                      : (remaining > 0 ? AppColors.warning.withAlpha(25) : AppColors.error.withAlpha(25)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isExactMatch
                      ? 'הסכום מאוזן במלואו'
                      : (remaining > 0
                          ? 'נותר לסיווג: ${CurrencyFormatter.formatILS(remaining)}'
                          : 'חריגה: ${CurrencyFormatter.formatILS(remaining.abs())}'),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isExactMatch
                        ? AppColors.success
                        : (remaining > 0 ? AppColors.warning : AppColors.error),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Split Rows
          ...List.generate(_drafts.length, (index) {
            final draft = _drafts[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Category Selector
                        Expanded(
                          flex: 3,
                          child: DropdownButtonFormField<String>(
                            value: draft.categoryId.isNotEmpty &&
                                    widget.categories.any((c) => c.id == draft.categoryId)
                                ? draft.categoryId
                                : (widget.categories.isNotEmpty ? widget.categories.first.id : null),
                            isExpanded: true,
                            decoration: InputDecoration(
                              labelText: 'קטגוריה ${index + 1}',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            items: widget.categories.map((cat) {
                              return DropdownMenuItem(
                                value: cat.id,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: cat.color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      cat.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => draft.categoryId = val);
                                _notifyChange();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),

                        // Amount Field
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: draft.amountController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                            ],
                            decoration: InputDecoration(
                              labelText: 'סכום (₪)',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onChanged: (_) {
                              setState(() {});
                              _notifyChange();
                            },
                          ),
                        ),

                        // Delete Row Button
                        IconButton(
                          icon: const Icon(AppIcons.delete, color: AppColors.error, size: 20),
                          onPressed: () => _removeSplitRow(index),
                          tooltip: 'הסרת שורת פיצול',
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Optional Note for Split
                    TextFormField(
                      controller: draft.noteController,
                      decoration: InputDecoration(
                        hintText: 'הערה לפיצול זה (אופציונלי)...',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        isDense: true,
                      ),
                      onChanged: (_) => _notifyChange(),
                    ),
                  ],
                ),
              ),
            );
          }),

          // Add Split Row Button
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: _addSplitRow,
              icon: const Icon(AppIcons.add, size: 18),
              label: const Text('הוספת שורת פיצול'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplitDraft {
  String categoryId;
  final TextEditingController amountController;
  final TextEditingController noteController;

  _SplitDraft({
    required this.categoryId,
    required this.amountController,
    required this.noteController,
  });
}

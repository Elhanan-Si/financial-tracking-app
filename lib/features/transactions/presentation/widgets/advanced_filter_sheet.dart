import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../accounts/presentation/controllers/accounts_controller.dart';
import '../../../categories_tags/presentation/controllers/categories_controller.dart';
import '../controllers/transactions_controller.dart';

/// Modal bottom sheet for advanced multi-dimensional transaction filtering
class AdvancedFilterSheet extends ConsumerStatefulWidget {
  const AdvancedFilterSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AdvancedFilterSheet(),
    );
  }

  @override
  ConsumerState<AdvancedFilterSheet> createState() => _AdvancedFilterSheetState();
}

class _AdvancedFilterSheetState extends ConsumerState<AdvancedFilterSheet> {
  late List<String> _selectedAccountIds;
  late List<String> _selectedCategoryIds;
  DateTime? _startDate;
  DateTime? _endDate;
  late TextEditingController _minAmountController;
  late TextEditingController _maxAmountController;

  @override
  void initState() {
    super.initState();
    final filter = ref.read(transactionsFilterProvider);
    _selectedAccountIds = List.from(filter.accountIds);
    _selectedCategoryIds = List.from(filter.categoryIds);
    _startDate = filter.startDate;
    _endDate = filter.endDate;
    _minAmountController = TextEditingController(
      text: filter.minAmount != null ? filter.minAmount!.toStringAsFixed(0) : '',
    );
    _maxAmountController = TextEditingController(
      text: filter.maxAmount != null ? filter.maxAmount!.toStringAsFixed(0) : '',
    );
  }

  @override
  void dispose() {
    _minAmountController.dispose();
    _maxAmountController.dispose();
    super.dispose();
  }

  void _applyFilter() {
    final minVal = double.tryParse(_minAmountController.text);
    final maxVal = double.tryParse(_maxAmountController.text);

    ref.read(transactionsFilterProvider.notifier).update((state) {
      return state.copyWith(
        accountIds: _selectedAccountIds,
        categoryIds: _selectedCategoryIds,
        startDate: _startDate,
        endDate: _endDate,
        minAmount: minVal,
        maxAmount: maxVal,
        clearDates: _startDate == null && _endDate == null,
        clearAmounts: minVal == null && maxVal == null,
      );
    });

    Navigator.pop(context);
  }

  void _resetFilter() {
    setState(() {
      _selectedAccountIds = [];
      _selectedCategoryIds = [];
      _startDate = null;
      _endDate = null;
      _minAmountController.clear();
      _maxAmountController.clear();
    });

    ref.read(transactionsFilterProvider.notifier).update((state) => state.clearAll());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountsStreamProvider(false));
    final categoriesAsync = ref.watch(allCategoriesStreamProvider(null));

    final accounts = accountsAsync.value ?? [];
    final categories = categoriesAsync.value ?? [];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: AppSpacing.lg,
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderStrong,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'סינון תנועות מתקדם',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                TextButton(
                  onPressed: _resetFilter,
                  child: const Text('איפוס סינון', style: TextStyle(color: AppColors.error)),
                ),
              ],
            ),
            const Divider(height: AppSpacing.lg),

            // 1. Date Range
            const Text('טווח תאריכים', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _startDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setState(() => _startDate = picked);
                      }
                    },
                    icon: const Icon(AppIcons.calendar, size: 16),
                    label: Text(
                      _startDate != null ? AppDateFormatter.formatShortDate(_startDate!) : 'מתאריך',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _endDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setState(() => _endDate = picked);
                      }
                    },
                    icon: const Icon(AppIcons.calendar, size: 16),
                    label: Text(
                      _endDate != null ? AppDateFormatter.formatShortDate(_endDate!) : 'עד תאריך',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // 2. Amount Range
            const Text('טווח סכום (₪)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _minAmountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'מסכום',
                      prefixIcon: Icon(AppIcons.cash, size: 16),
                      contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: _maxAmountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'עד סכום',
                      prefixIcon: Icon(AppIcons.cash, size: 16),
                      contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // 3. Accounts Filter
            const Text('חשבונות', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: accounts.map((acc) {
                final isSelected = _selectedAccountIds.contains(acc.id);
                return FilterChip(
                  label: Text(acc.name),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedAccountIds.add(acc.id);
                      } else {
                        _selectedAccountIds.remove(acc.id);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.md),

            // 4. Categories Filter
            const Text('קטגוריות', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: categories.map((cat) {
                final isSelected = _selectedCategoryIds.contains(cat.id);
                return FilterChip(
                  avatar: CircleAvatar(
                    backgroundColor: Color(cat.colorValue).withAlpha(40),
                    child: Icon(AppIcons.fromString(cat.iconName), color: Color(cat.colorValue), size: 14),
                  ),
                  label: Text(cat.name),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedCategoryIds.add(cat.id);
                      } else {
                        _selectedCategoryIds.remove(cat.id);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Apply Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _applyFilter,
                child: const Text('החל סינון'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

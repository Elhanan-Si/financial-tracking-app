import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../categories_tags/presentation/controllers/categories_controller.dart';
import '../../../categories_tags/presentation/widgets/category_search_picker.dart';
import '../controllers/transactions_controller.dart';
import '../widgets/advanced_filter_sheet.dart';
import '../widgets/transaction_list_tile.dart';
import 'fast_entry_modal.dart';
import 'transaction_detail_screen.dart';

/// Screen 3: Transactions List & Advanced Filters (רשימת תנועות וסינון מתקדם עם עריכה מרובה)
class TransactionsListScreen extends ConsumerStatefulWidget {
  const TransactionsListScreen({super.key});

  @override
  ConsumerState<TransactionsListScreen> createState() => _TransactionsListScreenState();
}

class _TransactionsListScreenState extends ConsumerState<TransactionsListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showBatchCategoryDialog(List<String> selectedIds) async {
    final categoriesAsync = ref.read(allCategoriesStreamProvider(null));
    final categories = categoriesAsync.value ?? [];

    final selected = await CategorySearchPicker.show(
      context: context,
      categories: categories,
      title: 'שינוי קטגוריה ל-${selectedIds.length} עסקאות',
    );

    if (selected != null) {
      await ref.read(transactionsControllerProvider).batchUpdateCategory(selectedIds, selected.id);
      ref.read(selectedTransactionIdsProvider.notifier).state = {};
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('עודכנו ${selectedIds.length} עסקאות בהצלחה'), backgroundColor: AppColors.income),
        );
      }
    }
  }

  void _showBatchDeleteDialog(List<String> selectedIds) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('מחיקת עסקאות נבחרות'),
        content: Text('האם למחוק ${selectedIds.length} עסקאות? פעולה זו תעדכן את יתרות החשבון.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('ביטול')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(transactionsControllerProvider).batchDeleteTransactions(selectedIds);
              ref.read(selectedTransactionIdsProvider.notifier).state = {};
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('נמחקו ${selectedIds.length} עסקאות'), backgroundColor: AppColors.error),
                );
              }
            },
            child: const Text('מחק לצמיתות'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(transactionsFilterProvider);
    final transactionsAsync = ref.watch(transactionsStreamProvider);
    final selectedIds = ref.watch(selectedTransactionIdsProvider);
    final isMultiSelect = selectedIds.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(isMultiSelect ? 'נבחרו ${selectedIds.length} עסקאות' : 'תנועות ועסקאות'),
        leading: isMultiSelect
            ? IconButton(
                icon: const Icon(AppIcons.close),
                onPressed: () => ref.read(selectedTransactionIdsProvider.notifier).state = {},
              )
            : null,
        actions: [
          if (isMultiSelect) ...[
            IconButton(
              icon: const Icon(AppIcons.edit),
              tooltip: 'שנה קטגוריה לקבוצה',
              onPressed: () => _showBatchCategoryDialog(selectedIds.toList()),
            ),
            IconButton(
              icon: const Icon(AppIcons.delete, color: AppColors.error),
              tooltip: 'מחק נבחרים',
              onPressed: () => _showBatchDeleteDialog(selectedIds.toList()),
            ),
          ] else ...[
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(AppIcons.filter),
                  tooltip: 'סינון מתקדם',
                  onPressed: () => AdvancedFilterSheet.show(context),
                ),
                if (filter.hasAdvancedFilters)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            IconButton(
              icon: const Icon(AppIcons.add),
              tooltip: 'הזנת עסקה מהירה',
              onPressed: () => FastEntryModal.show(context),
            ),
          ],
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      floatingActionButton: isMultiSelect
          ? null
          : FloatingActionButton.extended(
              heroTag: 'transactions_add_fab',
              onPressed: () => FastEntryModal.show(context),
              icon: const Icon(AppIcons.add),
              label: const Text('הזנת עסקה'),
            ),
      body: Column(
        children: [
          // 1. Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'חיפוש לפי בית עסק, הערה או סכום...',
                prefixIcon: const Icon(AppIcons.search, size: 20),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(AppIcons.close, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(transactionsFilterProvider.notifier).update(
                                (state) => state.copyWith(searchQuery: ''),
                              );
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              ),
              onChanged: (val) {
                ref.read(transactionsFilterProvider.notifier).update(
                      (state) => state.copyWith(searchQuery: val),
                    );
              },
            ),
          ),

          // 2. Quick Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
            child: Row(
              children: [
                _buildFilterChip('all', 'כל התנועות', filter.type),
                const SizedBox(width: AppSpacing.sm),
                _buildFilterChip('expense', 'הוצאות בלבד', filter.type),
                const SizedBox(width: AppSpacing.sm),
                _buildFilterChip('income', 'הכנסות בלבד', filter.type),
                const SizedBox(width: AppSpacing.sm),
                _buildFilterChip('transfer', 'העברות פנימיות', filter.type),
              ],
            ),
          ),
          const Divider(height: AppSpacing.md),

          // 3. Transactions Stream List
          Expanded(
            child: transactionsAsync.when(
              data: (transactions) {
                if (transactions.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.xl),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryLight,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(AppIcons.transactions, size: 48, color: AppColors.primary),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        const Text(
                          'אין תנועות להצגה',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        const Text(
                          'לחץ על כפתור ה-"+" כדי להזין עסקה חדשה',
                          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(
                    left: AppSpacing.lg,
                    right: AppSpacing.lg,
                    top: AppSpacing.xs,
                    bottom: 80,
                  ),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final tx = transactions[index];
                    final isSelected = selectedIds.contains(tx.id);

                    return GestureDetector(
                      onLongPress: () {
                        ref.read(selectedTransactionIdsProvider.notifier).update((set) {
                          final newSet = Set<String>.from(set);
                          if (newSet.contains(tx.id)) {
                            newSet.remove(tx.id);
                          } else {
                            newSet.add(tx.id);
                          }
                          return newSet;
                        });
                      },
                      child: Row(
                        children: [
                          if (isMultiSelect)
                            Checkbox(
                              value: isSelected,
                              onChanged: (val) {
                                ref.read(selectedTransactionIdsProvider.notifier).update((set) {
                                  final newSet = Set<String>.from(set);
                                  if (val == true) {
                                    newSet.add(tx.id);
                                  } else {
                                    newSet.remove(tx.id);
                                  }
                                  return newSet;
                                });
                              },
                            ),
                          Expanded(
                            child: TransactionListTile(
                              transaction: tx,
                              onTap: () {
                                if (isMultiSelect) {
                                  ref.read(selectedTransactionIdsProvider.notifier).update((set) {
                                    final newSet = Set<String>.from(set);
                                    if (newSet.contains(tx.id)) {
                                      newSet.remove(tx.id);
                                    } else {
                                      newSet.add(tx.id);
                                    }
                                    return newSet;
                                  });
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TransactionDetailScreen(transactionId: tx.id),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('שגיאה בטעינת תנועות: $err')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String key, String label, String currentSelected) {
    final isSelected = currentSelected == key;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          ref.read(transactionsFilterProvider.notifier).update(
                (state) => state.copyWith(type: key),
              );
        }
      },
      selectedColor: AppColors.primaryLight,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        fontSize: 12,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/merchant_model.dart';
import '../controllers/categories_controller.dart';
import 'category_search_picker.dart';

/// BottomSheet to manage merchants list and merge duplicate merchants
class MerchantManagementDialog extends ConsumerStatefulWidget {
  const MerchantManagementDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (context) => const MerchantManagementDialog(),
    );
  }

  @override
  ConsumerState<MerchantManagementDialog> createState() => _MerchantManagementDialogState();
}

class _MerchantManagementDialogState extends ConsumerState<MerchantManagementDialog> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showMergeDialog(MerchantModel sourceMerchant, List<MerchantModel> allMerchants) {
    final targets = allMerchants.where((m) => m.id != sourceMerchant.id).toList();
    if (targets.isEmpty) return;

    String targetId = targets.first.id;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
                top: AppSpacing.md,
                left: AppSpacing.lg,
                right: AppSpacing.lg,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'מיזוג בתי עסק כפולים',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                      ),
                      IconButton(
                        icon: const Icon(AppIcons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text('מיזוג בית העסק "${sourceMerchant.name}" לתוך:'),
                  const SizedBox(height: AppSpacing.sm),
                  DropdownButtonFormField<String>(
                    value: targetId,
                    isDense: true,
                    style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                    decoration: const InputDecoration(
                      labelText: 'בית עסק יעד',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                    items: targets
                        .map((m) => DropdownMenuItem(value: m.id, child: Text(m.name, style: const TextStyle(fontSize: 13))))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setModalState(() => targetId = val);
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Text(
                    'כל העסקאות ההיסטוריות המשויכות לבית העסק יועברו לבית העסק היעד, ובית העסק המקורי יימחק.',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ElevatedButton(
                    onPressed: () async {
                      await ref.read(categoriesControllerProvider).mergeMerchants(
                            sourceMerchantId: sourceMerchant.id,
                            targetMerchantId: targetId,
                          );
                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('בתי העסק מוזגו בהצלחה'),
                            backgroundColor: AppColors.income,
                          ),
                        );
                      }
                    },
                    child: const Text('בצע מיזוג עסקאות'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showEditMerchantCategoryDialog(MerchantModel merchant, List<CategoryModel> categories) async {
    final selected = await CategorySearchPicker.show(
      context: context,
      categories: categories,
      selectedCategoryId: merchant.defaultCategoryId,
      title: 'סיווג קבוע עבור ${merchant.name}',
    );

    if (selected != null) {
      await ref.read(categoriesControllerProvider).updateMerchantDefaultCategory(
            merchant.id,
            selected.id,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final merchantsAsync = ref.watch(merchantsStreamProvider);
    final allCategoriesAsync = ref.watch(allCategoriesStreamProvider(null));
    final allCategories = allCategoriesAsync.value ?? [];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.md,
          top: AppSpacing.md,
          left: AppSpacing.lg,
          right: AppSpacing.lg,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(AppIcons.merchant, color: AppColors.primary),
                    SizedBox(width: AppSpacing.sm),
                    Text(
                      'ניהול בתי עסק וסיווג אוטומטי',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(AppIcons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'חיפוש בית עסק...',
                prefixIcon: Icon(AppIcons.search, size: 20),
                contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              ),
              onChanged: (val) => setState(() => _searchQuery = val.trim().toLowerCase()),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: merchantsAsync.when(
                data: (merchants) {
                  final filtered = merchants.where((m) => m.name.toLowerCase().contains(_searchQuery)).toList();

                  if (filtered.isEmpty) {
                    return const Center(child: Text('לא נמצאו בתי עסק'));
                  }

                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final m = filtered[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryLight,
                          child: const Icon(AppIcons.merchant, color: AppColors.primary, size: 18),
                        ),
                        title: Text(m.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        subtitle: Text(
                          m.defaultCategoryName != null ? 'קטגוריה: ${m.defaultCategoryName}' : 'ללא שיוך קבוע',
                          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(AppIcons.edit, size: 18),
                              tooltip: 'עריכת קטגוריית ברירת מחדל',
                              onPressed: () => _showEditMerchantCategoryDialog(m, allCategories),
                            ),
                            IconButton(
                              icon: const Icon(AppIcons.split, size: 18, color: AppColors.secondary),
                              tooltip: 'מיזוג בית עסק כפול',
                              onPressed: () => _showMergeDialog(m, merchants),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('שגיאה בטעינת בתי עסק: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

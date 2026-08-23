import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/models/category_model.dart';
import '../controllers/categories_controller.dart';
import '../widgets/category_delete_dialog.dart';
import '../widgets/category_edit_dialog.dart';
import '../widgets/merchant_management_dialog.dart';

/// Screen 20: Categories, Tags, and Merchants Management (עץ קטגוריות, תגיות ובתי עסק)
class CategoriesManagementScreen extends ConsumerStatefulWidget {
  const CategoriesManagementScreen({super.key});

  @override
  ConsumerState<CategoriesManagementScreen> createState() => _CategoriesManagementScreenState();
}

class _CategoriesManagementScreenState extends ConsumerState<CategoriesManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openCreateCategoryDialog({String? parentId, required String type, required List<CategoryModel> parents}) {
    CategoryEditDialog.show(
      context: context,
      initialParentId: parentId,
      initialType: type,
      availableParents: parents,
      onSave: (cat) async {
        await ref.read(categoriesControllerProvider).createCategory(
              name: cat.name,
              parentId: cat.parentId,
              type: cat.type,
              classification: cat.spendingClassification,
              flexibility: cat.flexibility,
              colorValue: cat.colorValue,
              iconName: cat.iconName,
            );
      },
    );
  }

  void _openEditCategoryDialog(CategoryModel category, List<CategoryModel> parents) {
    CategoryEditDialog.show(
      context: context,
      existingCategory: category,
      initialType: category.type,
      availableParents: parents,
      onSave: (cat) async {
        await ref.read(categoriesControllerProvider).updateCategory(cat);
      },
    );
  }

  void _openDeleteCategoryDialog(CategoryModel category, List<CategoryModel> allCategories) {
    showDialog(
      context: context,
      builder: (context) => CategoryDeleteDialog(
        category: category,
        otherCategories: allCategories,
        onConfirmDelete: (replacementId) async {
          await ref.read(categoriesControllerProvider).deleteCategory(
                category.id,
                replacementCategoryId: replacementId,
              );
        },
      ),
    );
  }

  void _openMerchantManagementDialog() {
    MerchantManagementDialog.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('עץ קטגוריות ובתי עסק'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.merchant),
            tooltip: 'ניהול ומיזוג בתי עסק',
            onPressed: _openMerchantManagementDialog,
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'הוצאות'),
            Tab(text: 'הכנסות'),
            Tab(text: 'תגיות'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCategoryTreeTab(type: 'expense'),
          _buildCategoryTreeTab(type: 'income'),
          _buildTagsTab(),
        ],
      ),
    );
  }

  Widget _buildCategoryTreeTab({required String type}) {
    final treeAsync = ref.watch(categoryTreeStreamProvider(type));
    final allAsync = ref.watch(allCategoriesStreamProvider(type));
    final allCategories = allAsync.value ?? [];

    return treeAsync.when(
      data: (parents) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            heroTag: 'categories_${type}_fab',
            onPressed: () => _openCreateCategoryDialog(type: type, parents: parents),
            icon: const Icon(AppIcons.add),
            label: Text(type == 'expense' ? 'הוספת קטגוריית הוצאה' : 'הוספת קטגוריית הכנסה'),
          ),
          body: parents.isEmpty
              ? const Center(child: Text('אין קטגוריות להצגה'))
              : ListView.builder(
                  padding: const EdgeInsets.only(
                    left: AppSpacing.lg,
                    right: AppSpacing.lg,
                    top: AppSpacing.md,
                    bottom: 80,
                  ),
                  itemCount: parents.length,
                  itemBuilder: (context, index) {
                    final parent = parents[index];
                    return _buildParentCategoryCard(parent, parents, allCategories);
                  },
                ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('שגיאה בטעינת קטגוריות: $err')),
    );
  }

  Widget _buildParentCategoryCard(
    CategoryModel parent,
    List<CategoryModel> parents,
    List<CategoryModel> allCategories,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 4),
        shape: const Border(),
        collapsedShape: const Border(),
        leading: CircleAvatar(
          backgroundColor: parent.color.withValues(alpha: 0.15),
          child: Icon(parent.icon, color: parent.color, size: 20),
        ),
        title: Text(
          parent.name,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Wrap(
            spacing: 6,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (parent.type == 'expense')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: AppSpacing.roundedSm,
                  ),
                  child: Text(
                    parent.spendingClassification.label,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                  ),
                ),
              Text(
                '${parent.subcategories.length} תתי-קטגוריות • ${parent.flexibility.label}',
                style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
              ),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(AppIcons.add, size: 18),
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              tooltip: 'הוספת תת-קטגוריה',
              onPressed: () => _openCreateCategoryDialog(
                parentId: parent.id,
                type: parent.type,
                parents: parents,
              ),
            ),
            IconButton(
              icon: const Icon(AppIcons.edit, size: 18),
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              tooltip: 'עריכה',
              onPressed: () => _openEditCategoryDialog(parent, parents),
            ),
            IconButton(
              icon: const Icon(AppIcons.delete, size: 18, color: AppColors.error),
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              tooltip: 'מחיקה',
              onPressed: () => _openDeleteCategoryDialog(parent, allCategories),
            ),
          ],
        ),
        children: [
          if (parent.subcategories.isEmpty)
            const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Text('אין תתי-קטגוריות עדיין', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
            )
          else
            ...parent.subcategories.map((child) {
              return Container(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.borderSubtle)),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: AppSpacing.sm, right: AppSpacing.xxl),
                  leading: CircleAvatar(
                    radius: 14,
                    backgroundColor: child.color.withValues(alpha: 0.12),
                    child: Icon(child.icon, color: child.color, size: 14),
                  ),
                  title: Text(
                    child.name,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${child.spendingClassification.label} • ${child.flexibility.label}',
                    style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(AppIcons.edit, size: 16),
                        visualDensity: VisualDensity.compact,
                        constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                        onPressed: () => _openEditCategoryDialog(child, parents),
                      ),
                      IconButton(
                        icon: const Icon(AppIcons.delete, size: 16, color: AppColors.error),
                        visualDensity: VisualDensity.compact,
                        constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                        onPressed: () => _openDeleteCategoryDialog(child, allCategories),
                      ),
                    ],
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildTagsTab() {
    final tagsAsync = ref.watch(tagsStreamProvider);
    final tagController = TextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'tags_add_fab',
        onPressed: () {
          tagController.clear();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            backgroundColor: AppColors.surface,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
            ),
            builder: (context) {
              int selectedColor = 0xFF64748B;
              return StatefulBuilder(
                builder: (context, setSheetState) {
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
                              'יצירת תגית חדשה',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                            ),
                            IconButton(
                              icon: const Icon(AppIcons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextField(
                          controller: tagController,
                          decoration: const InputDecoration(
                            labelText: 'שם התגית',
                            hintText: 'לדוגמה: #חופשה_באיטליה, #שיפוץ',
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        const Text('צבע תגית:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                        const SizedBox(height: AppSpacing.sm),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: AppColors.categoryPalette.map((col) {
                              final isSelected = col.toARGB32() == selectedColor;
                              return Padding(
                                padding: const EdgeInsets.only(left: AppSpacing.sm),
                                child: GestureDetector(
                                  onTap: () => setSheetState(() => selectedColor = col.toARGB32()),
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: col,
                                    child: isSelected ? const Icon(AppIcons.check, color: Colors.white, size: 16) : null,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        ElevatedButton(
                          onPressed: () async {
                            final name = tagController.text.trim();
                            if (name.isNotEmpty) {
                              await ref.read(categoriesControllerProvider).createTag(
                                    name.startsWith('#') ? name : '#$name',
                                    selectedColor,
                                  );
                              if (context.mounted) Navigator.pop(context);
                            }
                          },
                          child: const Text('צור תגית'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        icon: const Icon(AppIcons.add),
        label: const Text('הוספת תגית חדשה'),
      ),
      body: tagsAsync.when(
        data: (tags) {
          if (tags.isEmpty) {
            return const Center(child: Text('אין תגיות עדיין. לחץ למטה ליצירת תגית ראשונה.'));
          }

          return Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: tags.map((t) {
                return Chip(
                  avatar: CircleAvatar(
                    radius: 6,
                    backgroundColor: Color(t.colorValue),
                  ),
                  label: Text(t.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                  deleteIcon: const Icon(AppIcons.close, size: 14),
                  onDeleted: () async {
                    await ref.read(categoriesControllerProvider).deleteTag(t.id);
                  },
                );
              }).toList(),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('שגיאה בטעינת תגיות: $err')),
      ),
    );
  }
}

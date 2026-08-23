import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../categories_tags/presentation/controllers/categories_controller.dart';
import '../../../categories_tags/presentation/widgets/category_search_picker.dart';
import '../../domain/models/category_rule_model.dart';
import '../controllers/auto_categorization_controller.dart';

/// Screen for managing custom categorization rules (ניהול כללי סיווג אוטומטיים)
class CategoryRulesScreen extends ConsumerWidget {
  const CategoryRulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rulesAsync = ref.watch(categoryRulesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('כללי סיווג אוטומטיים'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.add),
            tooltip: 'הוסף כלל חדש',
            onPressed: () => _showAddRuleDialog(context, ref),
          ),
        ],
      ),
      body: rulesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('שגיאה בטעינת כללים: $err')),
        data: (rules) {
          if (rules.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(AppIcons.uncategorized, size: 64, color: AppColors.textMuted.withAlpha(100)),
                  const SizedBox(height: AppSpacing.md),
                  const Text(
                    'אין כללי סיווג מוגדרים',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  const Text(
                    'הגדר כללים לסיווג אוטומטי (למשל: תיאור שמכיל "פז" יסווג ל"דלק")',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ElevatedButton.icon(
                    onPressed: () => _showAddRuleDialog(context, ref),
                    icon: const Icon(AppIcons.add),
                    label: const Text('הוסף כלל סיווג ראשון'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: AppSpacing.screenPadding,
            itemCount: rules.length,
            itemBuilder: (context, index) {
              final rule = rules[index];
              final catIcon = AppIcons.fromString(rule.categoryIcon ?? '', fallback: AppIcons.uncategorized);
              final color = Color(rule.categoryColor ?? 0xFF3B82F6);

              return Card(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color.withAlpha(30),
                    child: Icon(catIcon, color: color, size: 18),
                  ),
                  title: Text(
                    '${rule.matchType.labelHebrew} "${rule.pattern}"',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    'יסווג אוטומטית לקטגוריה: ${rule.categoryName ?? 'ללא שם'}',
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  trailing: IconButton(
                    icon: const Icon(AppIcons.delete, size: 20, color: AppColors.error),
                    tooltip: 'מחק כלל',
                    onPressed: () async {
                      await ref.read(autoCategorizationRepositoryProvider).deleteCategoryRule(rule.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddRuleDialog(BuildContext context, WidgetRef ref) {
    final patternController = TextEditingController();
    RuleMatchType matchType = RuleMatchType.contains;
    String? selectedCategoryId;
    bool applyRetroactively = true;

    final categories = ref.read(allCategoriesStreamProvider(null)).value ?? [];
    if (categories.isNotEmpty) {
      selectedCategoryId = categories.first.id;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setSheetState) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'הוספת כלל סיווג אוטומטי',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                      ),
                      IconButton(
                        icon: const Icon(AppIcons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Text('טקסט לזיהוי בתיאור העסקה:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 4),
                  TextField(
                    controller: patternController,
                    decoration: const InputDecoration(
                      hintText: 'לדוגמה: פז, שופרסל, הוט, נטפליקס...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Text('סוג התאמה:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 4),
                  DropdownButtonFormField<RuleMatchType>(
                    value: matchType,
                    isDense: true,
                    style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                    items: RuleMatchType.values.map((m) {
                      return DropdownMenuItem(value: m, child: Text(m.labelHebrew, style: const TextStyle(fontSize: 13)));
                    }).toList(),
                    onChanged: (val) => setSheetState(() => matchType = val!),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Text('סווג לקטגוריה:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 4),
                  InkWell(
                    onTap: () async {
                      final selected = await CategorySearchPicker.show(
                        context: context,
                        categories: categories,
                        selectedCategoryId: selectedCategoryId,
                        title: 'בחירת קטגוריה לכלל',
                      );
                      if (selected != null) {
                        setSheetState(() => selectedCategoryId = selected.id);
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
                          if (selectedCategoryId != null) ...[
                            Builder(builder: (context) {
                              final selectedCat = categories.where((c) => c.id == selectedCategoryId).firstOrNull;
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
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('החל רטרואקטיבית על כל עסקאות העבר ללא סיווג', style: TextStyle(fontSize: 12)),
                    value: applyRetroactively,
                    onChanged: (val) => setSheetState(() => applyRetroactively = val ?? true),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ElevatedButton(
                    onPressed: () async {
                      final text = patternController.text.trim();
                      if (text.isEmpty || selectedCategoryId == null) return;

                      final rule = CategoryRuleModel(
                        id: 'rule_${DateTime.now().millisecondsSinceEpoch}',
                        pattern: text,
                        matchType: matchType,
                        categoryId: selectedCategoryId!,
                        createdAt: DateTime.now(),
                      );

                      final repo = ref.read(autoCategorizationRepositoryProvider);
                      await repo.saveCategoryRule(rule);

                      if (applyRetroactively) {
                        final count = await repo.applyRuleRetroactively(rule);
                        if (context.mounted && count > 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('הכלל הוחל רטרואקטיבית וסיווג $count עסקאות קודמות!')),
                          );
                        }
                      }

                      ref.read(uncategorizedSuggestionsProvider.notifier).refresh();
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('שמור כלל סיווג', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

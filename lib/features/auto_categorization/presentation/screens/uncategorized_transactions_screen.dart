import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../categories_tags/presentation/controllers/categories_controller.dart';
import '../controllers/auto_categorization_controller.dart';
import 'category_rules_screen.dart';

/// Screen 9: Uncategorized Transactions & Smart Category Suggestions (עסקאות לסיווג והצעות חכמות)
class UncategorizedTransactionsScreen extends ConsumerWidget {
  const UncategorizedTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestionsAsync = ref.watch(uncategorizedSuggestionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('עסקאות לסיווג והצעות חכמות'),
        actions: [
          IconButton(
            icon: const Icon(AppIcons.uncategorized),
            tooltip: 'ניהול כללי סיווג',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoryRulesScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(AppIcons.refresh),
            tooltip: 'רענן הצעות',
            onPressed: () => ref.read(uncategorizedSuggestionsProvider.notifier).refresh(),
          ),
        ],
      ),
      bottomNavigationBar: suggestionsAsync.maybeWhen(
        data: (items) {
          final withSuggestions = items.where((i) => i.hasSuggestion).length;
          if (withSuggestions == 0) return null;

          return Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(15),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await ref.read(uncategorizedSuggestionsProvider.notifier).applyAll();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('אושר סיווג עבור $withSuggestions עסקאות בהצלחה!'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  }
                },
                icon: const Icon(AppIcons.check),
                label: Text('אשר את כל $withSuggestions ההצעות בבת אחת'),
              ),
            ),
          );
        },
        orElse: () => null,
      ),
      body: suggestionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('שגיאה בטעינת עסקאות לסיווג: $err')),
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(AppIcons.successCircle, size: 64, color: AppColors.success.withAlpha(120)),
                  const SizedBox(height: AppSpacing.md),
                  const Text(
                    'מעולה! כל העסקאות מסווגות',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  const Text(
                    'אין תנועות הממתינות לקטגוריה כעת',
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                ],
              ),
            );
          }

          final withSuggestions = items.where((i) => i.hasSuggestion).length;

          return ListView(
            padding: AppSpacing.screenPadding,
            children: [
              // Header Summary Banner
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.primary.withAlpha(40)),
                ),
                child: Row(
                  children: [
                    const Icon(AppIcons.netWorth, color: AppColors.primary, size: 24),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'נמצאו ${items.length} עסקאות ללא קטגוריה',
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.primaryDark),
                          ),
                          Text(
                            'ל-$withSuggestions מתוכן יש הצעת סיווג חכמה מוכנה',
                            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Items List
              Column(
                children: items.map((item) {
                  final hasCat = item.hasSuggestion;
                  final color = Color(item.suggestedCategoryColor ?? 0xFF64748B);
                  final icon = AppIcons.fromString(item.suggestedCategoryIcon ?? '', fallback: AppIcons.uncategorized);

                  return Card(
                    margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Padding(
                      padding: AppSpacing.cardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppDateFormatter.formatShortDate(item.date),
                                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                              ),
                              const Spacer(),
                              Text(
                                CurrencyFormatter.formatILS(item.amount),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.expense,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.description,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          const Divider(height: 1),
                          const SizedBox(height: AppSpacing.sm),

                          // Smart Suggestion Chip / Category Picker Button
                          Row(
                            children: [
                              if (hasCat) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: color.withAlpha(25),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: color.withAlpha(60)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(icon, size: 14, color: color),
                                      const SizedBox(width: 6),
                                      Text(
                                        item.suggestedCategoryName!,
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '• ${item.reason}',
                                  style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                                ),
                              ] else
                                const Text(
                                  'לא נמצאה התאמה אוטומטית',
                                  style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                                ),
                              const Spacer(),
                              TextButton(
                                style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
                                onPressed: () => _openCategorySelector(context, ref, item.transactionId),
                                child: Text(
                                  hasCat ? 'שנה' : 'בחר קטגוריה',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 80),
            ],
          );
        },
      ),
    );
  }

  void _openCategorySelector(BuildContext context, WidgetRef ref, String transactionId) {
    final allCats = ref.read(allCategoriesStreamProvider(null)).value ?? [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('בחר קטגוריה לעסקה', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: ListView.builder(
                  itemCount: allCats.length,
                  itemBuilder: (context, index) {
                    final cat = allCats[index];
                    final color = Color(cat.colorValue);
                    final icon = AppIcons.fromString(cat.iconName, fallback: AppIcons.uncategorized);

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: color.withAlpha(30),
                        child: Icon(icon, color: color, size: 18),
                      ),
                      title: Text(cat.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                      onTap: () {
                        ref.read(uncategorizedSuggestionsProvider.notifier).updateCategory(
                              transactionId,
                              cat.id,
                              cat.name,
                              cat.colorValue,
                              cat.iconName,
                            );
                        Navigator.pop(ctx);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

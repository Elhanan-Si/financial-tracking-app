import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/date_formatter.dart';
import '../controllers/import_controller.dart';

/// Screen 8 (Part 3): Import Batches History & Rollback Management
class ImportBatchesHistoryScreen extends ConsumerWidget {
  const ImportBatchesHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batchesAsync = ref.watch(importBatchesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('היסטוריית אצוות ייבוא וביטולים'),
      ),
      body: batchesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('שגיאה בטעינת היסטוריה: $err')),
        data: (batches) {
          if (batches.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(AppIcons.transactions, size: 64, color: AppColors.textMuted.withAlpha(100)),
                  const SizedBox(height: AppSpacing.md),
                  const Text('טרם בוצעו ייבויי קבצים במערכת', style: TextStyle(color: AppColors.textSecondary)),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: AppSpacing.screenPadding,
            itemCount: batches.length,
            itemBuilder: (context, index) {
              final batch = batches[index];
              final isRolledBack = batch.isRolledBack;

              return Card(
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Padding(
                  padding: AppSpacing.cardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isRolledBack ? AppColors.expenseLight : AppColors.incomeLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isRolledBack ? 'בוטל (Rolled Back)' : 'הושלם בהצלחה',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: isRolledBack ? AppColors.error : AppColors.success,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            AppDateFormatter.formatShortDate(batch.importedAt),
                            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'מקור: ${batch.sourceName} • קובץ: ${batch.fileName}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'סך הכל ${batch.totalRows} שורות • יובאו: ${batch.importedRows} • דולגו/אוחדו: ${batch.duplicatesSkipped}',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      const Divider(height: AppSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (!isRolledBack)
                            TextButton.icon(
                              style: TextButton.styleFrom(foregroundColor: AppColors.error),
                              icon: const Icon(AppIcons.delete, size: 16),
                              label: const Text('בטל ייבוא (Rollback)', style: TextStyle(fontSize: 12)),
                              onPressed: () => _confirmRollback(context, ref, batch.id),
                            )
                          else
                            const Text(
                              'כל התנועות באצווה זו נמחקו והיתרות שוחזרו',
                              style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _confirmRollback(BuildContext context, WidgetRef ref, String batchId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('ביטול אצוות ייבוא (Rollback)'),
        content: const Text(
          'פעולה זו תמחק לחלוטין את כל התנועות שנוצרו באצווה זו ותשחזר את יתרות החשבון המדויקות למצבן הקודם.\n\nהאם להמשיך?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('ביטול'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await ref.read(importControllerProvider).rollbackBatch(batchId);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('האצווה בוטלה בהצלחה ויתרות החשבון שוחזרו.'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('שגיאה בביטול אצווה: $e'), backgroundColor: AppColors.error),
                  );
                }
              }
            },
            child: const Text('מחק תנועות ושחזר יתרות'),
          ),
        ],
      ),
    );
  }
}

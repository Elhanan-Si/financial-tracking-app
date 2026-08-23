import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/models/duplicate_match_result.dart';
import '../controllers/import_controller.dart';

/// Screen 8 (Part 2): Import Preview & Deduplication Resolution
class ImportPreviewScreen extends ConsumerWidget {
  final String accountId;
  final String accountName;
  final String sourceName;
  final String fileName;

  const ImportPreviewScreen({
    super.key,
    required this.accountId,
    required this.accountName,
    required this.sourceName,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchResults = ref.watch(activeImportResultsProvider);

    final totalRows = matchResults.length;
    final exactCount = matchResults.where((r) => r.confidence == DuplicateConfidenceLevel.exact).length;
    final fuzzyCount = matchResults.where((r) => r.confidence == DuplicateConfidenceLevel.fuzzy).length;
    final newCount = matchResults.where((r) => r.confidence == DuplicateConfidenceLevel.none).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('תצוגה מקדימה ואימות נתונים'),
      ),
      bottomNavigationBar: Container(
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
            onPressed: totalRows == 0
                ? null
                : () async {
                    try {
                      await ref.read(importControllerProvider).executeImport(
                            accountId: accountId,
                            sourceName: sourceName,
                            fileName: fileName,
                          );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('הייבוא הושלם בהצלחה! יתרות החשבון עודכנו.'),
                            backgroundColor: AppColors.success,
                          ),
                        );
                        Navigator.pop(context); // Pop Preview
                        Navigator.pop(context); // Pop Upload
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('שגיאה בייבוא: $e'), backgroundColor: AppColors.error),
                        );
                      }
                    }
                  },
            icon: const Icon(AppIcons.check),
            label: Text('אשר וייבא $totalRows תנועות לחשבון $accountName'),
          ),
        ),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          // Summary Metrics Banner
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'מקור: $sourceName • $fileName',
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textSecondary),
                    ),
                    Text(
                      '$totalRows שורות',
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.primary),
                    ),
                  ],
                ),
                const Divider(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatPill('חדשות', '$newCount', AppColors.income, AppColors.incomeLight),
                    _buildStatPill('איחוד אוטומטי', '$exactCount', AppColors.primary, AppColors.primaryLight),
                    if (fuzzyCount > 0)
                      _buildStatPill('דורש בדיקה', '$fuzzyCount', AppColors.warning, AppColors.warningLight),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          const Text(
            'פירוט עסקאות לעיבוד',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Items List
          Column(
            children: List.generate(matchResults.length, (index) {
              final item = matchResults[index];
              final row = item.parsedRow;
              final isExpense = row.amount < 0;

              Color statusColor = AppColors.income;
              Color statusBg = AppColors.incomeLight;
              String statusLabel = 'תנועה חדשה';

              if (item.confidence == DuplicateConfidenceLevel.exact) {
                statusColor = AppColors.primary;
                statusBg = AppColors.primaryLight;
                statusLabel = 'איחוד ודאי';
              } else if (item.confidence == DuplicateConfidenceLevel.fuzzy) {
                statusColor = AppColors.warning;
                statusBg = AppColors.warningLight;
                statusLabel = 'איחוד סביר (ספק כפילות)';
              }

              return Card(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Padding(
                  padding: AppSpacing.cardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              statusLabel,
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: statusColor),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            AppDateFormatter.formatShortDate(row.date),
                            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  row.merchantName ?? row.rawDescription,
                                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                                ),
                                if (row.rawDescription != (row.merchantName ?? ''))
                                  Text(
                                    row.rawDescription,
                                    style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            CurrencyFormatter.formatILS(row.amount.abs()),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: isExpense ? AppColors.expense : AppColors.income,
                            ),
                          ),
                        ],
                      ),

                      // Resolution Actions for Fuzzy or Duplicate
                      if (item.confidence != DuplicateConfidenceLevel.none) ...[
                        const Divider(height: AppSpacing.md),
                        Row(
                          children: [
                            const Text('פעולה:', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                            const SizedBox(width: 8),
                            SegmentedButton<DuplicateResolutionAction>(
                              style: const ButtonStyle(visualDensity: VisualDensity.compact),
                              segments: const [
                                ButtonSegment(
                                  value: DuplicateResolutionAction.merge,
                                  label: Text('איחוד', style: TextStyle(fontSize: 10)),
                                ),
                                ButtonSegment(
                                  value: DuplicateResolutionAction.importAsNew,
                                  label: Text('ייבא בנפרד', style: TextStyle(fontSize: 10)),
                                ),
                                ButtonSegment(
                                  value: DuplicateResolutionAction.skip,
                                  label: Text('דלג', style: TextStyle(fontSize: 10)),
                                ),
                              ],
                              selected: {item.resolution},
                              onSelectionChanged: (set) {
                                ref.read(importControllerProvider).updateRowResolution(index, set.first);
                              },
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildStatPill(String label, String count, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(count, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: color)),
          Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}

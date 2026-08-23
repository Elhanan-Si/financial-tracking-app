import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/models/pension_asset_model.dart';
import '../controllers/pension_controller.dart';
import 'add_pension_asset_dialog.dart';

/// Screen 16: Pension Assets, Study Funds & Long-Term Savings (נכסים פנסיוניים וקרנות השתלמות)
class PensionAssetsScreen extends ConsumerWidget {
  const PensionAssetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(pensionSummaryStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('נכסים פנסיוניים וחיסכון'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AddPensionAssetDialog.show(context),
        icon: const Icon(AppIcons.add),
        label: const Text('הוסף מוצר פנסיוני'),
      ),
      body: summaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('שגיאה: $err')),
        data: (summary) {
          return ListView(
            padding: AppSpacing.screenPadding,
            children: [
              // 1. Hero Combined Value Card
              Container(
                padding: AppSpacing.cardPadding,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.secondary, AppColors.secondaryDark],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: AppSpacing.roundedXl,
                  boxShadow: AppSpacing.elevatedShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('סך חיסכון פנסיוני וארוך טווח', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        Icon(AppIcons.savings, color: Colors.white70, size: 20),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      CurrencyFormatter.formatILS(summary.totalCombinedValue),
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                    const Divider(color: Colors.white24, height: AppSpacing.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeroStat('הפקדות חודשיות שוטפות', CurrencyFormatter.formatILS(summary.totalMonthlyContributions)),
                        _buildHeroStat('מוצרים פעילים', '${summary.assets.length} קופות וקרנות'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 2. Summary Category Tiles
              Row(
                children: [
                  Expanded(
                    child: _buildCategorySummaryCard(
                      title: 'קרנות פנסיה',
                      value: summary.totalPensionValue,
                      icon: AppIcons.savings,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _buildCategorySummaryCard(
                      title: 'קרנות השתלמות',
                      value: summary.totalStudyFundValue,
                      icon: AppIcons.bank,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _buildCategorySummaryCard(
                      title: 'קופות גמל',
                      value: summary.totalProvidentFundValue,
                      icon: AppIcons.netWorth,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              // 3. Assets List
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('פירוט קופות וקרנות', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  Text('${summary.assets.length} מוצרים', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),

              if (summary.assets.isEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Column(
                      children: [
                        Icon(AppIcons.savings, size: 48, color: AppColors.textMuted.withAlpha(100)),
                        const SizedBox(height: AppSpacing.sm),
                        const Text('טרם הוזנו נכסים פנסיוניים', style: TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        const Text('הוסף את קרן הפנסיה, קרן ההשתלמות או קופת הגמל שלך למעקב כולל', style: TextStyle(fontSize: 12, color: AppColors.textSecondary), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                )
              else
                Column(
                  children: summary.assets.map((asset) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Padding(
                        padding: AppSpacing.cardPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundColor: AppColors.secondaryLight,
                                      child: const Icon(AppIcons.savings, size: 16, color: AppColors.secondary),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(asset.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                                        Text(
                                          '${asset.providerName}${asset.trackName != null ? ' • ${asset.trackName}' : ''}',
                                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    asset.type.labelHebrew,
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: AppSpacing.md),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('יתרה עדכנית', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                                    Text(
                                      CurrencyFormatter.formatILS(asset.currentBalance),
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
                                    ),
                                  ],
                                ),
                                if (asset.totalMonthlyDeposit > 0)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('הפקדה חודשית', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                                      Text(
                                        CurrencyFormatter.formatILS(asset.totalMonthlyDeposit),
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.income),
                                      ),
                                    ],
                                  ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    minimumSize: Size.zero,
                                  ),
                                  onPressed: () => _showUpdateBalanceDialog(context, ref, asset),
                                  child: const Text('עדכן יתרה', style: TextStyle(fontSize: 12)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'עודכן לאחרונה: ${AppDateFormatter.formatShortDate(asset.lastUpdatedDate)}',
                              style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
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

  Widget _buildHeroStat(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _buildCategorySummaryCard({required String title, required double value, required IconData icon}) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.roundedMd,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: AppColors.secondary),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary), maxLines: 1),
          const SizedBox(height: 2),
          Text(
            CurrencyFormatter.formatCompactILS(value),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  void _showUpdateBalanceDialog(BuildContext context, WidgetRef ref, PensionAssetModel asset) {
    final controller = TextEditingController(text: asset.currentBalance.toStringAsFixed(0));

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('עדכון יתרה: ${asset.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('הזן את היתרה החדשה מתוך הדוח התקופתי של החברה המנהלת:', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'יתרה חדשה (₪) *',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('ביטול')),
          ElevatedButton(
            onPressed: () async {
              final newBal = double.tryParse(controller.text.trim()) ?? 0.0;
              if (newBal <= 0) return;

              Navigator.pop(ctx);
              await ref.read(pensionControllerProvider).updateBalance(asset.id, newBal, DateTime.now());

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('היתרה עודכנה ונשמרה תמונת מצב היסטורית!'), backgroundColor: AppColors.success),
                );
              }
            },
            child: const Text('שמור יתרה'),
          ),
        ],
      ),
    );
  }
}

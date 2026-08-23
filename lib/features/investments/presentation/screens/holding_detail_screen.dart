import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/models/holding_model.dart';
import '../../domain/models/investment_transaction_model.dart';
import '../controllers/investments_controller.dart';

/// Screen 15: Holding Details & Investment Transaction History (פרטי אחזקה ועסקאות)
class HoldingDetailScreen extends ConsumerWidget {
  final String holdingId;

  const HoldingDetailScreen({super.key, required this.holdingId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final holdingsAsync = ref.watch(holdingsStreamProvider);

    return holdingsAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, _) => Scaffold(body: Center(child: Text('שגיאה: $err'))),
      data: (holdings) {
        final holding = holdings.where((h) => h.id == holdingId).firstOrNull;
        if (holding == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('פרטי אחזקה')),
            body: const Center(child: Text('האחזקה לא נמצאה (ייתכן שנמכרה במלואה)')),
          );
        }

        final txAsync = ref.watch(holdingTransactionsStreamProvider(holding.securityId));

        final isProfit = holding.unrealizedProfitLoss >= 0;

        return Scaffold(
          appBar: AppBar(
            title: Text('${holding.securityTicker} • ${holding.securityName}'),
            actions: [
              IconButton(
                icon: const Icon(AppIcons.refresh),
                tooltip: 'רענן שערים',
                onPressed: () => ref.read(investmentsControllerProvider).syncPrices(),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(15),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(foregroundColor: AppColors.expense),
                    onPressed: () => _showSellDialog(context, ref, holding),
                    icon: const Icon(AppIcons.expense, size: 16),
                    label: const Text('מכירת יחידות'),
                  ),
                ),
              ],
            ),
          ),
          body: ListView(
            padding: AppSpacing.screenPadding,
            children: [
              // 1. Hero Holding Value Card
              Container(
                padding: AppSpacing.cardPadding,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: AppSpacing.roundedXl,
                  boxShadow: AppSpacing.elevatedShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(40),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            holding.securityType.labelHebrew,
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                          ),
                        ),
                        if (holding.lastPriceUpdate != null)
                          Text(
                            'מעודכן: ${AppDateFormatter.formatShortDate(holding.lastPriceUpdate!)}',
                            style: const TextStyle(color: Colors.white70, fontSize: 11),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const Text('שווי שוק נוכחי (בשקלים)', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text(
                      CurrencyFormatter.formatILS(holding.currentMarketValueILS),
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                    Text(
                      '${holding.quantity} יחידות • \$${holding.currentPrice.toStringAsFixed(2)} ליחידה',
                      style: const TextStyle(fontSize: 13, color: Colors.white70),
                    ),
                    const Divider(color: Colors.white24, height: AppSpacing.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeroStat('עלות בסיס כוללת', CurrencyFormatter.formatILS(holding.totalCostBasisILS)),
                        _buildHeroStat(
                          'רווח/הפסד לא ממומש',
                          '${isProfit ? '+' : ''}${CurrencyFormatter.formatILS(holding.unrealizedProfitLossILS)} (${holding.unrealizedProfitLossPercent.toStringAsFixed(1)}%)',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 2. TASK-25: Multi-Currency Breakdown Section
              const Text('ניתוח רב-מטבעי (מניה מול שער חליפין)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              const SizedBox(height: AppSpacing.xs),
              Card(
                child: Padding(
                  padding: AppSpacing.cardPadding,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(AppIcons.stock, size: 18, color: AppColors.primary),
                          const SizedBox(width: 8),
                          const Expanded(child: Text('רווח ממחיר המניה במטבע מקור (\$)', style: TextStyle(fontSize: 13))),
                          Text(
                            '${holding.unrealizedProfitLoss >= 0 ? '+' : ''}\$${holding.unrealizedProfitLoss.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: holding.unrealizedProfitLoss >= 0 ? AppColors.income : AppColors.expense,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: AppSpacing.md),
                      Row(
                        children: [
                          const Icon(AppIcons.transfer, size: 18, color: AppColors.primary),
                          const SizedBox(width: 8),
                          const Expanded(child: Text('השפעת שער החליפין דולר/שקל (FX)', style: TextStyle(fontSize: 13))),
                          Text(
                            '${holding.currencyGainILS >= 0 ? '+' : ''}${CurrencyFormatter.formatILS(holding.currencyGainILS)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: holding.currencyGainILS >= 0 ? AppColors.income : AppColors.expense,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 3. Transactions History List
              const Text('היסטוריית עסקאות ודיבידנדים', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              const SizedBox(height: AppSpacing.xs),

              txAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('שגיאה: $err')),
                data: (txList) {
                  if (txList.isEmpty) {
                    return const Card(
                      child: Padding(
                        padding: AppSpacing.cardPadding,
                        child: Center(child: Text('אין עסקאות שמורות עבור נייר ערך זה')),
                      ),
                    );
                  }

                  return Column(
                    children: txList.map((tx) {
                      final isBuy = tx.type == InvestmentTransactionType.buy;
                      final typeColor = isBuy ? AppColors.primary : (tx.type == InvestmentTransactionType.sell ? AppColors.expense : AppColors.income);

                      return Card(
                        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: typeColor.withAlpha(25),
                            child: Icon(
                              isBuy ? AppIcons.income : (tx.type == InvestmentTransactionType.sell ? AppIcons.expense : AppIcons.savings),
                              color: typeColor,
                              size: 18,
                            ),
                          ),
                          title: Text(
                            '${tx.type.labelHebrew} ${tx.quantity} יח\' במחיר \$${tx.pricePerUnit.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                          subtitle: Text(
                            AppDateFormatter.formatShortDate(tx.date),
                            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                          ),
                          trailing: Text(
                            CurrencyFormatter.formatILS(tx.totalAmountILS),
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: typeColor),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 80),
            ],
          ),
        );
      },
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

  void _showSellDialog(BuildContext context, WidgetRef ref, HoldingModel holding) {
    final qtyController = TextEditingController(text: holding.quantity.toString());
    final priceController = TextEditingController(text: holding.currentPrice.toString());
    final feeController = TextEditingController(text: '0');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('מכירת יחידות ${holding.securityTicker}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('יחידות קיימות באחזקה: ${holding.quantity}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: qtyController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'כמות יחידות למכירה *', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'מחיר מכירה ליחידה (\$) *', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: feeController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'עמלת מכירה', border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('ביטול')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.expense),
            onPressed: () async {
              final qty = double.tryParse(qtyController.text.trim()) ?? 0.0;
              final price = double.tryParse(priceController.text.trim()) ?? 0.0;
              final fee = double.tryParse(feeController.text.trim()) ?? 0.0;

              if (qty <= 0 || qty > holding.quantity || price <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('כמות לא תקינה או חורגת מסך האחזקה')),
                );
                return;
              }

              Navigator.pop(ctx);
              await ref.read(investmentsControllerProvider).recordSell(
                    holdingId: holding.id,
                    quantity: qty,
                    pricePerUnit: price,
                    fee: fee,
                    date: DateTime.now(),
                  );

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('מכירת יחידות נשמרה בהצלחה!'), backgroundColor: AppColors.success),
                );
              }
            },
            child: const Text('בצע מכירה'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_names.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/financial_info_tooltip.dart';
import '../controllers/investments_controller.dart';
import 'add_investment_transaction_dialog.dart';

/// Screen 14: Stock Portfolio & Investment Holdings (תיק השקעות ומדדי ייחוס)
class InvestmentsScreen extends ConsumerStatefulWidget {
  const InvestmentsScreen({super.key});

  @override
  ConsumerState<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends ConsumerState<InvestmentsScreen> {
  bool _isUSD = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(investmentsControllerProvider).syncPrices();
    });
  }

  String _formatAmount(double amountILS, double fxRate) {
    if (_isUSD) {
      final usd = fxRate > 0 ? amountILS / fxRate : amountILS;
      return '\$${usd.toStringAsFixed(2)}';
    }
    return CurrencyFormatter.formatILS(amountILS);
  }

  String _formatProfitAmount(double amountILS, double fxRate) {
    if (_isUSD) {
      final usd = fxRate > 0 ? amountILS / fxRate : amountILS;
      return '${usd >= 0 ? '+' : ''}\$${usd.toStringAsFixed(2)}';
    }
    final prefix = amountILS >= 0 ? '+' : '';
    return '$prefix${CurrencyFormatter.formatILS(amountILS)}';
  }

  @override
  Widget build(BuildContext context) {
    final summaryAsync = ref.watch(portfolioSummaryStreamProvider);
    final benchmarksAsync = ref.watch(benchmarksProvider);
    final usdRateAsync = ref.watch(usdToIlsRateStreamProvider);
    final usdRate = usdRateAsync.value ?? 3.65;

    return Scaffold(
      appBar: AppBar(
        title: const Text('השקעות ונכסים'),
        actions: [
          const FinancialInfoTooltip(
            title: 'תיק השקעות, מדדים ושערי מט"ח',
            explanation: 'ניהול ומעקב אחר ניירות ערך סחירים (מניות, קרנות סל, אג"ח):\n\n• שווי תיק כולל: סך כל ערך השוק של הפוזיציות הפעילות לפי מחיר היחידה האחרון.\n\n• עלות בסיס ממוצעת (Average Cost Basis): סך כל עלות הרכישה המשוקללת של הניירות כולל עמלות.\n\n• רווח/הפסד לא ממומש: ההפרש בין שווי השוק הנוכחי לעלות הבסיס.\n\n• הפרדת רווח נייר מול רווח מט"ח: המערכת מפרידה בין שינוי מחיר המניה בבורסה לבין שינויים בשער הדולר/שקל.\n\n• שערי חליפין: המרת שווי התיק בין שקלים (₪) לדולרים (\$) מתבצעת בזמן אמת לפי שער החליפין היציג הנמשך ישירות מה-API.',
            formula: 'רווח כולל = (שווי שוק נוכחי - עלות בסיס)\nשווי בדולרים = שווי בשקלים / שער דולר-שקל',
            practicalTip: 'שימוש במתג ₪ / \$ מאפשר לבחון את ביצועי התיק במטבע המקור של המניות ללא תנודות מט"ח.',
          ),
          IconButton(
            icon: const Icon(AppIcons.refresh),
            tooltip: 'רענן שערי מניות ומט"ח מ-API',
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('מרענן שערי מניות ומט"ח מ-API...'), duration: Duration(seconds: 1)),
              );
              await ref.read(investmentsControllerProvider).syncPrices();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AddInvestmentTransactionDialog.show(context),
        icon: const Icon(AppIcons.add),
        label: const Text('הוסף נייר ערך'),
      ),
      body: summaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('שגיאה בטעינת תיק השקעות: $err')),
        data: (summary) {
          final isProfit = summary.totalUnrealizedProfitLossILS >= 0;

          return RefreshIndicator(
            onRefresh: () => ref.read(investmentsControllerProvider).syncPrices(),
            child: ListView(
              padding: AppSpacing.screenPadding,
              children: [
                // 1. Permanent USD/ILS Exchange Rate Header & Currency Switcher
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(AppIcons.transfer, size: 16, color: AppColors.primary),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('שער יציג דולר/שקל', style: TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                              Text(
                                '1.00 USD = ₪${usdRate.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Currency Toggle (₪ / $)
                      SegmentedButton<bool>(
                        segments: const [
                          ButtonSegment(
                            value: false,
                            label: Text('₪ שקל', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                          ),
                          ButtonSegment(
                            value: true,
                            label: Text('\$ דולר', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                          ),
                        ],
                        selected: {_isUSD},
                        onSelectionChanged: (set) => setState(() => _isUSD = set.first),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // 2. Quick Hub Navigation Cards to Pension and Non-Market Assets
                Row(
                  children: [
                    Expanded(
                      child: _buildSubHubCard(
                        context,
                        title: 'נכסים פנסיוניים',
                        subtitle: 'פנסיה, השתלמות, גמל',
                        icon: AppIcons.savings,
                        color: AppColors.secondary,
                        onTap: () => context.push(AppRoutes.pensionAssets),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _buildSubHubCard(
                        context,
                        title: 'נכסים והתחייבויות',
                        subtitle: 'נדל"ן, רכב, משכנתאות',
                        icon: AppIcons.bank,
                        color: AppColors.primaryDark,
                        onTap: () => context.push(AppRoutes.nonMarketAssets),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // 3. Hero Portfolio Balance Card
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
                          Text('שווי תיק ניירות ערך ${_isUSD ? '(USD)' : '(ILS)'}', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                          const Icon(AppIcons.stock, color: Colors.white70, size: 20),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        _formatAmount(summary.totalPortfolioValueILS, usdRate),
                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isProfit ? AppColors.income.withAlpha(200) : AppColors.expense.withAlpha(200),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${isProfit ? 'רווח כולל: ' : 'הפסד כולל: '}${_formatProfitAmount(summary.totalUnrealizedProfitLossILS, usdRate)} (${summary.totalUnrealizedProfitLossPercent.toStringAsFixed(1)}%)',
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Divider(color: Colors.white24, height: AppSpacing.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHeroStat('עלות בסיס', _formatAmount(summary.totalCostBasisILS, usdRate)),
                          _buildHeroStat('ניירות ערך פעילים', '${summary.totalHoldingsCount} פוזיציות'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // 4. Benchmarks Comparison Section
                const Text('מדדי ייחוס מובילים', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                const SizedBox(height: AppSpacing.xs),
                benchmarksAsync.when(
                  loading: () => const SizedBox(height: 80, child: Center(child: CircularProgressIndicator())),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (benchmarks) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: benchmarks.map((bm) {
                          return Container(
                            width: 140,
                            margin: const EdgeInsets.only(left: AppSpacing.sm),
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: AppSpacing.roundedMd,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(bm.name, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 2),
                                Text(
                                  bm.ticker.contains('TA') ? '₪${bm.currentPrice.toStringAsFixed(1)}' : '\$${bm.currentPrice.toStringAsFixed(1)}',
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Text('YTD: ', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                                    Text(
                                      '+${bm.returnYtdPercent}%',
                                      style: const TextStyle(fontSize: 11, color: AppColors.income, fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.lg),

                // 5. Holdings List Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('אחזקות פעילות', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                    Text('${summary.holdings.length} ניירות ערך', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),

                if (summary.holdings.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        children: [
                          Icon(AppIcons.stock, size: 48, color: AppColors.textMuted.withAlpha(100)),
                          const SizedBox(height: AppSpacing.sm),
                          const Text('תיק ההשקעות שלך ריק', style: TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          const Text('הוסף עסקאות קנייה ראשונות של מניות, קרנות סל או אג"ח', style: TextStyle(fontSize: 12, color: AppColors.textSecondary), textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  )
                else
                  Column(
                    children: summary.holdings.map((h) {
                      final hProfit = h.unrealizedProfitLoss >= 0;
                      final hColor = hProfit ? AppColors.income : AppColors.expense;

                      return Card(
                        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: ListTile(
                          onTap: () => context.push('${AppRoutes.investments}/holding/${h.id}'),
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primaryLight,
                            child: Text(
                              h.securityTicker.substring(0, h.securityTicker.length > 3 ? 3 : h.securityTicker.length),
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: AppColors.primary),
                            ),
                          ),
                          title: Row(
                            children: [
                              Text(h.securityTicker, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  h.securityName,
                                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            '${h.quantity} יח\' • \$${h.currentPrice.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _formatAmount(h.currentMarketValueILS, usdRate),
                                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
                              ),
                              Text(
                                '${hProfit ? '+' : ''}${_formatProfitAmount(h.unrealizedProfitLossILS, usdRate)} (${h.unrealizedProfitLossPercent.toStringAsFixed(1)}%)',
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: hColor),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                const SizedBox(height: 80),
              ],
            ),
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

  Widget _buildSubHubCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacing.roundedMd,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppSpacing.roundedMd,
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: color.withAlpha(25),
              child: Icon(icon, size: 16, color: color),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary), maxLines: 1),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/financial_info_tooltip.dart';
import '../controllers/net_worth_controller.dart';

/// Screen 18: Total Net Worth Dashboard & Asset Allocation (שווי נקי כולל ופילוח נכסים)
class NetWorthScreen extends ConsumerStatefulWidget {
  const NetWorthScreen({super.key});

  @override
  ConsumerState<NetWorthScreen> createState() => _NetWorthScreenState();
}

class _NetWorthScreenState extends ConsumerState<NetWorthScreen> {
  bool _isLiquidOnly = false;

  @override
  Widget build(BuildContext context) {
    final summaryAsync = ref.watch(netWorthSummaryStreamProvider);
    final snapshotsAsync = ref.watch(netWorthSnapshotsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('שווי נקי כולל'),
        actions: [
          const FinancialInfoTooltip(
            title: 'שווי נקי ופילוח נכסים',
            explanation: 'השווי הנקי מייצג את סך כל העושר הפיננסי שצברת.\n\n• שווי נקי כולל: סך כל הנכסים (עו"ש, תיק השקעות, קרנות השתלמות, פנסיה, נדל"ן ורכב) בניכוי כל ההתחייבויות (משכנתאות, הלוואות וכרטיסי אשראי).\n\n• שווי נזיל בלבד: נכסים שניתן להמיר למזומן מיידי (בנק, מזומן ותיק מניות סחיר) ללא נכסים נעולים (נדל"ן ופנסיה).\n\n• פילוח נכסים (Asset Allocation): אחוז כל אפיק מתוך סך הנכסים.',
            formula: 'שווי נקי = סך נכסים (Assets) - סך התחייבויות (Liabilities)',
            practicalTip: 'מעקב עקבי אחר תמונת המצב החודשית מאפשר לראות צמיחה ריאלית בעושר לאורך שנים.',
          ),
          IconButton(
            icon: const Icon(AppIcons.backup),
            tooltip: 'שמור תמונת מצב חודשית',
            onPressed: () async {
              await ref.read(netWorthControllerProvider).takeSnapshot();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('תמונת מצב נשמרה בהצלחה!'), backgroundColor: AppColors.success),
                );
              }
            },
          ),
        ],
      ),
      body: summaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('שגיאה בחישוב שווי נקי: $err')),
        data: (summary) {
          final displayNetWorth = _isLiquidOnly ? summary.liquidNetWorth : summary.totalNetWorth;

          return ListView(
            padding: AppSpacing.screenPadding,
            children: [
              // 1. View Toggle: Total vs Liquid Only
              SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(
                    value: false,
                    label: Text('שווי נקי כולל', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                    icon: Icon(AppIcons.netWorth, size: 16),
                  ),
                  ButtonSegment(
                    value: true,
                    label: Text('שווי נזיל בלבד', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    icon: Icon(AppIcons.wallet, size: 16),
                  ),
                ],
                selected: {_isLiquidOnly},
                onSelectionChanged: (set) => setState(() => _isLiquidOnly = set.first),
              ),
              const SizedBox(height: AppSpacing.md),

              // 2. Hero Net Worth Card
              Container(
                padding: AppSpacing.cardPadding,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
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
                        Text(
                          _isLiquidOnly ? 'שווי נקי נזיל זמין' : 'סה"כ שווי נקי (מאזן כללי)',
                          style: const TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        const Icon(AppIcons.netWorth, color: Colors.white70, size: 20),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      CurrencyFormatter.formatILS(displayNetWorth),
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                    const Divider(color: Colors.white24, height: AppSpacing.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeroStat(
                          'סך נכסים',
                          CurrencyFormatter.formatILS(_isLiquidOnly ? (summary.totalLiquidAssets + summary.totalInvestments) : summary.totalAssets),
                          AppColors.income,
                        ),
                        _buildHeroStat(
                          'סך התחייבויות',
                          CurrencyFormatter.formatILS(_isLiquidOnly ? summary.totalShortTermLiabilities : summary.totalLiabilities),
                          AppColors.expense,
                        ),
                        _buildHeroStat(
                          'יחס חוב/נכסים',
                          '${summary.debtToAssetRatio.toStringAsFixed(1)}%',
                          Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 3. Asset Allocation Multi-Color Bar
              const Text('פילוח נכסים (Asset Allocation)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              const SizedBox(height: AppSpacing.xs),
              Card(
                child: Padding(
                  padding: AppSpacing.cardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Visual Allocation Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          height: 16,
                          child: Row(
                            children: [
                              if (summary.liquidPercent > 0)
                                Expanded(
                                  flex: (summary.liquidPercent * 10).toInt().clamp(1, 1000),
                                  child: Container(color: AppColors.primary),
                                ),
                              if (summary.investmentsPercent > 0)
                                Expanded(
                                  flex: (summary.investmentsPercent * 10).toInt().clamp(1, 1000),
                                  child: Container(color: AppColors.income),
                                ),
                              if (summary.pensionPercent > 0)
                                Expanded(
                                  flex: (summary.pensionPercent * 10).toInt().clamp(1, 1000),
                                  child: Container(color: AppColors.secondary),
                                ),
                              if (summary.realEstatePercent > 0)
                                Expanded(
                                  flex: (summary.realEstatePercent * 10).toInt().clamp(1, 1000),
                                  child: Container(color: AppColors.primaryDark),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Legends Grid
                      _buildAllocationRow('עו"ש, ארנקים ומזומן', summary.totalLiquidAssets, summary.liquidPercent, AppColors.primary),
                      const Divider(height: AppSpacing.md),
                      _buildAllocationRow('תיק ניירות ערך והשקעות', summary.totalInvestments, summary.investmentsPercent, AppColors.income),
                      const Divider(height: AppSpacing.md),
                      _buildAllocationRow('פנסיה, השתלמות וגמל', summary.totalPension, summary.pensionPercent, AppColors.secondary),
                      const Divider(height: AppSpacing.md),
                      _buildAllocationRow('נדל"ן וכלי רכב', summary.totalRealEstateAndAssets, summary.realEstatePercent, AppColors.primaryDark),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 4. Liabilities Breakdown Card
              const Text('פירוט התחייבויות וחובות', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              const SizedBox(height: AppSpacing.xs),
              Card(
                child: Padding(
                  padding: AppSpacing.cardPadding,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(AppIcons.creditCard, size: 16, color: AppColors.expense),
                              SizedBox(width: 8),
                              Text('כרטיסי אשראי והלוואות קצרות', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          Text(
                            CurrencyFormatter.formatILS(summary.totalShortTermLiabilities),
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.expense),
                          ),
                        ],
                      ),
                      const Divider(height: AppSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(AppIcons.mortgage, size: 16, color: AppColors.expense),
                              SizedBox(width: 8),
                              Text('משכנתאות והלוואות ארוכות', style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          Text(
                            CurrencyFormatter.formatILS(summary.totalLongTermLiabilities),
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.expense),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // 5. Historical Snapshots
              const Text('היסטוריית תמונות מצב', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              const SizedBox(height: AppSpacing.xs),
              snapshotsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('שגיאה: $err')),
                data: (snapshots) {
                  if (snapshots.isEmpty) {
                    return const Card(
                      child: Padding(
                        padding: AppSpacing.cardPadding,
                        child: Center(child: Text('טרם נשמרו תמונות מצב היסטוריות')),
                      ),
                    );
                  }

                  return Column(
                    children: snapshots.map((s) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: AppColors.primaryLight,
                            child: Icon(AppIcons.netWorth, color: AppColors.primary, size: 18),
                          ),
                          title: Text(
                            CurrencyFormatter.formatILS(s.netWorth),
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                          ),
                          subtitle: Text(
                            'נכסים: ${CurrencyFormatter.formatCompactILS(s.totalLiquidAssets + s.totalInvestments + s.totalPension + s.totalRealEstate)} • חובות: ${CurrencyFormatter.formatCompactILS(s.totalLiabilities)}',
                            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                          ),
                          trailing: Text(
                            AppDateFormatter.formatShortDate(s.snapshotDate),
                            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),

              const SizedBox(height: 80),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeroStat(String title, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _buildAllocationRow(String label, double amount, double percent, Color color) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
        Text('${percent.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
        const SizedBox(width: 12),
        Text(CurrencyFormatter.formatILS(amount), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
      ],
    );
  }
}

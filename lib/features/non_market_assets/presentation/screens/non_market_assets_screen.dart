import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../domain/models/asset_model.dart';
import '../../domain/models/liability_model.dart';
import '../controllers/non_market_assets_controller.dart';
import 'add_asset_dialog.dart';
import 'add_liability_dialog.dart';
import 'amortization_schedule_dialog.dart';

/// Screen 17: Non-Market Assets & Liabilities (נכסים לא סחירים, משכנתאות והתחייבויות)
class NonMarketAssetsScreen extends ConsumerStatefulWidget {
  const NonMarketAssetsScreen({super.key});

  @override
  ConsumerState<NonMarketAssetsScreen> createState() => _NonMarketAssetsScreenState();
}

class _NonMarketAssetsScreenState extends ConsumerState<NonMarketAssetsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final summaryAsync = ref.watch(nonMarketSummaryStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('נכסים והתחייבויות'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'נכסים פיזיים והון עצמי'),
            Tab(text: 'התחייבויות ומשכנתאות'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_tabController.index == 0) {
            AddAssetDialog.show(context);
          } else {
            AddLiabilityDialog.show(context);
          }
        },
        icon: const Icon(AppIcons.add),
        label: Text(_tabController.index == 0 ? 'הוסף נכס' : 'הוסף התחייבות'),
      ),
      body: summaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('שגיאה: $err')),
        data: (summary) {
          return Column(
            children: [
              // 1. Hero Equity Overview Card
              Padding(
                padding: AppSpacing.screenPadding,
                child: Container(
                  padding: AppSpacing.cardPadding,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryDark, Color(0xFF1E3A8A)],
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
                          Text('הון עצמי נקי בנכסים (Home Equity)', style: TextStyle(color: Colors.white70, fontSize: 13)),
                          Icon(AppIcons.bank, color: Colors.white70, size: 20),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        CurrencyFormatter.formatILS(summary.totalNetEquityValue),
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                      const Divider(color: Colors.white24, height: AppSpacing.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHeroStat('סך שווי נכסים', CurrencyFormatter.formatILS(summary.totalPhysicalAssetsValue)),
                          _buildHeroStat('סך חובות והלוואות', CurrencyFormatter.formatILS(summary.totalLiabilitiesValue)),
                          _buildHeroStat('החזר חודשי כולל', CurrencyFormatter.formatILS(summary.totalMonthlyLoanPayments)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 2. Tab Views for Assets and Liabilities
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAssetsTab(summary.assets, summary.liabilities),
                    _buildLiabilitiesTab(summary.liabilities),
                  ],
                ),
              ),
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
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _buildAssetsTab(List<AssetModel> assets, List<LiabilityModel> liabilities) {
    if (assets.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(AppIcons.bank, size: 48, color: AppColors.textMuted.withAlpha(100)),
              const SizedBox(height: AppSpacing.sm),
              const Text('טרם הוזנו נכסים פיזיים', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              const Text('הוסף דירה, רכב או נכס אחר למעקב שווי והון עצמי', style: TextStyle(fontSize: 12, color: AppColors.textSecondary), textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: AppSpacing.screenPadding,
      itemCount: assets.length,
      itemBuilder: (context, index) {
        final asset = assets[index];
        final linkedLiabilities = liabilities.where((l) => l.assetId == asset.id).toList();
        final totalDebt = linkedLiabilities.fold(0.0, (sum, l) => sum + l.currentPrincipal);
        final netEquity = asset.estimatedValue - totalDebt;
        final ltv = asset.estimatedValue > 0 ? (totalDebt / asset.estimatedValue) * 100 : 0.0;

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
                          backgroundColor: AppColors.primaryLight,
                          child: Icon(
                            asset.assetType == AssetType.vehicle ? AppIcons.vehicle : AppIcons.realEstate,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(asset.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(asset.assetType.labelHebrew, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary)),
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
                        const Text('שווי מוערך', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                        Text(CurrencyFormatter.formatILS(asset.estimatedValue), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('הון עצמי נקי', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                        Text(
                          CurrencyFormatter.formatILS(netEquity),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.income),
                        ),
                      ],
                    ),
                    if (totalDebt > 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('מימון (LTV)', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                          Text('${ltv.toStringAsFixed(0)}%', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.expense)),
                        ],
                      ),
                  ],
                ),
                if (linkedLiabilities.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'משכנתאות והלוואות מקושרות: ${linkedLiabilities.map((l) => '${l.name} (${CurrencyFormatter.formatILS(l.currentPrincipal)})').join(', ')}',
                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLiabilitiesTab(List<LiabilityModel> liabilities) {
    if (liabilities.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(AppIcons.expense, size: 48, color: AppColors.textMuted.withAlpha(100)),
              const SizedBox(height: AppSpacing.sm),
              const Text('אין התחייבויות או הלוואות', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              const Text('הוסף משכנתה או הלוואה לחישוב לוחות סילוקין שפיצר', style: TextStyle(fontSize: 12, color: AppColors.textSecondary), textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: AppSpacing.screenPadding,
      itemCount: liabilities.length,
      itemBuilder: (context, index) {
        final liab = liabilities[index];

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
                          backgroundColor: AppColors.expenseLight,
                          child: const Icon(AppIcons.expense, size: 16, color: AppColors.expense),
                        ),
                        const SizedBox(width: 8),
                        Text(liab.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.expenseLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(liab.liabilityType.labelHebrew, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.expense)),
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
                        const Text('יתרת קרן', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                        Text(CurrencyFormatter.formatILS(liab.currentPrincipal), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('החזר חודשי', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                        Text(CurrencyFormatter.formatILS(liab.monthlyPayment), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.expense)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('ריבית', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                        Text('${liab.interestRate}%', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        minimumSize: Size.zero,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AmortizationScheduleDialog(liability: liab),
                        );
                      },
                      child: const Text('לוח שפיצר', style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('נותרו ${liab.remainingPayments} חודשים לתשלום', style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
              ],
            ),
          ),
        );
      },
    );
  }
}

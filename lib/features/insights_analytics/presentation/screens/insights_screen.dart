import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/financial_info_tooltip.dart';
import '../controllers/insights_controller.dart';
import '../../domain/models/comparative_analytics_model.dart';

/// Screen 19: Insights, 50/30/20 Rule, Comparative Analytics & Savings Rate (תובנות וניתוח מגמות)
class InsightsScreen extends ConsumerStatefulWidget {
  const InsightsScreen({super.key});

  @override
  ConsumerState<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends ConsumerState<InsightsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DateTime _selectedMonth = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('תובנות וניתוח מגמות'),
        bottom: TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
          tabs: const [
            Tab(text: 'צרכים ומותרות 50/30/20', icon: Icon(AppIcons.budgets, size: 18)),
            Tab(text: 'השוואת תקופות', icon: Icon(AppIcons.sort, size: 18)),
            Tab(text: 'שיעור חיסכון וקצב שריפה', icon: Icon(AppIcons.trendingUp, size: 18)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _build503020Tab(),
          _buildComparativeTab(),
          _buildSavingsRateTab(),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // Tab 1: 50/30/20 Rule & Fixed/Variable
  // ----------------------------------------------------
  Widget _build503020Tab() {
    final spendingAsync = ref.watch(spendingClassificationFutureProvider(_selectedMonth));

    return spendingAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('שגיאה: $err')),
      data: (spending) {
        return ListView(
          padding: AppSpacing.screenPadding,
          children: [
            // Warning Banner if Wants Exceeded
            if (spending.isWantsExceeded)
              Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                padding: AppSpacing.cardPadding,
                decoration: BoxDecoration(
                  color: AppColors.warningLight,
                  borderRadius: AppSpacing.roundedMd,
                  border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(AppIcons.alert, color: AppColors.warning, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('חריגה ביחס מותרות (Wants)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                          Text(
                            'הוצאות המותרות החודש הגיעו ל-${spending.wantsPercent.toStringAsFixed(1)}% מההכנסות (רצוי עד 30% לפי מודל 50/30/20).',
                            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Hero 50/30/20 Card
            Card(
              child: Padding(
                padding: AppSpacing.cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text('מודל 50/30/20 לחודש הנוכחי', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                        Spacer(),
                        FinancialInfoTooltip(
                          title: 'מודל 50/30/20',
                          explanation: 'כלל פיננסי לחלוקת ההכנסה:\n• 50% להוצאות מחיה הכרחיות (דיור, מזון, חשבונות).\n• 30% למותרות, פנאי ואיכות חיים.\n• 20% לחיסכון, השקעות ופירעון חובות.',
                          practicalTip: 'אם סעיף המותרות עובר 30%, מומלץ לבדוק מינויים ומסעדות.',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 16,
                        child: Row(
                          children: [
                            if (spending.needsPercent > 0)
                              Expanded(
                                flex: (spending.needsPercent * 10).toInt().clamp(1, 1000),
                                child: Container(color: AppColors.primary),
                              ),
                            if (spending.wantsPercent > 0)
                              Expanded(
                                flex: (spending.wantsPercent * 10).toInt().clamp(1, 1000),
                                child: Container(color: AppColors.warning),
                              ),
                            if (spending.savingsPercent > 0)
                              Expanded(
                                flex: (spending.savingsPercent * 10).toInt().clamp(1, 1000),
                                child: Container(color: AppColors.income),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    _buildMetricRow('50% צרכים בסיסיים (Needs)', spending.needsAmount, spending.needsPercent, AppColors.primary, 'יעד: עד 50%'),
                    const Divider(height: AppSpacing.md),
                    _buildMetricRow('30% מותרות ופנאי (Wants)', spending.wantsAmount, spending.wantsPercent, AppColors.warning, 'יעד: עד 30%'),
                    const Divider(height: AppSpacing.md),
                    _buildMetricRow('20% חיסכון והשקעות (Savings)', spending.savingsAmount, spending.savingsPercent, AppColors.income, 'יעד: 20%+'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Fixed vs Variable Card
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('הוצאות קבועות מול משתנות', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                FinancialInfoTooltip(
                  title: 'הוצאות קבועות מול משתנות',
                  explanation: 'חלוקת ההוצאות לפי מידת הגמישות והשליטה בהן:\n\n• הוצאות קבועות: התחייבויות שחוזרות בסכום קבוע או קשיח (שכירות, משכנתה, ביטוחים, מנויים, ארנונה). קשה לקצץ בהן בטווח הקצר.\n\n• הוצאות משתנות: הוצאות שוטפות גמישות (מזון, מסעדות, ביגוד, פנאי). בהן טמון פוטנציאל החיסכון המיידי הגדול ביותר.',
                  formula: 'יחס קבועות/משתנות = סך הוצאות קבועות / סך כל ההוצאות',
                  practicalTip: 'צמצום של מנוי חודשי בודד מקטין את ההוצאה הקבועה לשנה שלמה.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Card(
              child: Padding(
                padding: AppSpacing.cardPadding,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Row(
                            children: [
                              Icon(AppIcons.recurring, size: 18, color: AppColors.primary),
                              SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  'הוצאות קבועות (שכ"ד, ביטוחים, מנויים)',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${CurrencyFormatter.formatILS(spending.fixedAmount)} (${spending.fixedExpensePercent.toStringAsFixed(0)}%)',
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                        ),
                      ],
                    ),
                    const Divider(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Row(
                            children: [
                              Icon(AppIcons.shopping, size: 18, color: AppColors.secondary),
                              SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  'הוצאות משתנות (קניות, בילויים, שוטף)',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${CurrencyFormatter.formatILS(spending.variableAmount)} (${spending.variableExpensePercent.toStringAsFixed(0)}%)',
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMetricRow(String title, double amount, double percent, Color color, String target) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
              Text(target, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(CurrencyFormatter.formatILS(amount), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
            Text('${percent.toStringAsFixed(1)}%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
          ],
        ),
      ],
    );
  }

  // ----------------------------------------------------
  // Tab 2: Comparative Analytics & Top Movers
  // ----------------------------------------------------
  Widget _buildComparativeTab() {
    final comparativeAsync = ref.watch(
      comparativeAnalyticsFutureProvider((current: _selectedMonth, previous: DateTime(_selectedMonth.year, _selectedMonth.month - 1, 1))),
    );

    return comparativeAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('שגיאה: $err')),
      data: (comp) {
        final expDelta = comp.expensesDeltaAmount;
        final expPct = comp.expensesDeltaPercent;
        final isExpIncreased = expDelta > 0;

        return ListView(
          padding: AppSpacing.screenPadding,
          children: [
            // Period Comparison Hero
            Card(
              child: Padding(
                padding: AppSpacing.cardPadding,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('השוואה: ${comp.currentPeriodLabel} מול ${comp.previousPeriodLabel}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FinancialInfoTooltip(
                              title: 'השוואת תקופות ומגמות',
                              explanation: 'השוואה בין סך ההוצאות של החודש הנוכחי לעומת החודש הקודם וזיהוי שינויים מהותיים.\n\n• Top Increases: קטגוריות שבהן נרשמה העלייה החדה ביותר בהוצאות.\n• Top Reductions: קטגוריות שבהן הצלחת לחסוך ולצמצם הוצאות.',
                              formula: 'אחוז שינוי = ((הוצאות החודש - הוצאות קודמות) / הוצאות קודמות) * 100',
                              practicalTip: 'שים לב לקטגוריות שצמחו ביותר מ-20% כדי לזהות חריגות תקציב מוקדם.',
                            ),
                            const SizedBox(width: 6),
                            Icon(isExpIncreased ? AppIcons.trendingUp : AppIcons.trendingDown, color: isExpIncreased ? AppColors.expense : AppColors.income, size: 20),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildPeriodStat('הוצאות החודש', comp.currentTotalExpenses, AppColors.textPrimary),
                        _buildPeriodStat('הוצאות חודש קודם', comp.previousTotalExpenses, AppColors.textSecondary),
                        _buildPeriodStat(
                          'שינוי בהוצאות',
                          '${isExpIncreased ? '+' : ''}${CurrencyFormatter.formatILS(expDelta)} (${expPct.toStringAsFixed(1)}%)',
                          isExpIncreased ? AppColors.expense : AppColors.income,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Top Increasing Categories (Spent More)
            const Text('הוצאות שגדלו הכי הרבה (Top Increases)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.expense)),
            const SizedBox(height: AppSpacing.xs),
            if (comp.topIncreasingCategories.isEmpty)
              const Card(
                child: Padding(
                  padding: AppSpacing.cardPadding,
                  child: Center(child: Text('אין קטגוריות עם עלייה בהוצאות')),
                ),
              )
            else
              ...comp.topIncreasingCategories.map((m) => _buildMoverTile(m, true)),

            const SizedBox(height: AppSpacing.lg),

            // Top Decreasing Categories (Saved More)
            const Text('החיסכון הגדול ביותר (Top Reductions)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.income)),
            const SizedBox(height: AppSpacing.xs),
            if (comp.topDecreasingCategories.isEmpty)
              const Card(
                child: Padding(
                  padding: AppSpacing.cardPadding,
                  child: Center(child: Text('אין קטגוריות עם ירידה בהוצאות')),
                ),
              )
            else
              ...comp.topDecreasingCategories.map((m) => _buildMoverTile(m, false)),
          ],
        );
      },
    );
  }

  Widget _buildPeriodStat(String title, dynamic value, Color color) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
        const SizedBox(height: 4),
        Text(
          value is double ? CurrencyFormatter.formatILS(value) : value.toString(),
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: color),
        ),
      ],
    );
  }

  Widget _buildMoverTile(CategoryMover m, bool isIncrease) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isIncrease ? AppColors.expenseLight : AppColors.incomeLight,
          child: Icon(isIncrease ? AppIcons.expense : AppIcons.income, color: isIncrease ? AppColors.expense : AppColors.income, size: 18),
        ),
        title: Text(m.categoryName, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
        subtitle: Text(
          'החודש: ${CurrencyFormatter.formatILS(m.currentAmount)} • קודם: ${CurrencyFormatter.formatILS(m.previousAmount)}',
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
        ),
        trailing: Text(
          '${isIncrease ? '+' : ''}${CurrencyFormatter.formatILS(m.deltaAmount)}\n(${m.deltaPercent.toStringAsFixed(0)}%)',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 12,
            color: isIncrease ? AppColors.expense : AppColors.income,
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------
  // Tab 3: Savings Rate & Cash Burn Rate
  // ----------------------------------------------------
  Widget _buildSavingsRateTab() {
    final savingsAsync = ref.watch(savingsRateMetricsFutureProvider(_selectedMonth));

    return savingsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('שגיאה: $err')),
      data: (savings) {
        return ListView(
          padding: AppSpacing.screenPadding,
          children: [
            // Savings Rate Hero Card
            Container(
              padding: AppSpacing.cardPadding,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF065F46), Color(0xFF047857)],
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
                      Text('שיעור חיסכון חודשי', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FinancialInfoTooltip(
                            title: 'שיעור חיסכון וקצב שריפה (Burn Rate)',
                            explanation: 'מדדי המפתח לעצמאות וחוסן פיננסי:\n\n• שיעור חיסכון (Savings Rate): אחוז ההכנסה נטו שנשאר לאחר כל ההוצאות ומופנה לחיסכון או השקעות.\n\n• קצב שריפה חודשי (Burn Rate): ממוצע ההוצאות החודשיות שהבית צורך.\n\n• כרית ביטחון (Runway): מספר החודשים שתוכל להתקיים מהנכסים הנזילים הקיימים ללא כל הכנסה נוספת.',
                            formula: 'שיעור חיסכון = ((סך הכנסות - סך הוצאות) / סך הכנסות) * 100\nRunway = סך נכסים נזילים / ממוצע הוצאות חודשי',
                            practicalTip: 'מומלץ להחזיק כרית ביטחון (Runway) של 3 עד 6 חודשי הוצאות בחשבון נזיל.',
                          ),
                          SizedBox(width: 6),
                          Icon(AppIcons.savings, color: Colors.white70, size: 20),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '${savings.currentMonthSavingsRate.toStringAsFixed(1)}%',
                    style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'חיסכון נקי החודש: ${CurrencyFormatter.formatILS(savings.currentMonthNetSavings)}',
                    style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const Divider(color: Colors.white24, height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSavingsHeroStat('יעד אישי', '${savings.targetSavingsRatePercent.toStringAsFixed(0)}%'),
                      _buildSavingsHeroStat('עמידה ביעד', savings.isTargetAchieved ? 'הושג בהצלחה' : 'מתחת ליעד'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Moving Averages Card
            const Text('ממוצעים נעים (Moving Averages)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            const SizedBox(height: AppSpacing.xs),
            Card(
              child: Padding(
                padding: AppSpacing.cardPadding,
                child: Column(
                  children: [
                    _buildMovingAvgRow('ממוצע נע 3 חודשים', savings.threeMonthMovingAverage),
                    const Divider(height: AppSpacing.md),
                    _buildMovingAvgRow('ממוצע נע 6 חודשים', savings.sixMonthMovingAverage),
                    const Divider(height: AppSpacing.md),
                    _buildMovingAvgRow('ממוצע נע 12 חודשים', savings.twelveMonthMovingAverage),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Monthly Burn Rate Card
            const Text('קצב צריכת מזומן חודשי (Burn Rate)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            const SizedBox(height: AppSpacing.xs),
            Card(
              child: Padding(
                padding: AppSpacing.cardPadding,
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppColors.expenseLight,
                      child: Icon(AppIcons.expense, color: AppColors.expense, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('קצב שריפה חודשי ממוצע', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                          Text(
                            'הוצאה חודשית מנוקה מחריגות חד-פעמיות: ${CurrencyFormatter.formatILS(savings.monthlyBurnRate)}',
                            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSavingsHeroStat(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _buildMovingAvgRow(String title, double rate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
        Text(
          '${rate.toStringAsFixed(1)}%',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 14,
            color: rate >= 20.0 ? AppColors.income : (rate >= 0 ? AppColors.warning : AppColors.expense),
          ),
        ),
      ],
    );
  }
}

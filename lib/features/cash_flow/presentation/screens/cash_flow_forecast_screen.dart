import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/financial_info_tooltip.dart';
import '../controllers/cash_flow_controller.dart';
import '../../domain/models/cash_flow_model.dart';

/// Screen 11: Cash Flow Forecast (30/60/90 Days) & What-If Simulation
class CashFlowForecastScreen extends ConsumerStatefulWidget {
  const CashFlowForecastScreen({super.key});

  @override
  ConsumerState<CashFlowForecastScreen> createState() => _CashFlowForecastScreenState();
}

class _CashFlowForecastScreenState extends ConsumerState<CashFlowForecastScreen> {
  void _showAddWhatIfDialog() {
    final nameCtrl = TextEditingController();
    final amountCtrl = TextEditingController();
    DateTime pickedDate = DateTime.now().add(const Duration(days: 7));
    bool isIncome = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('הוספת תרחיש "מה אם" (סימולציה)'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'שם התרחיש / תיאור',
                    hintText: 'לדוגמה: בונוס שנתי, טיפול לרכב...',
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextField(
                  controller: amountCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'סכום משוער (₪)',
                    hintText: '0.00 ₪',
                    prefixIcon: Icon(AppIcons.cash),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('סוג תנועה:'),
                    SegmentedButton<bool>(
                      segments: const [
                        ButtonSegment(value: false, label: Text('הוצאה')),
                        ButtonSegment(value: true, label: Text('הכנסה')),
                      ],
                      selected: {isIncome},
                      onSelectionChanged: (set) => setDialogState(() => isIncome = set.first),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                OutlinedButton.icon(
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: ctx,
                      initialDate: pickedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 120)),
                    );
                    if (d != null) {
                      setDialogState(() => pickedDate = d);
                    }
                  },
                  icon: const Icon(AppIcons.calendar, size: 16),
                  label: Text('תאריך משוער: ${AppDateFormatter.formatShortDate(pickedDate)}'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('ביטול')),
            ElevatedButton(
              onPressed: () {
                final name = nameCtrl.text.trim();
                final amount = double.tryParse(amountCtrl.text) ?? 0.0;
                if (name.isNotEmpty && amount > 0) {
                  final scenario = WhatIfScenarioModel(
                    id: 'whatif_${DateTime.now().millisecondsSinceEpoch}',
                    name: name,
                    amount: amount,
                    date: pickedDate,
                    isIncome: isIncome,
                    isEnabled: true,
                  );
                  ref.read(whatIfScenariosProvider.notifier).addScenario(scenario);
                  Navigator.pop(ctx);
                }
              },
              child: const Text('הוסף לסימולציה'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final horizonDays = ref.watch(cashFlowDaysHorizonProvider);
    final forecastAsync = ref.watch(cashFlowForecastProvider);
    final scenarios = ref.watch(whatIfScenariosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('תחזית תזרים מזומנים'),
        actions: [
          const FinancialInfoTooltip(
            title: 'תחזית תזרים מזומנים וסימולציות',
            explanation: 'תחזית התזרים חוזה את היתרה הצפויה בחשבונותיך הנזילים ל-30, 60 או 90 יום קדימה.\n\n• יתרת פתיחה: סך היתרות הנוכחיות בחשבונות עו"ש, מזומן וארנקים דיגיטליים.\n\n• כניסות צפויות (+): משכורות והכנסות מחזוריות הרשומות במערכת במועד קבלתן.\n\n• יציאות צפויות (-): הוראות קבע ומנויים קבועים, יחד עם חיוב כרטיסי אשראי צפוי ביום החיוב החודשי.\n\n• נקודת שפל (Lowest Balance): היתרה הנמוכה ביותר שאליה החשבון עלול להגיע בתקופה.\n\n• ימי גירעון (Deficit Days): מספר הימים שבהם החשבון צפוי להיות במינוס (מתחת ל-0 ₪).\n\n• סימולציית "מה-אם": בדיקת השפעה של הוצאה גדולה או הכנסה עתידית לפני ביצועה בפועל.',
            formula: 'יתרה סוגרת יומית = יתרת פתיחה + הכנסות היום - הוצאות והוראות קבע - חיובי אשראי +/- תרחישים',
            practicalTip: 'אם מזוהה סיכון לגירעון (חודש אדום), מומלץ לדחות הוצאות משתנות או להעביר כספים מחסכונות נזילים.',
          ),
          IconButton(
            icon: const Icon(Icons.auto_awesome_rounded),
            tooltip: 'הוסף תרחיש סימולציה',
            onPressed: _showAddWhatIfDialog,
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          // 1. Horizon Segmented Control
          Center(
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 30, label: Text('30 יום')),
                ButtonSegment(value: 60, label: Text('60 יום')),
                ButtonSegment(value: 90, label: Text('90 יום')),
              ],
              selected: {horizonDays},
              onSelectionChanged: (set) {
                ref.read(cashFlowDaysHorizonProvider.notifier).state = set.first;
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // 2. Forecast Summary Data
          forecastAsync.when(
            data: (summary) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Overview Card
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: summary.hasDeficitRisk
                            ? [const Color(0xFFEF4444), const Color(0xFFB91C1C)]
                            : [const Color(0xFF0D9488), const Color(0xFF0F766E)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: (summary.hasDeficitRisk ? const Color(0xFFEF4444) : const Color(0xFF0D9488)).withAlpha(60),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'יתרה צפויה בסוף התקופה',
                              style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(50),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                summary.hasDeficitRisk ? 'סיכון למינוס' : 'תזרים חיובי',
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          CurrencyFormatter.formatILS(summary.endingBalance),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        const Divider(color: Colors.white24, height: 1),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildHeroMetric('יתרת פתיחה', CurrencyFormatter.formatILS(summary.startingBalance)),
                            _buildHeroMetric('נקודת שפל בתזרים', CurrencyFormatter.formatILS(summary.lowestBalance)),
                            _buildHeroMetric('בתאריך', AppDateFormatter.formatShortDate(summary.lowestBalanceDate)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Deficit Warning Banner
                  if (summary.hasDeficitRisk) ...[
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.expenseLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.expense.withAlpha(60)),
                      ),
                      child: Row(
                        children: [
                          const Icon(AppIcons.alert, color: AppColors.expense, size: 22),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              'זוהו ${summary.deficitDaysCount} ימים שבהם יתרת העו"ש צפויה לרדת למינוס (נקודת שפל: ${CurrencyFormatter.formatILS(summary.lowestBalance)}).',
                              style: const TextStyle(color: AppColors.expenseDark, fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],

                  // What-If Scenarios Section
                  if (scenarios.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'תרחישי סימולציה ("מה אם")',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                        TextButton.icon(
                          onPressed: _showAddWhatIfDialog,
                          icon: const Icon(AppIcons.add, size: 16),
                          label: const Text('תרחיש נוסף'),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Column(
                      children: scenarios.map((s) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                          child: ListTile(
                            dense: true,
                            leading: Icon(
                              s.isIncome ? AppIcons.income : AppIcons.expense,
                              color: s.isIncome ? AppColors.income : AppColors.expense,
                            ),
                            title: Text(s.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: Text('${AppDateFormatter.formatShortDate(s.date)} • ${CurrencyFormatter.formatILS(s.amount)}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Switch(
                                  value: s.isEnabled,
                                  onChanged: (_) {
                                    ref.read(whatIfScenariosProvider.notifier).toggleScenario(s.id);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(AppIcons.delete, size: 18, color: AppColors.textMuted),
                                  onPressed: () {
                                    ref.read(whatIfScenariosProvider.notifier).removeScenario(s.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],

                  // Timeline Movement Points
                  const Text(
                    'לוח תנועות ואירועי תזרים יומיים',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  Column(
                    children: summary.points.where((p) => p.eventDescriptions.isNotEmpty).map((p) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppDateFormatter.formatShortDate(p.date),
                                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                                  ),
                                  Text(
                                    'יתרה בסוף יום: ${CurrencyFormatter.formatILS(p.closingBalance)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13,
                                      color: p.isDeficitRisk ? AppColors.expense : AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              ...p.eventDescriptions.map((ev) => Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.circle, size: 6, color: AppColors.primary),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            ev,
                                            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('שגיאה בחישוב תזרים: $err')),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 11)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

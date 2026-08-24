import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/financial_info_tooltip.dart';
import '../controllers/salary_tax_settings_controller.dart';

class SalaryTaxSettingsScreen extends ConsumerStatefulWidget {
  const SalaryTaxSettingsScreen({super.key});

  @override
  ConsumerState<SalaryTaxSettingsScreen> createState() => _SalaryTaxSettingsScreenState();
}

class _SalaryTaxSettingsScreenState extends ConsumerState<SalaryTaxSettingsScreen> {
  final _salaryController = TextEditingController();
  final _taxRateController = TextEditingController();
  bool _isInitialized = false;

  @override
  void dispose() {
    _salaryController.dispose();
    _taxRateController.dispose();
    super.dispose();
  }

  void _save() async {
    final salary = double.tryParse(_salaryController.text.trim()) ?? 18000.0;
    final taxRate = double.tryParse(_taxRateController.text.trim()) ?? 20.0;

    await ref.read(salaryTaxSettingsProvider.notifier).updateSettings(
          baseSalary: salary,
          defaultTaxRate: taxRate,
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('הגדרות שכר ומיסים נשמרו בהצלחה!'),
          backgroundColor: AppColors.income,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(salaryTaxSettingsProvider);

    if (!_isInitialized) {
      _salaryController.text = settings.baseSalary.toStringAsFixed(0);
      _taxRateController.text = settings.defaultTaxRate.toStringAsFixed(0);
      _isInitialized = true;
    }

    final currentSalary = double.tryParse(_salaryController.text) ?? settings.baseSalary;
    final currentTaxRate = double.tryParse(_taxRateController.text) ?? settings.defaultTaxRate;
    final calc = settings.copyWith(defaultTaxRate: currentTaxRate).calculateFromGross(currentSalary);

    return Scaffold(
      appBar: AppBar(
        title: const Text('הגדרות שכר ומיסוי'),
        actions: const [
          FinancialInfoTooltip(
            title: 'הגדרות שכר וחישובי מס הכנסה',
            explanation: 'הגדרות אלו משמשות כבסיס גלובלי לתכנון התקציב החודשי ולחישובים אוטומטיים של מס הכנסה:\n\n• משכורת בסיס חודשית: שכר העבודה הקבוע שלך, ממנו נגזרת ההכנסה החודשית לתכנון התקציב.\n\n• שיעור מס הכנסה: אחוז המס המשוקלל/ממוצע המנוכה מהכנסות ברוטו (כולל מס הכנסה וביטוח לאומי/בריאות).\n\n• בעת הזנת הכנסה חדשה כ"ברוטו", המערכת תחשב אוטומטית את המס ואת הנטו שיופקד בחשבון לפי אחוז זה.',
          ),
        ],
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          // Info banner
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.primary.withAlpha(40)),
            ),
            child: Row(
              children: [
                const Icon(AppIcons.salary, color: AppColors.primary, size: 24),
                const SizedBox(width: AppSpacing.md),
                const Expanded(
                  child: Text(
                    'הגדרות אלו מסנכרנות את תכנון התקציב החודשי וחישובי המיסוי האוטומטיים בכל רחבי האפליקציה.',
                    style: TextStyle(fontSize: 12, color: AppColors.primaryDark, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Base Salary Card
          Card(
            child: Padding(
              padding: AppSpacing.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('משכורת בסיס חודשית', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  const SizedBox(height: 4),
                  const Text('משכורת העבודה הקבועה המשמשת לתכנון תקציב חודשי', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    controller: _salaryController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: 'משכורת קבועה (₪)',
                      prefixText: '₪ ',
                      prefixIcon: Icon(AppIcons.salary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Tax Rate Card
          Card(
            child: Padding(
              padding: AppSpacing.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('שיעור מס הכנסה וניכויים (%)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  const SizedBox(height: 4),
                  const Text('אחוז המס הממוצע המנוכה אוטומטית מהכנסות המוגדרות כברוטו', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    controller: _taxRateController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: 'שיעור מס (%)',
                      suffixText: '%',
                      prefixIcon: Icon(Icons.percent_rounded),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Real-time Preview Calculation
          Card(
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: AppColors.border),
            ),
            child: Padding(
              padding: AppSpacing.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.calculate_outlined, color: AppColors.primary, size: 20),
                      SizedBox(width: 8),
                      Text('סימולציית חישוב שכר לדוגמה', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('שכר ברוטו:'),
                      Text(CurrencyFormatter.formatILS(calc.gross), style: const TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('מס וניכויים (${currentTaxRate.toStringAsFixed(0)}%):'),
                      Text('-${CurrencyFormatter.formatILS(calc.tax)}', style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.error)),
                    ],
                  ),
                  const Divider(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('שכר פנוי נטו:', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                      Text(CurrencyFormatter.formatILS(calc.net), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.income)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Save Button
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _save,
              icon: const Icon(AppIcons.check),
              label: const Text('שמור הגדרות שכר ומיסוי', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }
}

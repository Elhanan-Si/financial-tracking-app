import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../data/services/amortization_calculator.dart';
import '../../domain/models/liability_model.dart';
import '../controllers/non_market_assets_controller.dart';

class AddLiabilityDialog extends ConsumerStatefulWidget {
  const AddLiabilityDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (context) => const AddLiabilityDialog(),
    );
  }

  @override
  ConsumerState<AddLiabilityDialog> createState() => _AddLiabilityDialogState();
}

class _AddLiabilityDialogState extends ConsumerState<AddLiabilityDialog> {
  final _nameController = TextEditingController();
  final _initialPrincipalController = TextEditingController();
  final _currentPrincipalController = TextEditingController();
  final _interestRateController = TextEditingController(text: '4.5');
  final _monthlyPaymentController = TextEditingController();
  final _monthsController = TextEditingController(text: '120');

  LiabilityType _type = LiabilityType.mortgage;
  String? _selectedAssetId;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _initialPrincipalController.dispose();
    _currentPrincipalController.dispose();
    _interestRateController.dispose();
    _monthlyPaymentController.dispose();
    _monthsController.dispose();
    super.dispose();
  }

  void _calculateSpitzerPayment() {
    final principal = double.tryParse(_currentPrincipalController.text.trim()) ??
        double.tryParse(_initialPrincipalController.text.trim()) ??
        0.0;
    final rate = double.tryParse(_interestRateController.text.trim()) ?? 0.0;
    final months = int.tryParse(_monthsController.text.trim()) ?? 0;

    if (principal > 0 && months > 0) {
      final monthly = AmortizationCalculator.calculateSpitzerMonthlyPayment(
        principal: principal,
        annualInterestRatePercent: rate,
        totalMonths: months,
      );
      setState(() {
        _monthlyPaymentController.text = monthly.toStringAsFixed(0);
      });
    }
  }

  void _submit() async {
    final name = _nameController.text.trim();
    final initPrincipal = double.tryParse(_initialPrincipalController.text.trim()) ?? 0.0;
    final curPrincipal = double.tryParse(_currentPrincipalController.text.trim()) ?? initPrincipal;
    final rate = double.tryParse(_interestRateController.text.trim()) ?? 0.0;
    final monthly = double.tryParse(_monthlyPaymentController.text.trim()) ?? 0.0;
    final months = int.tryParse(_monthsController.text.trim()) ?? 12;

    if (name.isEmpty || initPrincipal <= 0 || monthly <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('נא למלא שם, יתרת קרן והחזר חודשי')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final liability = LiabilityModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        assetId: _selectedAssetId,
        name: name,
        liabilityType: _type,
        initialPrincipal: initPrincipal,
        currentPrincipal: curPrincipal,
        interestRate: rate,
        monthlyPayment: monthly,
        remainingPayments: months,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: months * 30)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await ref.read(nonMarketAssetsControllerProvider).createLiability(liability);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$name נוספה בהצלחה!'), backgroundColor: AppColors.income),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('שגיאה: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final assetsAsync = ref.watch(assetsStreamProvider);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
        top: AppSpacing.lg,
        left: AppSpacing.lg,
        right: AppSpacing.lg,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.expenseLight,
                  child: Icon(AppIcons.expense, color: AppColors.expense),
                ),
                const SizedBox(width: AppSpacing.md),
                const Expanded(
                  child: Text(
                    'הוספת התחייבות / משכנתה',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                ),
                IconButton(icon: const Icon(AppIcons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<LiabilityType>(
              value: _type,
              isDense: true,
              style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'סוג התחייבות *',
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              items: LiabilityType.values.map((t) {
                return DropdownMenuItem(value: t, child: Text(t.labelHebrew, style: const TextStyle(fontSize: 13)));
              }).toList(),
              onChanged: (val) => setState(() => _type = val!),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _nameController,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                labelText: 'כינוי ההתחייבות *',
                hintText: 'משכנתה פריים / הלוואת רכב...',
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            assetsAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (assets) {
                if (assets.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: DropdownButtonFormField<String?>(
                    value: _selectedAssetId,
                    isDense: true,
                    style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                    decoration: const InputDecoration(
                      labelText: 'שיוך לנכס נדל"ן/רכב (לחישוב הון עצמי)',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('ללא שיוך לנכס', style: TextStyle(fontSize: 13))),
                      ...assets.map((a) => DropdownMenuItem(value: a.id, child: Text('שייך ל: ${a.name}', style: const TextStyle(fontSize: 13)))),
                    ],
                    onChanged: (val) => setState(() => _selectedAssetId = val),
                  ),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _initialPrincipalController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    decoration: const InputDecoration(
                      labelText: 'קרן מקורית (₪) *',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: _currentPrincipalController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    decoration: const InputDecoration(
                      labelText: 'יתרת קרן נוכחית (₪) *',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _interestRateController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(fontSize: 13),
                    decoration: const InputDecoration(
                      labelText: 'ריבית שנתית (%)',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: _monthsController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 13),
                    decoration: const InputDecoration(
                      labelText: 'חודשים שנותרו',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _monthlyPaymentController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    decoration: const InputDecoration(
                      labelText: 'החזר חודשי (₪) *',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                OutlinedButton(
                  onPressed: _calculateSpitzerPayment,
                  child: const Text('חשב שפיצר', style: TextStyle(fontSize: 11)),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('שמור התחייבות', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

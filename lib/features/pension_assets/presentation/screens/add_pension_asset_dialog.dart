import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/models/pension_asset_model.dart';
import '../controllers/pension_controller.dart';

class AddPensionAssetDialog extends ConsumerStatefulWidget {
  const AddPensionAssetDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (context) => const AddPensionAssetDialog(),
    );
  }

  @override
  ConsumerState<AddPensionAssetDialog> createState() => _AddPensionAssetDialogState();
}

class _AddPensionAssetDialogState extends ConsumerState<AddPensionAssetDialog> {
  final _nameController = TextEditingController();
  final _providerController = TextEditingController();
  final _trackController = TextEditingController();
  final _policyController = TextEditingController();
  final _balanceController = TextEditingController();
  final _employeeDepositController = TextEditingController(text: '0');
  final _employerDepositController = TextEditingController(text: '0');

  PensionAssetType _type = PensionAssetType.pension;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _providerController.dispose();
    _trackController.dispose();
    _policyController.dispose();
    _balanceController.dispose();
    _employeeDepositController.dispose();
    _employerDepositController.dispose();
    super.dispose();
  }

  void _submit() async {
    final name = _nameController.text.trim();
    final provider = _providerController.text.trim();
    final balance = double.tryParse(_balanceController.text.trim());
    final employeeDeposit = double.tryParse(_employeeDepositController.text.trim()) ?? 0.0;
    final employerDeposit = double.tryParse(_employerDepositController.text.trim()) ?? 0.0;

    if (name.isEmpty || provider.isEmpty || balance == null || balance < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('אנא מלא שם, חברה מנהלת ויתרה עדכנית')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(pensionControllerProvider).createAsset(
            PensionAssetModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: name,
              type: _type,
              providerName: provider,
              currentBalance: balance,
              trackName: _trackController.text.trim().isEmpty ? null : _trackController.text.trim(),
              policyNumber: _policyController.text.trim().isEmpty ? null : _policyController.text.trim(),
              monthlyDepositEmployee: employeeDeposit,
              monthlyDepositEmployer: employerDeposit,
              lastUpdatedDate: DateTime.now(),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$name נוסף בהצלחה!'), backgroundColor: AppColors.income),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('שגיאה בשמירה: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  backgroundColor: AppColors.secondaryLight,
                  child: Icon(AppIcons.savings, color: AppColors.secondary),
                ),
                const SizedBox(width: AppSpacing.md),
                const Expanded(
                  child: Text(
                    'הוספת מוצר פנסיוני / חיסכון',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                ),
                IconButton(icon: const Icon(AppIcons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<PensionAssetType>(
              value: _type,
              isDense: true,
              style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'סוג המוצר הפנסיוני',
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              items: PensionAssetType.values.map((t) {
                return DropdownMenuItem(value: t, child: Text(t.labelHebrew, style: const TextStyle(fontSize: 13)));
              }).toList(),
              onChanged: (val) => setState(() => _type = val!),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _nameController,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                labelText: 'כינוי הקרן / קופה *',
                hintText: 'לדוגמה: קרן השתלמות הראל מחקה S&P 500',
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _providerController,
                    style: const TextStyle(fontSize: 13),
                    decoration: const InputDecoration(
                      labelText: 'חברה מנהלת *',
                      hintText: 'הראל, מנורה, מיטב, אלטשולר',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: _balanceController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    decoration: const InputDecoration(
                      labelText: 'יתרה עדכנית (₪) *',
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
                    controller: _trackController,
                    style: const TextStyle(fontSize: 13),
                    decoration: const InputDecoration(
                      labelText: 'מסלול השקעה',
                      hintText: 'מנייתי, אג"ח, מחקה מדד',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: _policyController,
                    style: const TextStyle(fontSize: 13),
                    decoration: const InputDecoration(
                      labelText: 'מספר חשבון / פוליסה',
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
                    controller: _employeeDepositController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(fontSize: 13),
                    decoration: const InputDecoration(
                      labelText: 'הפקדת עובד חודשית (₪)',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: _employerDepositController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(fontSize: 13),
                    decoration: const InputDecoration(
                      labelText: 'הפקדת מעסיק חודשית (₪)',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
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
                    : const Text('שמור מוצר פנסיוני', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

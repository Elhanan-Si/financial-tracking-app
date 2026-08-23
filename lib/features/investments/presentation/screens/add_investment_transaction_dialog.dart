import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/models/security_model.dart';
import '../controllers/investments_controller.dart';

class AddInvestmentTransactionDialog extends ConsumerStatefulWidget {
  const AddInvestmentTransactionDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (context) => const AddInvestmentTransactionDialog(),
    );
  }

  @override
  ConsumerState<AddInvestmentTransactionDialog> createState() => _AddInvestmentTransactionDialogState();
}

class _AddInvestmentTransactionDialogState extends ConsumerState<AddInvestmentTransactionDialog> {
  final _tickerController = TextEditingController();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _feeController = TextEditingController(text: '0');

  SecurityType _securityType = SecurityType.stock;
  String _currency = 'USD';
  final DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  void dispose() {
    _tickerController.dispose();
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _feeController.dispose();
    super.dispose();
  }

  void _submit() async {
    final ticker = _tickerController.text.trim().toUpperCase();
    final name = _nameController.text.trim().isEmpty ? ticker : _nameController.text.trim();
    final quantity = double.tryParse(_quantityController.text.trim());
    final price = double.tryParse(_priceController.text.trim());
    final fee = double.tryParse(_feeController.text.trim()) ?? 0.0;

    if (ticker.isEmpty || quantity == null || quantity <= 0 || price == null || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('אנא הזן סימול טיקר, כמות ומחיר חיוביים תקינים')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(investmentsControllerProvider).recordBuy(
            ticker: ticker,
            name: name,
            type: _securityType,
            quantity: quantity,
            pricePerUnit: price,
            fee: fee,
            date: _selectedDate,
            currency: _currency,
          );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('עסקת קנייה עבור $ticker נרשמה בהצלחה!'), backgroundColor: AppColors.income),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('שגיאה בשמירת עסקה: $e'), backgroundColor: AppColors.error),
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
                  backgroundColor: AppColors.primaryLight,
                  child: Icon(AppIcons.stock, color: AppColors.primary),
                ),
                const SizedBox(width: AppSpacing.md),
                const Expanded(
                  child: Text(
                    'הוספת עסקת קניית נייר ערך',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                ),
                IconButton(icon: const Icon(AppIcons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tickerController,
                    textCapitalization: TextCapitalization.characters,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    decoration: const InputDecoration(
                      labelText: 'סימול טיקר *',
                      hintText: 'AAPL, SPY, MSFT',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: DropdownButtonFormField<SecurityType>(
                    value: _securityType,
                    isDense: true,
                    style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                    decoration: const InputDecoration(
                      labelText: 'סוג נייר',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                    items: SecurityType.values.where((t) => t != SecurityType.benchmark).map((t) {
                      return DropdownMenuItem(value: t, child: Text(t.labelHebrew, style: const TextStyle(fontSize: 13)));
                    }).toList(),
                    onChanged: (val) => setState(() => _securityType = val ?? SecurityType.stock),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _nameController,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                labelText: 'שם החברה / קרן (אופציונלי)',
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    decoration: const InputDecoration(
                      labelText: 'כמות יחידות *',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: _priceController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    decoration: const InputDecoration(
                      labelText: 'מחיר ליחידה *',
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
                  child: DropdownButtonFormField<String>(
                    value: _currency,
                    isDense: true,
                    style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                    decoration: const InputDecoration(
                      labelText: 'מטבע',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'USD', child: Text('דולר ארה"ב (USD)', style: TextStyle(fontSize: 13))),
                      DropdownMenuItem(value: 'ILS', child: Text('שקל ישראלי (ILS)', style: TextStyle(fontSize: 13))),
                      DropdownMenuItem(value: 'EUR', child: Text('אירו (EUR)', style: TextStyle(fontSize: 13))),
                    ],
                    onChanged: (val) => setState(() => _currency = val ?? 'USD'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: _feeController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(fontSize: 13),
                    decoration: const InputDecoration(
                      labelText: 'עמלת קנייה',
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
                    : const Text('שמור עסקת קנייה', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

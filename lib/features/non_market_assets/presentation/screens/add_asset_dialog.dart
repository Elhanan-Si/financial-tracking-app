import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/models/asset_model.dart';
import '../controllers/non_market_assets_controller.dart';

class AddAssetDialog extends ConsumerStatefulWidget {
  const AddAssetDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (context) => const AddAssetDialog(),
    );
  }

  @override
  ConsumerState<AddAssetDialog> createState() => _AddAssetDialogState();
}

class _AddAssetDialogState extends ConsumerState<AddAssetDialog> {
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  final _noteController = TextEditingController();

  AssetType _type = AssetType.realEstate;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submit() async {
    final name = _nameController.text.trim();
    final value = double.tryParse(_valueController.text.trim());

    if (name.isEmpty || value == null || value <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('אנא הזן שם נכס ושווי מוערך תקין')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(nonMarketAssetsControllerProvider).createAsset(
            AssetModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: name,
              assetType: _type,
              estimatedValue: value,
              note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
              lastValuationDate: DateTime.now(),
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
                  backgroundColor: AppColors.primaryLight,
                  child: Icon(AppIcons.bank, color: AppColors.primary),
                ),
                const SizedBox(width: AppSpacing.md),
                const Expanded(
                  child: Text(
                    'הוספת נכס פיזי (לא סחיר)',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                  ),
                ),
                IconButton(icon: const Icon(AppIcons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<AssetType>(
              value: _type,
              isDense: true,
              style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'סוג הנכס',
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              items: AssetType.values.map((t) {
                return DropdownMenuItem(value: t, child: Text(t.labelHebrew, style: const TextStyle(fontSize: 13)));
              }).toList(),
              onChanged: (val) => setState(() => _type = val!),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _nameController,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                labelText: 'שם הנכס / כינוי *',
                hintText: 'דירה בתל אביב, טויוטה קורולה 2022',
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _valueController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              decoration: const InputDecoration(
                labelText: 'שווי שוק מוערך (₪) *',
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _noteController,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                labelText: 'הערות (אופציונלי)',
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('שמור נכס', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

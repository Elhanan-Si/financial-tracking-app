import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../categories_tags/presentation/widgets/icon_color_picker.dart';
import '../../domain/models/account_model.dart';

/// Modal Bottom Sheet to create or edit a payment account
class AccountEditDialog extends StatefulWidget {
  final AccountModel? existingAccount;
  final List<AccountModel> availableBankAccounts;
  final Future<void> Function(AccountModel account) onSave;

  const AccountEditDialog({
    super.key,
    this.existingAccount,
    required this.availableBankAccounts,
    required this.onSave,
  });

  static Future<void> show({
    required BuildContext context,
    AccountModel? existingAccount,
    required List<AccountModel> availableBankAccounts,
    required Future<void> Function(AccountModel account) onSave,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (context) => AccountEditDialog(
        existingAccount: existingAccount,
        availableBankAccounts: availableBankAccounts,
        onSave: onSave,
      ),
    );
  }

  @override
  State<AccountEditDialog> createState() => _AccountEditDialogState();
}

class _AccountEditDialogState extends State<AccountEditDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _initialBalanceController;
  late AccountType _type;
  late String? _linkedAccountId;
  late int? _billingDayOfMonth;
  late int _colorValue;
  late String _iconName;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final acc = widget.existingAccount;
    _nameController = TextEditingController(text: acc?.name ?? '');
    _initialBalanceController = TextEditingController(text: acc != null ? acc.initialBalance.toString() : '0.0');
    _type = acc?.type ?? AccountType.bank;
    _linkedAccountId = acc?.linkedAccountId;
    _billingDayOfMonth = acc?.billingDayOfMonth ?? 10;
    _colorValue = acc?.colorValue ?? 0xFF3B82F6;
    _iconName = acc?.iconName ?? _type.defaultIcon.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _initialBalanceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final initialBal = double.tryParse(_initialBalanceController.text.trim()) ?? 0.0;

    final account = AccountModel(
      id: widget.existingAccount?.id ?? '',
      name: _nameController.text.trim(),
      type: _type,
      currency: 'ILS',
      initialBalance: initialBal,
      currentBalance: widget.existingAccount?.currentBalance ?? initialBal,
      linkedAccountId: _type == AccountType.creditCard ? _linkedAccountId : null,
      billingDayOfMonth: _type == AccountType.creditCard ? _billingDayOfMonth : null,
      colorValue: _colorValue,
      iconName: _iconName,
      isArchived: widget.existingAccount?.isArchived ?? false,
      createdAt: widget.existingAccount?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      await widget.onSave(account);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('שגיאה בשמירת חשבון: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.existingAccount == null;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
        top: AppSpacing.lg,
        left: AppSpacing.lg,
        right: AppSpacing.lg,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(_colorValue).withValues(alpha: 0.15),
                    child: Icon(AppIcons.fromString(_iconName, fallback: _type.defaultIcon), color: Color(_colorValue)),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      isNew ? 'הוספת אמצעי תשלום / חשבון' : 'עריכת חשבון',
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                    ),
                  ),
                  IconButton(icon: const Icon(AppIcons.close), onPressed: () => Navigator.pop(context)),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Account Type Selector
              DropdownButtonFormField<AccountType>(
                value: _type,
                isDense: true,
                style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                decoration: const InputDecoration(
                  labelText: 'סוג חשבון / אמצעי תשלום',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                items: AccountType.values.map((t) {
                  return DropdownMenuItem(
                    value: t,
                    child: Row(
                      children: [
                        Icon(t.defaultIcon, size: 16, color: AppColors.primary),
                        const SizedBox(width: AppSpacing.sm),
                        Text(t.label, style: const TextStyle(fontSize: 13)),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _type = val;
                      if (val == AccountType.creditCard) {
                        _iconName = 'creditCard';
                        _colorValue = 0xFF8B5CF6;
                      } else if (val == AccountType.cash) {
                        _iconName = 'cash';
                        _colorValue = 0xFF10B981;
                      } else if (val == AccountType.digitalWallet) {
                        _iconName = 'wallet';
                        _colorValue = 0xFFF59E0B;
                      } else {
                        _iconName = 'bank';
                        _colorValue = 0xFF3B82F6;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: AppSpacing.sm),

              // Account Name
              TextFormField(
                controller: _nameController,
                style: const TextStyle(fontSize: 13),
                decoration: const InputDecoration(
                  labelText: 'שם החשבון',
                  hintText: 'לדוגמה: בנק לאומי עו"ש ראשי',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'אנא הזן שם חשבון' : null,
              ),
              const SizedBox(height: AppSpacing.sm),

              // Initial Balance
              TextFormField(
                controller: _initialBalanceController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                decoration: const InputDecoration(
                  labelText: 'יתרה ראשונית (₪)',
                  hintText: '0.00',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                validator: (val) {
                  if (val == null || double.tryParse(val) == null) {
                    return 'אנא הזן סכום תקין';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.sm),

              // Credit Card Extra Configuration
              if (_type == AccountType.creditCard) ...[
                DropdownButtonFormField<int>(
                  value: _billingDayOfMonth,
                  isDense: true,
                  style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                  decoration: const InputDecoration(
                    labelText: 'יום חיוב חודשי',
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  ),
                  items: [1, 2, 5, 10, 15, 20, 25, 28].map((day) {
                    return DropdownMenuItem(value: day, child: Text('$day לחודש', style: const TextStyle(fontSize: 13)));
                  }).toList(),
                  onChanged: (val) => setState(() => _billingDayOfMonth = val),
                ),
                const SizedBox(height: AppSpacing.sm),

                if (widget.availableBankAccounts.isNotEmpty) ...[
                  DropdownButtonFormField<String?>(
                    value: _linkedAccountId,
                    isDense: true,
                    style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                    decoration: const InputDecoration(
                      labelText: 'חשבון בנק לחיוב (פירעון)',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('ללא קישור ישיר', style: TextStyle(fontSize: 13))),
                      ...widget.availableBankAccounts.map((b) => DropdownMenuItem(value: b.id, child: Text(b.name, style: const TextStyle(fontSize: 13)))),
                    ],
                    onChanged: (val) => setState(() => _linkedAccountId = val),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
              ],

              // Color & Icon
              IconColorPicker(
                selectedColor: _colorValue,
                selectedIcon: _iconName,
                onColorSelected: (col) => setState(() => _colorValue = col),
                onIconSelected: (ico) => setState(() => _iconName = ico),
              ),
              const SizedBox(height: AppSpacing.lg),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('שמור חשבון', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

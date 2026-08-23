import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../accounts/presentation/controllers/accounts_controller.dart';
import '../controllers/transfers_controller.dart';

/// Screen 6: Internal Account Transfers (העברה בין חשבונות)
class TransferScreen extends ConsumerStatefulWidget {
  const TransferScreen({super.key});

  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {
  final _amountController = TextEditingController();
  final _exchangeRateController = TextEditingController(text: '1.0');
  final _noteController = TextEditingController();

  String? _sourceAccountId;
  String? _destinationAccountId;
  DateTime _selectedDate = DateTime.now();
  bool _isCurrencyExchange = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    _exchangeRateController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _swapAccounts() {
    setState(() {
      final temp = _sourceAccountId;
      _sourceAccountId = _destinationAccountId;
      _destinationAccountId = temp;
    });
  }

  Future<void> _submitTransfer() async {
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('אנא הזן סכום העברה תקין גדול מ-0'), backgroundColor: AppColors.error),
      );
      return;
    }

    if (_sourceAccountId == null || _destinationAccountId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('חובה לבחור חשבון מקור וחשבון יעד'), backgroundColor: AppColors.error),
      );
      return;
    }

    if (_sourceAccountId == _destinationAccountId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('לא ניתן לבצע העברה בין חשבון לעצמו'), backgroundColor: AppColors.error),
      );
      return;
    }

    final exchangeRate = double.tryParse(_exchangeRateController.text.trim()) ?? 1.0;

    setState(() => _isSubmitting = true);

    try {
      await ref.read(transfersControllerProvider).executeTransfer(
            sourceAccountId: _sourceAccountId!,
            destinationAccountId: _destinationAccountId!,
            amount: amount,
            exchangeRate: _isCurrencyExchange ? exchangeRate : 1.0,
            date: _selectedDate,
            note: _noteController.text.trim().isNotEmpty ? _noteController.text.trim() : null,
          );

      if (mounted) {
        _amountController.clear();
        _noteController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ההעברה בוצעה בהצלחה ויתרות החשבונות עודכנו'),
            backgroundColor: AppColors.income,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('שגיאה בביצוע העברה: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountsStreamProvider(false));
    final accounts = accountsAsync.value ?? [];
    final transfersAsync = ref.watch(transfersStreamProvider);

    // Set initial defaults
    if (_sourceAccountId == null && accounts.isNotEmpty) {
      _sourceAccountId = accounts.first.id;
    }
    if (_destinationAccountId == null && accounts.length > 1) {
      _destinationAccountId = accounts[1].id;
    }

    final currentAmount = double.tryParse(_amountController.text.trim()) ?? 0.0;
    final exchangeRate = double.tryParse(_exchangeRateController.text.trim()) ?? 1.0;
    final convertedAmount = currentAmount * exchangeRate;

    return Scaffold(
      appBar: AppBar(
        title: const Text('העברה בין חשבונות'),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          // Transfer Setup Card
          Card(
            child: Padding(
              padding: AppSpacing.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'ביצוע העברה פנימית',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Source & Destination Accounts with Swap Button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Source Account
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _sourceAccountId,
                          isDense: true,
                          isExpanded: true,
                          style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                          decoration: const InputDecoration(
                            labelText: 'מחשבון (מקור)',
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            prefixIcon: Icon(AppIcons.bank, size: 16),
                            prefixIconConstraints: BoxConstraints(minWidth: 28, minHeight: 28),
                          ),
                          items: accounts.map((acc) {
                            return DropdownMenuItem(
                              value: acc.id,
                              child: Text(acc.name, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => _sourceAccountId = val),
                        ),
                      ),

                      // Swap Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: IconButton(
                          onPressed: _swapAccounts,
                          icon: const Icon(AppIcons.transfer, color: AppColors.primary, size: 20),
                          tooltip: 'החלף חשבונות',
                          visualDensity: VisualDensity.compact,
                        ),
                      ),

                      // Destination Account
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _destinationAccountId,
                          isDense: true,
                          isExpanded: true,
                          style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                          decoration: const InputDecoration(
                            labelText: 'לחשבון (יעד)',
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            prefixIcon: Icon(AppIcons.wallet, size: 16),
                            prefixIconConstraints: BoxConstraints(minWidth: 28, minHeight: 28),
                          ),
                          items: accounts.map((acc) {
                            return DropdownMenuItem(
                              value: acc.id,
                              child: Text(acc.name, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => _destinationAccountId = val),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Amount Input Field
                  TextField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.primary),
                    decoration: InputDecoration(
                      labelText: 'סכום להעברה',
                      hintText: '0.00 ₪',
                      contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                      fillColor: AppColors.primary.withAlpha(10),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Currency Exchange Toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'המרת מטבע (שער חליפין)',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      Switch(
                        value: _isCurrencyExchange,
                        onChanged: (val) => setState(() => _isCurrencyExchange = val),
                      ),
                    ],
                  ),

                  if (_isCurrencyExchange) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _exchangeRateController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'שער המרה (1 יח׳ מקור = X יח׳ יעד)',
                              prefixIcon: Icon(Icons.currency_exchange_rounded, size: 18),
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.divider),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('סכום יעד משוער', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                                Text(
                                  CurrencyFormatter.formatILS(convertedAmount),
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: AppSpacing.md),

                  // Date & Note Row
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() => _selectedDate = picked);
                            }
                          },
                          icon: const Icon(AppIcons.calendar, size: 18),
                          label: Text(AppDateFormatter.formatShortDate(_selectedDate)),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: TextField(
                          controller: _noteController,
                          decoration: const InputDecoration(
                            labelText: 'הערה (אופציונלי)',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Submit Button
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitTransfer,
                    child: _isSubmitting
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Text('בצע העברה', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Recent Transfers List
          const Text(
            'העברות אחרונות',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.sm),

          transfersAsync.when(
            data: (transfers) {
              if (transfers.isEmpty) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.xl),
                    child: Center(
                      child: Text(
                        'אין העברות עדיין',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  ),
                );
              }

              return Column(
                children: transfers.map((t) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.surfaceVariant,
                        child: Icon(AppIcons.transfer, color: AppColors.primary, size: 20),
                      ),
                      title: Row(
                        children: [
                          Flexible(
                            child: Text(
                              t.sourceAccountName ?? 'מקור',
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(Icons.arrow_back_rounded, size: 14, color: AppColors.textSecondary),
                          ),
                          Flexible(
                            child: Text(
                              t.destinationAccountName ?? 'יעד',
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text('${AppDateFormatter.formatShortDate(t.date)}${t.note != null ? ' • ${t.note}' : ''}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            CurrencyFormatter.formatILS(t.amount),
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          IconButton(
                            icon: const Icon(AppIcons.delete, color: AppColors.error, size: 18),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('ביטול העברה'),
                                  content: const Text('האם לבטל העברה זו? היתרות בשני החשבונות יוחזרו לקדמותן.'),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('ביטול')),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                                      onPressed: () => Navigator.pop(ctx, true),
                                      child: const Text('בטל העברה'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                await ref.read(transfersControllerProvider).deleteTransfer(t.id);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('שגיאה: $err')),
          ),
        ],
      ),
    );
  }
}

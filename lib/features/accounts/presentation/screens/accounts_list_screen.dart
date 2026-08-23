import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../domain/models/account_model.dart';
import '../controllers/accounts_controller.dart';
import '../widgets/account_card.dart';
import '../widgets/account_edit_dialog.dart';
import 'account_detail_screen.dart';

/// Screen 7: Payment Accounts, Cards and Wallets (רשימת חשבונות ואמצעי תשלום)
class AccountsListScreen extends ConsumerStatefulWidget {
  const AccountsListScreen({super.key});

  @override
  ConsumerState<AccountsListScreen> createState() => _AccountsListScreenState();
}

class _AccountsListScreenState extends ConsumerState<AccountsListScreen> {
  bool _showArchived = false;

  void _openCreateAccountDialog(List<AccountModel> accounts) {
    final bankAccounts = accounts.where((a) => a.type == AccountType.bank).toList();

    AccountEditDialog.show(
      context: context,
      availableBankAccounts: bankAccounts,
      onSave: (acc) async {
        await ref.read(accountsControllerProvider).createAccount(
              name: acc.name,
              type: acc.type,
              initialBalance: acc.initialBalance,
              linkedAccountId: acc.linkedAccountId,
              billingDayOfMonth: acc.billingDayOfMonth,
              colorValue: acc.colorValue,
              iconName: acc.iconName,
            );
      },
    );
  }

  void _openEditAccountDialog(AccountModel account, List<AccountModel> accounts) {
    final bankAccounts = accounts.where((a) => a.type == AccountType.bank && a.id != account.id).toList();

    AccountEditDialog.show(
      context: context,
      existingAccount: account,
      availableBankAccounts: bankAccounts,
      onSave: (acc) async {
        await ref.read(accountsControllerProvider).updateAccount(acc);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(accountsStreamProvider(_showArchived));
    final totalBalance = ref.watch(totalLiquidBalanceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('חשבונות ואמצעי תשלום'),
        actions: [
          IconButton(
            icon: Icon(_showArchived ? AppIcons.visibility : AppIcons.visibilityOff),
            tooltip: _showArchived ? 'הסתר חשבונות בארכיון' : 'הצג חשבונות בארכיון',
            onPressed: () => setState(() => _showArchived = !_showArchived),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'accounts_add_fab',
        onPressed: () {
          final accounts = accountsAsync.value ?? [];
          _openCreateAccountDialog(accounts);
        },
        icon: const Icon(AppIcons.add),
        label: const Text('הוספת חשבון'),
      ),
      body: accountsAsync.when(
        data: (accounts) {
          return ListView(
            padding: const EdgeInsets.only(
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.md,
              bottom: 80,
            ),
            children: [
              // Liquid Total Balance Card
              Card(
                color: AppColors.primary,
                child: Padding(
                  padding: AppSpacing.cardPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'סך יתרות נזילות (עו"ש וארנקים)',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                          SizedBox(height: AppSpacing.xs),
                          Text(
                            'יתרה משוקללת פעילה',
                            style: TextStyle(color: Colors.white60, fontSize: 11),
                          ),
                        ],
                      ),
                      Text(
                        CurrencyFormatter.formatILS(totalBalance),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              if (accounts.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.xxl),
                    child: Text('אין חשבונות להצגה'),
                  ),
                )
              else
                ...accounts.map((acc) {
                  return AccountCard(
                    account: acc,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountDetailScreen(accountId: acc.id),
                        ),
                      );
                    },
                    onEdit: () => _openEditAccountDialog(acc, accounts),
                    onToggleArchive: () async {
                      await ref.read(accountsControllerProvider).setAccountArchived(acc.id, !acc.isArchived);
                    },
                  );
                }),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('שגיאה בטעינת חשבונות: $err')),
      ),
    );
  }
}

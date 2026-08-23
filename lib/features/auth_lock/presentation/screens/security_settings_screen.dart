import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../controllers/auth_controller.dart';

/// Screen 21: Security Settings (הגדרות אבטחה ונעילה)
class SecuritySettingsScreen extends ConsumerStatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  ConsumerState<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends ConsumerState<SecuritySettingsScreen> {
  final _oldPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  final List<Map<String, dynamic>> _timeoutOptions = const [
    {'label': 'מיידי בעת מעבר לרקע', 'seconds': 0},
    {'label': 'דקה אחת', 'seconds': 60},
    {'label': '5 דקות (מומלץ)', 'seconds': 300},
    {'label': '15 דקות', 'seconds': 900},
    {'label': '30 דקות', 'seconds': 1800},
  ];

  @override
  void dispose() {
    _oldPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  void _showChangePinDialog() {
    _oldPinController.clear();
    _newPinController.clear();
    _confirmPinController.clear();

    showDialog(
      context: context,
      builder: (context) {
        String? dialogError;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Row(
                children: [
                  Icon(AppIcons.pin, color: AppColors.primary),
                  SizedBox(width: AppSpacing.sm),
                  Text('שינוי קוד PIN'),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (dialogError != null) ...[
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        margin: const EdgeInsets.only(bottom: AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.expenseLight,
                          borderRadius: AppSpacing.roundedSm,
                        ),
                        child: Text(
                          dialogError!,
                          style: const TextStyle(color: AppColors.expenseDark, fontSize: 13),
                        ),
                      ),
                    ],
                    TextField(
                      controller: _oldPinController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'קוד PIN נוכחי',
                        prefixIcon: Icon(AppIcons.lock),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _newPinController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'קוד PIN חדש',
                        prefixIcon: Icon(AppIcons.pin),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: _confirmPinController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'אימות קוד חדש',
                        prefixIcon: Icon(AppIcons.check),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('ביטול'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_newPinController.text != _confirmPinController.text) {
                      setDialogState(() {
                        dialogError = 'הקודים החדשים אינם תואמים';
                      });
                      return;
                    }
                    if (_newPinController.text.length < 4) {
                      setDialogState(() {
                        dialogError = 'הקוד החדש חייב להכיל לפחות 4 ספרות';
                      });
                      return;
                    }

                    final success = await ref.read(authControllerProvider.notifier).changePin(
                          oldPin: _oldPinController.text,
                          newPin: _newPinController.text,
                        );

                    if (success && context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('קוד ה-PIN עודכן בהצלחה'),
                          backgroundColor: AppColors.income,
                        ),
                      );
                    } else if (context.mounted) {
                      final err = ref.read(authControllerProvider).errorMessage;
                      setDialogState(() {
                        dialogError = err ?? 'שגיאה בעדכון הקוד';
                      });
                    }
                  },
                  child: const Text('שמור קוד חדש'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final authController = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('הגדרות אבטחה ונעילה'),
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          // Biometric Section
          Card(
            child: Padding(
              padding: AppSpacing.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(AppIcons.fingerprint, color: AppColors.primary, size: 24),
                      SizedBox(width: AppSpacing.md),
                      Text(
                        'אימות ביומטרי',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const Text(
                    'אפשר כניסה מהירה ומאובטחת באמצעות טביעת אצבע או זיהוי פנים',
                    style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'הפעל זיהוי ביומטרי',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    value: authState.isBiometricEnabled,
                    onChanged: authState.isBiometricAvailable
                        ? (value) => authController.setBiometricEnabled(value)
                        : null,
                    subtitle: !authState.isBiometricAvailable
                        ? const Text('זיהוי ביומטרי אינו נתמך או מוגדר במכשיר זה')
                        : null,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // PIN & Password Section
          Card(
            child: Padding(
              padding: AppSpacing.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(AppIcons.pin, color: AppColors.primary, size: 24),
                      SizedBox(width: AppSpacing.md),
                      Text(
                        'קוד גיבוי (PIN)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const Text(
                    'קוד ה-PIN משמש לכניסה לאפליקציה במקרה של כשל ביומטרי או כאשר ביומטרי כבוי',
                    style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  OutlinedButton.icon(
                    onPressed: _showChangePinDialog,
                    icon: const Icon(AppIcons.edit, size: 18),
                    label: const Text('שנה קוד PIN'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Auto Lock Timeout Section
          Card(
            child: Padding(
              padding: AppSpacing.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(AppIcons.time, color: AppColors.primary, size: 24),
                      SizedBox(width: AppSpacing.md),
                      Text(
                        'נעילה אוטומטית',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const Text(
                    'קבע לאחר כמה זמן של חוסר פעילות או מעבר לרקע האפליקציה תינעל',
                    style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ..._timeoutOptions.map((option) {
                    final isSelected = authState.autoLockTimeoutSeconds == option['seconds'];
                    return RadioListTile<int>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(option['label']),
                      value: option['seconds'],
                      groupValue: authState.autoLockTimeoutSeconds,
                      onChanged: (val) {
                        if (val != null) {
                          authController.setAutoLockTimeout(val);
                        }
                      },
                      selected: isSelected,
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Immediate Lock Button
          Card(
            color: AppColors.surfaceVariant,
            child: ListTile(
              leading: const Icon(AppIcons.lock, color: AppColors.primary),
              title: const Text(
                'נעל את האפליקציה כעת',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: const Text('מעבר מיידי למסך הנעילה'),
              trailing: const Icon(AppIcons.forward),
              onTap: () {
                authController.lockApp();
              },
            ),
          ),
        ],
      ),
    );
  }
}

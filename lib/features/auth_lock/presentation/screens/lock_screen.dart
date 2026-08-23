import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/auth_state.dart';
import '../controllers/auth_controller.dart';
import '../widgets/pin_pad_widget.dart';

/// Screen 23: Lock & Login Screen (אימות ביומטרי וקוד PIN)
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  String _enteredPin = '';
  String _confirmPin = '';
  bool _isConfirmingSetup = false;
  String? _localError;

  void _onPinChanged(String pin) async {
    setState(() {
      _localError = null;
      _enteredPin = pin;
    });

    final authState = ref.read(authControllerProvider);
    final authController = ref.read(authControllerProvider.notifier);

    if (pin.length == 4) {
      if (authState.status == AuthStatus.setupRequired) {
        // Initial setup flow
        if (!_isConfirmingSetup) {
          setState(() {
            _confirmPin = _enteredPin;
            _enteredPin = '';
            _isConfirmingSetup = true;
          });
        } else {
          if (_enteredPin == _confirmPin) {
            await authController.setupInitialPin(_enteredPin);
          } else {
            setState(() {
              _localError = 'הקודים אינם תואמים, אנא נסה שוב';
              _enteredPin = '';
              _confirmPin = '';
              _isConfirmingSetup = false;
            });
          }
        }
      } else {
        // Normal unlock flow
        final success = await authController.unlockWithPin(pin);
        if (!success) {
          setState(() {
            _enteredPin = '';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final authController = ref.read(authControllerProvider.notifier);
    final isSetup = authState.status == AuthStatus.setupRequired;

    String title;
    String subtitle;
    if (isSetup) {
      title = _isConfirmingSetup ? 'אימות קוד PIN' : 'הגדרת קוד PIN ראשוני';
      subtitle = _isConfirmingSetup
          ? 'הזן שוב את קוד ה-PIN בן 4 ספרות לאימות'
          : 'בחר קוד PIN סודי לאבטחת המידע הפיננסי שלך';
    } else {
      title = 'שלום שוב';
      subtitle = 'הזן את קוד ה-PIN או השתמש בזיהוי ביומטרי לכניסה';
    }

    final errorMessage = _localError ?? authState.errorMessage;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon Header
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 2),
                  ),
                  child: const Center(
                    child: Icon(
                      AppIcons.security,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // Title & Subtitle
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 320),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Error Banner
                if (errorMessage != null) ...[
                  Container(
                    margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.expenseLight,
                      borderRadius: AppSpacing.roundedMd,
                      border: Border.all(color: AppColors.expense.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(AppIcons.alert, color: AppColors.expense, size: 18),
                        const SizedBox(width: AppSpacing.sm),
                        Flexible(
                          child: Text(
                            errorMessage,
                            style: const TextStyle(
                              color: AppColors.expenseDark,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // PIN Pad
                PinPadWidget(
                  pin: _enteredPin,
                  pinLength: 4,
                  onPinChanged: _onPinChanged,
                  showBiometricButton: !isSetup && authState.isBiometricAvailable && authState.isBiometricEnabled,
                  onBiometricPressed: () => authController.unlockWithBiometrics(),
                  isError: errorMessage != null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

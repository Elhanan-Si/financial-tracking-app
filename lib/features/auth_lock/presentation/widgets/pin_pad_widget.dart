import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';

/// Interactive PIN Pad widget with animated dots indicator and keypad
class PinPadWidget extends StatelessWidget {
  final String pin;
  final int pinLength;
  final ValueChanged<String> onPinChanged;
  final VoidCallback? onBiometricPressed;
  final bool showBiometricButton;
  final bool isError;

  const PinPadWidget({
    super.key,
    required this.pin,
    this.pinLength = 4,
    required this.onPinChanged,
    this.onBiometricPressed,
    this.showBiometricButton = false,
    this.isError = false,
  });

  void _onNumberPressed(String number) {
    if (pin.length < pinLength) {
      onPinChanged(pin + number);
    }
  }

  void _onBackspacePressed() {
    if (pin.isNotEmpty) {
      onPinChanged(pin.substring(0, pin.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // PIN Dots Indicator
        _buildDotsIndicator(),
        const SizedBox(height: AppSpacing.xxxl),

        // Keypad Grid
        _buildKeypad(),
      ],
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pinLength, (index) {
        final isFilled = index < pin.length;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isError
                ? AppColors.error
                : isFilled
                    ? AppColors.primary
                    : AppColors.surface,
            border: Border.all(
              color: isError
                  ? AppColors.error
                  : isFilled
                      ? AppColors.primary
                      : AppColors.borderStrong,
              width: 2,
            ),
            boxShadow: isFilled
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }

  Widget _buildKeypad() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      child: Column(
        children: [
          _buildKeypadRow(['1', '2', '3']),
          const SizedBox(height: AppSpacing.lg),
          _buildKeypadRow(['4', '5', '6']),
          const SizedBox(height: AppSpacing.lg),
          _buildKeypadRow(['7', '8', '9']),
          const SizedBox(height: AppSpacing.lg),
          _buildBottomRow(),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((n) => _buildKeyButton(n)).toList(),
    );
  }

  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Biometric or empty slot
        if (showBiometricButton && onBiometricPressed != null)
          _buildActionButton(
            icon: AppIcons.fingerprint,
            onPressed: onBiometricPressed!,
          )
        else
          const SizedBox(width: 72, height: 72),

        // Number 0
        _buildKeyButton('0'),

        // Backspace
        _buildActionButton(
          icon: Icons.backspace_outlined,
          onPressed: _onBackspacePressed,
        ),
      ],
    );
  }

  Widget _buildKeyButton(String number) {
    return SizedBox(
      width: 72,
      height: 72,
      child: Material(
        color: AppColors.surface,
        shape: const CircleBorder(
          side: BorderSide(color: AppColors.border, width: 1),
        ),
        elevation: 0,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => _onNumberPressed(number),
          splashColor: AppColors.primaryLight,
          highlightColor: AppColors.surfaceVariant,
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 72,
      height: 72,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          splashColor: AppColors.primaryLight,
          child: Center(
            child: Icon(
              icon,
              size: 28,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

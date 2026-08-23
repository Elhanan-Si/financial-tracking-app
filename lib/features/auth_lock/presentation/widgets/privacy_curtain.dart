import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';

/// Privacy Curtain / Shield that obscures app content when app is locked or in app switcher
class PrivacyCurtain extends StatelessWidget {
  final Widget child;
  final bool isShieldActive;

  const PrivacyCurtain({
    super.key,
    required this.child,
    required this.isShieldActive,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        textDirection: TextDirection.rtl,
        alignment: Alignment.center,
        children: [
          child,
          if (isShieldActive)
            Positioned.fill(
              child: Container(
                color: AppColors.background,
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        AppIcons.security,
                        size: 64,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: AppSpacing.lg),
                      Text(
                        'מעקב פיננסי אישי',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppSpacing.sm),
                      Text(
                        'האפליקציה נעולה לשמירה על פרטיותך',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

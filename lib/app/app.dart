import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth_lock/presentation/controllers/auth_controller.dart';
import '../features/auth_lock/presentation/widgets/privacy_curtain.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Root Application Widget with RTL, Hebrew Localization, Light Theme, and Activity Tracking
class FinancialTrackingApp extends ConsumerStatefulWidget {
  const FinancialTrackingApp({super.key});

  @override
  ConsumerState<FinancialTrackingApp> createState() => _FinancialTrackingAppState();
}

class _FinancialTrackingAppState extends ConsumerState<FinancialTrackingApp> with WidgetsBindingObserver {
  bool _isBackgroundShieldActive = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final isResumed = state == AppLifecycleState.resumed;
    setState(() {
      _isBackgroundShieldActive = state == AppLifecycleState.paused || state == AppLifecycleState.inactive;
    });
    ref.read(authControllerProvider.notifier).handleAppLifecycleChange(isResumed);
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return Listener(
      onPointerDown: (_) {
        // Record user touch interaction for auto-lock timer
        ref.read(authControllerProvider.notifier).recordUserActivity();
      },
      child: PrivacyCurtain(
        isShieldActive: _isBackgroundShieldActive,
        child: MaterialApp.router(
          title: 'מעקב פיננסי',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: router,
          locale: const Locale('he', 'IL'),
          supportedLocales: const [
            Locale('he', 'IL'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child ?? const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}

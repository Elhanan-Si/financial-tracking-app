import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/security/biometric_auth_service.dart';
import '../../../../core/security/inactivity_timer_service.dart';
import '../../../../core/security/secure_storage_service.dart';
import '../../domain/auth_state.dart';

final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final biometricAuthServiceProvider = Provider<BiometricAuthService>((ref) {
  return BiometricAuthService();
});

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  final secureStorage = ref.watch(secureStorageServiceProvider);
  final biometricAuth = ref.watch(biometricAuthServiceProvider);
  return AuthController(secureStorage, biometricAuth);
});

class AuthController extends StateNotifier<AuthState> {
  final SecureStorageService _secureStorage;
  final BiometricAuthService _biometricAuth;
  InactivityTimerService? _inactivityTimer;

  AuthController(this._secureStorage, this._biometricAuth)
      : super(const AuthState(status: AuthStatus.initial)) {
    _init();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);

    final hasPin = await _secureStorage.hasPinSetup();
    final isBioAvailable = await _biometricAuth.canAuthenticateWithBiometrics();
    final isBioEnabled = await _secureStorage.isBiometricEnabled();
    final timeout = await _secureStorage.getAutoLockTimeout();

    _inactivityTimer = InactivityTimerService(
      timeoutSeconds: timeout,
      onLockRequired: lockApp,
    );

    if (!hasPin) {
      state = state.copyWith(
        status: AuthStatus.setupRequired,
        isBiometricAvailable: isBioAvailable,
        isBiometricEnabled: isBioEnabled,
        autoLockTimeoutSeconds: timeout,
        isLoading: false,
      );
    } else {
      state = state.copyWith(
        status: AuthStatus.locked,
        isBiometricAvailable: isBioAvailable,
        isBiometricEnabled: isBioEnabled,
        autoLockTimeoutSeconds: timeout,
        isLoading: false,
      );

      // If biometrics is enabled, attempt automatic biometric prompt
      if (isBioEnabled && isBioAvailable) {
        await unlockWithBiometrics();
      }
    }
  }

  /// Sets up a new initial PIN for the app
  Future<bool> setupInitialPin(String pin) async {
    if (pin.length < 4) {
      state = state.copyWith(errorMessage: 'קוד ה-PIN חייב להכיל לפחות 4 ספרות');
      return false;
    }
    state = state.copyWith(isLoading: true, clearError: true);
    await _secureStorage.setUserPin(pin);
    _inactivityTimer?.recordActivity();
    state = state.copyWith(
      status: AuthStatus.authenticated,
      isLoading: false,
    );
    return true;
  }

  /// Unlocks app with PIN
  Future<bool> unlockWithPin(String pin) async {
    state = state.copyWith(isLoading: true, clearError: true);
    final isValid = await _secureStorage.verifyUserPin(pin);
    if (isValid) {
      _inactivityTimer?.recordActivity();
      state = state.copyWith(
        status: AuthStatus.authenticated,
        isLoading: false,
      );
      return true;
    } else {
      state = state.copyWith(
        errorMessage: 'קוד PIN שגוי, אנא נסה שוב',
        isLoading: false,
      );
      return false;
    }
  }

  /// Unlocks app with Biometrics (fingerprint / face)
  Future<bool> unlockWithBiometrics() async {
    if (!state.isBiometricAvailable || !state.isBiometricEnabled) return false;

    state = state.copyWith(isLoading: true, clearError: true);
    final authenticated = await _biometricAuth.authenticate();
    if (authenticated) {
      _inactivityTimer?.recordActivity();
      state = state.copyWith(
        status: AuthStatus.authenticated,
        isLoading: false,
      );
      return true;
    } else {
      state = state.copyWith(
        isLoading: false,
      );
      return false;
    }
  }

  /// Locks the app and presents the lock screen
  void lockApp() {
    if (state.status == AuthStatus.authenticated) {
      state = state.copyWith(status: AuthStatus.locked, clearError: true);
    }
  }

  /// Records user touch activity to prevent timeout while actively using the app
  void recordUserActivity() {
    if (state.status == AuthStatus.authenticated) {
      _inactivityTimer?.recordActivity();
    }
  }

  /// Called when app lifecycle changes
  void handleAppLifecycleChange(bool isResumed) {
    if (isResumed) {
      _inactivityTimer?.handleAppResumed();
    } else {
      _inactivityTimer?.handleAppPaused();
    }
  }

  /// Toggles biometric unlock
  Future<void> setBiometricEnabled(bool enabled) async {
    await _secureStorage.setBiometricEnabled(enabled);
    state = state.copyWith(isBiometricEnabled: enabled);
  }

  /// Changes auto-lock timeout duration
  Future<void> setAutoLockTimeout(int seconds) async {
    await _secureStorage.setAutoLockTimeout(seconds);
    _inactivityTimer?.updateTimeout(seconds);
    state = state.copyWith(autoLockTimeoutSeconds: seconds);
  }

  /// Changes user PIN
  Future<bool> changePin({required String oldPin, required String newPin}) async {
    final isOldValid = await _secureStorage.verifyUserPin(oldPin);
    if (!isOldValid) {
      state = state.copyWith(errorMessage: 'קוד ה-PIN הישן אינו נכון');
      return false;
    }
    if (newPin.length < 4) {
      state = state.copyWith(errorMessage: 'קוד ה-PIN החדש חייב להכיל לפחות 4 ספרות');
      return false;
    }
    await _secureStorage.setUserPin(newPin);
    state = state.copyWith(clearError: true);
    return true;
  }

  @override
  void dispose() {
    _inactivityTimer?.dispose();
    super.dispose();
  }
}

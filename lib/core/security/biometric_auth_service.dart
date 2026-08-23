import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

/// Biometric Authentication Service using `local_auth`
class BiometricAuthService {
  final LocalAuthentication _auth;

  BiometricAuthService({LocalAuthentication? auth}) : _auth = auth ?? LocalAuthentication();

  /// Checks if device supports biometrics and has enrolled biometrics
  Future<bool> canAuthenticateWithBiometrics() async {
    try {
      final canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final isDeviceSupported = await _auth.isDeviceSupported();
      return canAuthenticateWithBiometrics && isDeviceSupported;
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Lists available biometric types (fingerprint, face, etc.)
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException {
      return [];
    } catch (_) {
      return [];
    }
  }

  /// Prompts biometric authentication dialog
  Future<bool> authenticate({String localizedReason = 'אנא הזדהה כדי לגשת לנתונים הפיננסיים שלך'}) async {
    try {
      final isAvailable = await canAuthenticateWithBiometrics();
      if (!isAvailable) return false;

      return await _auth.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }
}

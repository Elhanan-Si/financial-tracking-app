import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financial_tracking/core/security/biometric_auth_service.dart';
import 'package:financial_tracking/core/security/secure_storage_service.dart';
import 'package:financial_tracking/features/auth_lock/domain/auth_state.dart';
import 'package:financial_tracking/features/auth_lock/presentation/controllers/auth_controller.dart';

class FakeBiometricAuthService extends Fake implements BiometricAuthService {
  @override
  Future<bool> canAuthenticateWithBiometrics() async => true;

  @override
  Future<bool> authenticate({String localizedReason = ''}) async => true;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SecureStorageService secureStorage;
  late BiometricAuthService biometricAuth;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    secureStorage = SecureStorageService();
    biometricAuth = FakeBiometricAuthService();
  });

  group('AuthController Tests', () {
    test('initial state requires setup if no PIN set', () async {
      final controller = AuthController(secureStorage, biometricAuth);

      // Allow async _init to finish
      await Future.delayed(const Duration(milliseconds: 50));

      expect(controller.state.status, equals(AuthStatus.setupRequired));
    });

    test('setupInitialPin sets PIN and updates status to authenticated', () async {
      final controller = AuthController(secureStorage, biometricAuth);
      await Future.delayed(const Duration(milliseconds: 50));

      final success = await controller.setupInitialPin('1234');
      expect(success, isTrue);
      expect(controller.state.status, equals(AuthStatus.authenticated));

      // Lock app
      controller.lockApp();
      expect(controller.state.status, equals(AuthStatus.locked));

      // Unlock with correct PIN
      final unlockSuccess = await controller.unlockWithPin('1234');
      expect(unlockSuccess, isTrue);
      expect(controller.state.status, equals(AuthStatus.authenticated));
    });

    test('unlockWithPin fails on wrong PIN', () async {
      final controller = AuthController(secureStorage, biometricAuth);
      await Future.delayed(const Duration(milliseconds: 50));

      await controller.setupInitialPin('1234');
      controller.lockApp();

      final unlockSuccess = await controller.unlockWithPin('0000');
      expect(unlockSuccess, isFalse);
      expect(controller.state.status, equals(AuthStatus.locked));
      expect(controller.state.errorMessage, isNotNull);
    });
  });
}

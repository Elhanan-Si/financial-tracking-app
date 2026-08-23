import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financial_tracking/core/security/secure_storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SecureStorageService Tests', () {
    setUp(() {
      FlutterSecureStorage.setMockInitialValues({});
    });

    test('generates and persists DB encryption key', () async {
      final service = SecureStorageService();
      final key1 = await service.getOrCreateDatabaseEncryptionKey();
      expect(key1.isNotEmpty, isTrue);

      final key2 = await service.getOrCreateDatabaseEncryptionKey();
      expect(key2, equals(key1));
    });

    test('sets and verifies user PIN hash with salt', () async {
      final service = SecureStorageService();
      expect(await service.hasPinSetup(), isFalse);

      await service.setUserPin('1234');
      expect(await service.hasPinSetup(), isTrue);

      final isValidCorrect = await service.verifyUserPin('1234');
      expect(isValidCorrect, isTrue);

      final isValidWrong = await service.verifyUserPin('9999');
      expect(isValidWrong, isFalse);
    });

    test('updates and reads auto lock timeout and biometric preference', () async {
      final service = SecureStorageService();
      expect(await service.getAutoLockTimeout(), equals(300));

      await service.setAutoLockTimeout(60);
      expect(await service.getAutoLockTimeout(), equals(60));

      expect(await service.isBiometricEnabled(), isFalse);
      await service.setBiometricEnabled(true);
      expect(await service.isBiometricEnabled(), isTrue);
    });
  });
}

import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure Storage Service for managing DB encryption keys, user PIN hashes, and auth preferences.
class SecureStorageService {
  final FlutterSecureStorage _storage;

  static const String _keyDbEncryptionKey = 'app_db_encryption_key_v1';
  static const String _keyPinHash = 'app_user_pin_hash';
  static const String _keyPinSalt = 'app_user_pin_salt';
  static const String _keyBiometricEnabled = 'app_biometric_enabled';
  static const String _keyAutoLockTimeout = 'app_auto_lock_timeout_seconds';
  static const String _keyIsAppInitialized = 'app_is_initialized';

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
              wOptions: WindowsOptions(useBackwardCompatibility: false),
            );

  /// Retrieves the SQLCipher database encryption key, or creates a new random 256-bit key
  Future<String> getOrCreateDatabaseEncryptionKey() async {
    String? key = await _storage.read(key: _keyDbEncryptionKey);
    if (key == null || key.isEmpty) {
      key = _generateSecureRandomString(32);
      await _storage.write(key: _keyDbEncryptionKey, value: key);
    }
    return key;
  }

  /// Sets up or updates the user PIN
  Future<void> setUserPin(String pin) async {
    final salt = _generateSecureRandomString(16);
    final hash = _hashPin(pin, salt);
    await _storage.write(key: _keyPinSalt, value: salt);
    await _storage.write(key: _keyPinHash, value: hash);
    await _storage.write(key: _keyIsAppInitialized, value: 'true');
  }

  /// Verifies entered PIN against stored hash
  Future<bool> verifyUserPin(String pin) async {
    final salt = await _storage.read(key: _keyPinSalt);
    final storedHash = await _storage.read(key: _keyPinHash);
    if (salt == null || storedHash == null) {
      return false;
    }
    final enteredHash = _hashPin(pin, salt);
    return enteredHash == storedHash;
  }

  /// Checks if user has already set a PIN
  Future<bool> hasPinSetup() async {
    final hash = await _storage.read(key: _keyPinHash);
    return hash != null && hash.isNotEmpty;
  }

  /// Biometric preference
  Future<bool> isBiometricEnabled() async {
    final val = await _storage.read(key: _keyBiometricEnabled);
    return val == 'true';
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    await _storage.write(key: _keyBiometricEnabled, value: enabled.toString());
  }

  /// Auto-lock timeout in seconds (default: 300 seconds = 5 minutes)
  Future<int> getAutoLockTimeout() async {
    final val = await _storage.read(key: _keyAutoLockTimeout);
    if (val == null) return 300;
    return int.tryParse(val) ?? 300;
  }

  Future<void> setAutoLockTimeout(int seconds) async {
    await _storage.write(key: _keyAutoLockTimeout, value: seconds.toString());
  }

  /// Clears all stored credentials (used for app reset)
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  String _hashPin(String pin, String salt) {
    final bytes = utf8.encode('$pin:$salt:financial_tracking_app');
    return sha256.convert(bytes).toString();
  }

  String _generateSecureRandomString(int length) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(values).substring(0, length);
  }
}

/// Represents the security authentication status of the application
enum AuthStatus {
  initial,
  setupRequired, // First time launch: user needs to set a PIN
  locked,        // App is locked: requires PIN or Biometrics to unlock
  authenticated, // User is successfully authenticated
}

class AuthState {
  final AuthStatus status;
  final bool isBiometricAvailable;
  final bool isBiometricEnabled;
  final int autoLockTimeoutSeconds;
  final String? errorMessage;
  final bool isLoading;

  const AuthState({
    required this.status,
    this.isBiometricAvailable = false,
    this.isBiometricEnabled = false,
    this.autoLockTimeoutSeconds = 300,
    this.errorMessage,
    this.isLoading = false,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isLocked => status == AuthStatus.locked;
  bool get isSetupRequired => status == AuthStatus.setupRequired;

  AuthState copyWith({
    AuthStatus? status,
    bool? isBiometricAvailable,
    bool? isBiometricEnabled,
    int? autoLockTimeoutSeconds,
    String? errorMessage,
    bool clearError = false,
    bool? isLoading,
  }) {
    return AuthState(
      status: status ?? this.status,
      isBiometricAvailable: isBiometricAvailable ?? this.isBiometricAvailable,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      autoLockTimeoutSeconds: autoLockTimeoutSeconds ?? this.autoLockTimeoutSeconds,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

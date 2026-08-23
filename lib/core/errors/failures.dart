/// Domain level failure abstractions for Clean Architecture
abstract class Failure {
  final String message;
  final String? code;

  const Failure(this.message, [this.code]);

  @override
  String toString() => 'Failure: $message (code: $code)';
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, [super.code]);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message, [super.code]);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, [super.code]);
}

class SecurityFailure extends Failure {
  const SecurityFailure(super.message, [super.code]);
}

class SyncFailure extends Failure {
  const SyncFailure(super.message, [super.code]);
}

class ImportFailure extends Failure {
  const ImportFailure(super.message, [super.code]);
}

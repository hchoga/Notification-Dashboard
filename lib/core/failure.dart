import 'package:equatable/equatable.dart';

/// Base class for handling failures/errors based on SOLID principles
/// and functional programming approach (Either type pattern)
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Server/Network failure
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Cache failure
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// General/Unknown failure
class GeneralFailure extends Failure {
  const GeneralFailure(super.message);
}

/// Validation failure
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

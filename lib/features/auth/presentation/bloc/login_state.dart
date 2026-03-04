part of 'login_cubit.dart';

/// Base class for login states
abstract class LoginState {
  const LoginState();
}

/// Initial state
class LoginInitial extends LoginState {
  const LoginInitial();
}

/// Loading state
class LoginLoading extends LoginState {
  const LoginLoading();
}

/// Success state
class LoginSuccess extends LoginState {
  const LoginSuccess();
}

/// Error state
class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);
}

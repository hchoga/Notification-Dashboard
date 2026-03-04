import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_dashboard/features/auth/domain/usecases/login_usecase.dart';
import 'package:notification_dashboard/generated/locale_keys.g.dart';

part 'login_state.dart';

/// Cubit for handling login logic
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginInitial());

  /// Attempt to login with username and password
  Future<void> login(String username, String password) async {
    // Validate inputs
    if (username.isEmpty || password.isEmpty) {
      emit(LoginError(LocaleKeys.login_both_required));
      return;
    }

    emit(const LoginLoading());

    try {
      final success = await _loginUseCase(username, password);

      if (success) {
        emit(const LoginSuccess());
      } else {
        emit(LoginError(LocaleKeys.login_invalid_credentials));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  /// Reset to initial state
  void reset() {
    emit(const LoginInitial());
  }
}

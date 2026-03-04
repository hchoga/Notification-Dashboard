import 'package:notification_dashboard/features/auth/domain/repositories/auth_repository.dart';

/// Login use case - handles the business logic for login
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> call(String username, String password) {
    return repository.login(username, password);
  }
}

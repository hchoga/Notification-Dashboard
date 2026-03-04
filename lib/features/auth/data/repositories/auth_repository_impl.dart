import 'package:notification_dashboard/features/auth/domain/repositories/auth_repository.dart';

/// Implementation of AuthRepository with static credentials
class AuthRepositoryImpl implements AuthRepository {
  static const String _staticUsername = '123456N1';
  static const String _staticPassword = '123456N1';

  @override
  Future<bool> login(String username, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return username == _staticUsername && password == _staticPassword;
  }
}

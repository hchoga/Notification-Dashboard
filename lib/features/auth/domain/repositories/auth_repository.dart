/// Authentication use case for validating login credentials
/// This defines the contract for authentication operations
abstract class AuthRepository {
  Future<bool> login(String username, String password);
}

abstract class AuthRepository {
  Future<bool> signUp({required String login, required String password});

  Future<bool> signIn({
    required String login,
    required String password,
    required bool keepLogged,
  });

  Future<bool> getKeepLogged();
  Future<void> logout();
}
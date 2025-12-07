import 'package:nortus/src/domain/exceptions/app_exception.dart';
import 'package:nortus/src/domain/exceptions/login_exception.dart';
import 'package:nortus/src/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;
  LoginUsecase({required this.repository});

  Future<bool> call({
    required String login,
    required String password,
    required bool keepLogged,
  }) async {
    try {
      return await repository.signIn(
        login: login,
        password: password,
        keepLogged: keepLogged,
      );
    } on AppException {
      rethrow;
    } catch (e) {
      throw LoginException();
    }
  }
}
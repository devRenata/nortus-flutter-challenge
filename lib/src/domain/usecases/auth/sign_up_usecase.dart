import 'package:nortus/src/domain/exceptions/app_exception.dart';
import 'package:nortus/src/domain/exceptions/sign_up_exception.dart';
import 'package:nortus/src/domain/repositories/auth_repository.dart';

class SignUpUsecase {
  final AuthRepository repository;
  SignUpUsecase({required this.repository});

  Future<bool> call({required String login, required String password}) async {
    try {
      return await repository.signUp(login: login, password: password);
    } on AppException {
      rethrow;
    } catch (e) {
      throw SignUpException();
    }
  }
}
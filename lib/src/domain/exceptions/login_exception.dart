import 'package:nortus/src/domain/exceptions/app_exception.dart';

class LoginException implements AppException {
  @override
  String get message => 'Ocorreu um erro ao fazer login, tente novamente.';

  @override
  String get code => 'LOGIN_ERROR';

  @override
  String toString() => message;
}
import 'package:nortus/src/domain/exceptions/app_exception.dart';

class InvalidLoginException implements AppException {
  @override
  String get message => 'Login ou senha incorretos. Por favor, tente novamente.';

  @override
  String get code => 'INVALID_CREDENTIALS_ERROR';

  @override
  String toString() => message;
}
import 'package:nortus/src/domain/exceptions/app_exception.dart';

class InvalidEmailException implements AppException {
  @override
  String get message => 'O e-mail é inválido.';

  @override
  String get code => 'INVALID_EMAIL_ERROR';

  @override
  String toString() => message;
}
import 'package:nortus/src/domain/exceptions/app_exception.dart';

class DifferentPasswordsException implements AppException {
  @override
  String get message => 'As senhas precisam ser iguais.';

  @override
  String get code => 'DIFFERENT_PASSWORDS_ERROR';

  @override
  String toString() => message;
}
import 'package:nortus/src/domain/exceptions/app_exception.dart';

class UserAlreadyExistException implements AppException {
  @override
  String get message => 'Usuário já cadastrado.';

  @override
  String get code => 'USER_ALREADY_EXISTS_ERROR';

  @override
  String toString() => message;
}
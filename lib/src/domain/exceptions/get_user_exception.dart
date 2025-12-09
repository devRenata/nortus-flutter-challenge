import 'package:nortus/src/domain/exceptions/app_exception.dart';

class GetUserException implements AppException {
  @override
  String get message => 'Não foi possível obter o usuário, tente novamente.';

  @override
  String get code => 'GET_USER_ERROR';

  @override
  String toString() => message;
}
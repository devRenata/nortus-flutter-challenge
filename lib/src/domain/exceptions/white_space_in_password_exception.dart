import 'package:nortus/src/domain/exceptions/app_exception.dart';

class WhiteSpaceInPasswordException implements AppException {
  @override
  String get message => 'A senha não pode conter espaços em branco.';

  @override
  String get code => 'WHITE_SPACE_IN_PASSWORD_ERROR';

  @override
  String toString() => message;
}
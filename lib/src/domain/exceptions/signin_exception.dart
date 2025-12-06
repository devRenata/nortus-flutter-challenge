import 'package:nortus/src/domain/exceptions/app_exception.dart';

class SigninException implements AppException {
  @override
  String get message => 'Ocorreu um erro ao entrar na conta. Tente novamente.';

  @override
  String get code => 'SIGNIN_ERROR';

  @override
  String toString() => message;
}
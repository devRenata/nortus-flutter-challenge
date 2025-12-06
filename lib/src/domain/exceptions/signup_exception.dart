import 'package:nortus/src/domain/exceptions/app_exception.dart';

class SignupException implements AppException {
  @override
  String get message => 'Ocorreu um erro ao criar conta. Por favor, tente novamente.';

  @override
  String get code => 'SIGNUP_ERROR';

  @override
  String toString() => message;
}
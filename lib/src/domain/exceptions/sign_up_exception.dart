import 'package:nortus/src/domain/exceptions/app_exception.dart';

class SignUpException implements AppException {
  @override
  String get message => 'Ocorreu ao cadastrar a conta, tente novamente.';

  @override
  String get code => 'SIGN_UP_ERROR';

  @override
  String toString() => message;
}
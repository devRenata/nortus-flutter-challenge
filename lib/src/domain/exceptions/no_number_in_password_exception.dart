import 'package:nortus/src/domain/exceptions/app_exception.dart';

class NoNumberInPasswordException implements AppException {
  @override
  String get message => 'A senha deve conter números.';

  @override
  String get code => 'NO_NUMBER_IN_PASSWORD_ERROR';

  @override
  String toString() => message;
}
import 'package:nortus/src/domain/exceptions/app_exception.dart';

class NoLetterInPasswordException implements AppException {
  @override
  String get message => 'A senha deve conter letras.';

  @override
  String get code => 'NO_LETTER_IN_PASSWORD_ERROR';

  @override
  String toString() => message;
}
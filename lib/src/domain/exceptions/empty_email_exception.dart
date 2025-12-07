import 'package:nortus/src/domain/exceptions/app_exception.dart';

class EmptyEmailException implements AppException {
  @override
  String get message => 'O e-mail é obrigatório.';

  @override
  String get code => 'EMPTY_EMAIL_ERROR';

  @override
  String toString() => message;
}
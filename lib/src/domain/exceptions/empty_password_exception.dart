import 'package:nortus/src/domain/exceptions/app_exception.dart';

class EmptyPasswordException implements AppException {
  @override
  String get message => 'A senha não pode ser vazia.';

  @override
  String get code => 'EMPTY_PASSWORD_ERROR';

  @override
  String toString() => message;
}
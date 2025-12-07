import 'package:nortus/src/domain/exceptions/app_exception.dart';

class ShortPasswordException implements AppException {
  @override
  String get message => 'A senha precisa ser maior que 8 dígitos.';

  @override
  String get code => 'SHORT_PASSWORD_ERROR';

  @override
  String toString() => message;
}
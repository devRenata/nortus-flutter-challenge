import 'package:nortus/src/domain/exceptions/app_exception.dart';

class GetNewsException implements AppException {
  @override
  String get message => 'Não foi possível obter a lista de notícias, tente novamente.';

  @override
  String get code => 'GET_NEWS_ERROR';

  @override
  String toString() => message;
}
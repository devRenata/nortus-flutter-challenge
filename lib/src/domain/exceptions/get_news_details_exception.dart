import 'package:nortus/src/domain/exceptions/app_exception.dart';

class GetNewsDetailsException implements AppException {
  @override
  String get message => 'Não foi possível obter os detalhes da notícia, tente novamente.';

  @override
  String get code => 'GET_NEWS_DETAILS_ERROR';

  @override
  String toString() => message;
}
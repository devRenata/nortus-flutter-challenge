import 'package:nortus/src/domain/exceptions/app_exception.dart';

class GetCategoriesException implements AppException {
  @override
  String get message => 'Não foi possível obter a lista de categorias, tente novamente.';

  @override
  String get code => 'GET_CATEGORIES_ERROR';

  @override
  String toString() => message;
}
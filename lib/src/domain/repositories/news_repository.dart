import 'package:nortus/src/domain/entities/category.dart';

abstract class NewsRepository {
  Future<List<Category>> getCategories();
}
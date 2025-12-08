import 'package:nortus/src/domain/entities/category.dart';
import 'package:nortus/src/domain/entities/news.dart';

abstract class NewsRepository {
  Future<List<Category>> getCategories();
  Future<List<News>> getNews({required int page});
}
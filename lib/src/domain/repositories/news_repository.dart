import 'package:nortus/src/domain/entities/category.dart';
import 'package:nortus/src/domain/entities/news.dart';
import 'package:nortus/src/domain/entities/news_details.dart';

abstract class NewsRepository {
  Future<List<Category>> getCategories();
  Future<List<News>> getNews({required int page});
  Future<NewsDetails> getNewsDetails({required int id});
}
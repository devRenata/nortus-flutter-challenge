import 'package:nortus/src/data/datasources/news_remote_datasource.dart';
import 'package:nortus/src/domain/entities/category.dart';
import 'package:nortus/src/domain/exceptions/app_exception.dart';
import 'package:nortus/src/domain/exceptions/get_categories_exception.dart';
import 'package:nortus/src/domain/repositories/news_repository.dart';

class NewsRepositoryImp implements NewsRepository {
  final NewsRemoteDatasource newsRemoteDatasource;
  NewsRepositoryImp({required this.newsRemoteDatasource});
  
  @override
  Future<List<Category>> getCategories() async {
    try {
      return await newsRemoteDatasource.getCategories();
    } on AppException {
      rethrow;
    } catch (e) {
      throw GetCategoriesException();
    }
  }
}
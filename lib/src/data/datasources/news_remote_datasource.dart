import 'package:dio/dio.dart';
import 'package:nortus/src/data/http/dio_error_handler.dart';
import 'package:nortus/src/data/http/endpoints.dart';
import 'package:nortus/src/domain/entities/category.dart';
import 'package:nortus/src/domain/entities/news.dart';
import 'package:nortus/src/domain/entities/news_details.dart';
import 'package:nortus/src/domain/exceptions/get_categories_exception.dart';
import 'package:nortus/src/domain/exceptions/get_news_details_exception.dart';
import 'package:nortus/src/domain/exceptions/get_news_exception.dart';

class NewsRemoteDatasource {
  final Dio dio;
  NewsRemoteDatasource({required this.dio});
  
  Future<List<Category>> getCategories() async {
    try {
      await Future.delayed(Duration(seconds: 3));

      final response = await dio.get(Endpoints.newsCategories);

      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((e) => Category(name: e as String)).toList();
      } else {
        throw GetCategoriesException();
      }
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    } catch (e) {
      throw GetCategoriesException();
    }
  }

  Future<List<News>> getNews({required int page}) async {
    try {
      await Future.delayed(Duration(seconds: 3));

      final response = await dio.get(Endpoints.newsList(page: page));

      if (response.statusCode == 200) {
        final List data = response.data['data'];

        return data
            .map((json) => News.fromJson(json))
            .toList();
      } else {
        throw GetNewsException();
      }

    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    } catch (e) {
      throw GetNewsException();
    }
  }

  Future<NewsDetails> getNewsDetails({required int id}) async {
    try {
      await Future.delayed(Duration(seconds: 3));

      final response = await dio.get(Endpoints.newsDetails(id: id));

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return NewsDetails.fromJson(data);
      } else {
        throw GetNewsDetailsException();
      }

    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    } catch (e) {
      throw GetNewsDetailsException();
    }
  }
}
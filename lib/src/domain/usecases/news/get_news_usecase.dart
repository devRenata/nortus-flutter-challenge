import 'package:nortus/src/domain/entities/news.dart';
import 'package:nortus/src/domain/repositories/news_repository.dart';

class GetNewsUsecase {
  final NewsRepository repository;
  GetNewsUsecase({required this.repository});

  Future<List<News>> call({required int page}) async {
    return await repository.getNews(page: page);
  }
}
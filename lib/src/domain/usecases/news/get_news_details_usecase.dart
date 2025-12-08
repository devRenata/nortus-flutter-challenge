import 'package:nortus/src/domain/entities/news_details.dart';
import 'package:nortus/src/domain/repositories/news_repository.dart';

class GetNewsDetailsUsecase {
  final NewsRepository repository;
  GetNewsDetailsUsecase({required this.repository});

  Future<NewsDetails> call({required int id}) async {
    return await repository.getNewsDetails(id: id);
  }
}
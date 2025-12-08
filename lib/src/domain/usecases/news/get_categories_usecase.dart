import 'package:nortus/src/domain/entities/category.dart';
import 'package:nortus/src/domain/repositories/news_repository.dart';

class GetCategoriesUsecase {
  final NewsRepository repository;
  GetCategoriesUsecase({required this.repository});

  Future<List<Category>> call() async {
    return await repository.getCategories();
  }
}
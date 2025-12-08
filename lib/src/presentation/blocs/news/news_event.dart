import 'package:nortus/src/domain/entities/news.dart';

abstract class NewsEvent {}

class LoadCategoriesEvent extends NewsEvent {}

class GetNewsEvent extends NewsEvent {}

class GetNewsDetailsEvent extends NewsEvent {
  final int id;
  GetNewsDetailsEvent({required this.id});
}

class AddFavoriteNewsEvent extends NewsEvent {
  final News news;
  AddFavoriteNewsEvent({required this.news});
}

class RemoveFavoriteNewsEvent extends NewsEvent {
  final News news;
  RemoveFavoriteNewsEvent({required this.news});
}

class SearchNewsEvent extends NewsEvent {
  final String query;
  SearchNewsEvent({required this.query});
}
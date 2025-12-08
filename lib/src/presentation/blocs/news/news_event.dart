abstract class NewsEvent {}

class LoadCategoriesEvent extends NewsEvent {}

class GetNewsEvent extends NewsEvent {}

class GetNewsDetailsEvent extends NewsEvent {
  final int id;
  GetNewsDetailsEvent({required this.id});
}

class AddFavoriteNewsEvent extends NewsEvent {
  final int id;
  AddFavoriteNewsEvent({required this.id});
}

class RemoveFavoriteNewsEvent extends NewsEvent {
  final int id;
  RemoveFavoriteNewsEvent({required this.id});
}
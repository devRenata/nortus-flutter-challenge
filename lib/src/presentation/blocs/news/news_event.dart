abstract class NewsEvent {}

class LoadCategoriesEvent extends NewsEvent {}

class GetNewsEvent extends NewsEvent {}

class GetNewsDetailsEvent extends NewsEvent {
  final int id;
  GetNewsDetailsEvent({required this.id});
}
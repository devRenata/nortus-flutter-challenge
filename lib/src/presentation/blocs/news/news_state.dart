import 'package:nortus/src/domain/entities/category.dart';

enum NewsStatus {
  initial,
  loading,
  failure,
  success,
}

class NewsState {
  final NewsStatus status;
  final List<Category> categories;
  final String? message;

  NewsState({
    required this.status,
    required this.categories,
    required this.message,
  });
  
  factory NewsState.initial() {
    return NewsState(
      status: NewsStatus.initial,
      categories: [],
      message: null,
    );
  }

  NewsState copyWith({
    NewsStatus? status,
    List<Category>? categories,
    String? message,
  }) {
    return NewsState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      message: message,
    );
  }
}
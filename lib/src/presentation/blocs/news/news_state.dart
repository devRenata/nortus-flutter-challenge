import 'package:nortus/src/domain/entities/category.dart';
import 'package:nortus/src/domain/entities/news.dart';

enum NewsStatus {
  initial,
  loading,
  loadingNews,
  failure,
  success,
}

class NewsState {
  final NewsStatus status;
  final List<Category> categories;
  final List<News> news;
  final String? message;
  final int page;
  final bool hasReachedMax;

  NewsState({
    required this.status,
    required this.categories,
    required this.news,
    required this.message,
    required this.page,
    required this.hasReachedMax,
  });
  
  factory NewsState.initial() {
    return NewsState(
      status: NewsStatus.initial,
      categories: [],
      news: [],
      message: null,
      page: 1,
      hasReachedMax: false,
    );
  }

  NewsState copyWith({
    NewsStatus? status,
    List<Category>? categories,
    List<News>? news,
    String? message,
    int? page,
    bool? hasReachedMax,
  }) {
    return NewsState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      news: news ?? this.news,
      message: message,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
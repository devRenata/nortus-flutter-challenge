import 'package:nortus/src/domain/entities/category.dart';
import 'package:nortus/src/domain/entities/news.dart';
import 'package:nortus/src/domain/entities/news_details.dart';

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
  final NewsDetails? newsDetails;
  final List<int> favoriteNews;
  final List<News> news;
  final String? message;
  final int page;
  final bool hasReachedMax;

  NewsState({
    required this.status,
    required this.categories,
    required this.newsDetails,
    required this.favoriteNews,
    required this.news,
    required this.message,
    required this.page,
    required this.hasReachedMax,
  });
  
  factory NewsState.initial() {
    return NewsState(
      status: NewsStatus.initial,
      favoriteNews: [],
      categories: [],
      news: [],
      message: null,
      page: 1,
      hasReachedMax: false,
      newsDetails: null,
    );
  }

  NewsState copyWith({
    NewsStatus? status,
    List<Category>? categories,
    List<int>? favoriteNews,
    List<News>? news,
    String? message,
    int? page,
    NewsDetails? newsDetails,
    bool? hasReachedMax,
  }) {
    return NewsState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      news: news ?? this.news,
      message: message,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      newsDetails: newsDetails ?? this.newsDetails,
      favoriteNews: favoriteNews ?? this.favoriteNews,
    );
  }
}
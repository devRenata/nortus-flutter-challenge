import 'package:nortus/src/domain/entities/category.dart';

class RelatedNews {
  final int id;
  final String title;
  final String imageUrl;
  final List<Category> categories;
  final DateTime publishedAt;

  RelatedNews({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.categories,
    required this.publishedAt,
  });

  factory RelatedNews.fromJson(Map<String, dynamic> json) {
    return RelatedNews(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      categories: (json['categories'] as List)
          .map((e) => Category(name: e as String))
          .toList(),
      publishedAt: DateTime.parse(json['publishedAt']),
    );
  }
}
import 'package:nortus/src/domain/entities/category.dart';
import 'package:nortus/src/domain/entities/image.dart';
import 'package:nortus/src/domain/entities/related_news.dart';

class NewsDetails {
  final int id;
  final String title;
  final Image image;
  final List<Category> categories;
  final DateTime publishedAt;
  final String newsResume;
  final String estimatedReadingTime;
  final String description;
  final List<RelatedNews> relatedNews;

  NewsDetails({
    required this.id,
    required this.title,
    required this.image,
    required this.categories,
    required this.publishedAt,
    required this.newsResume,
    required this.estimatedReadingTime,
    required this.description,
    required this.relatedNews,
  });

  factory NewsDetails.fromJson(Map<String, dynamic> json) {
    return NewsDetails(
      id: json['id'],
      title: json['title'],
      image: Image.fromJson(json['image']),
      categories: (json['categories'] as List)
          .map((e) => Category(name: e as String))
          .toList(),
      publishedAt: DateTime.parse(json['publishedAt']),
      newsResume: json['newsResume'],
      estimatedReadingTime: json['estimatedReadingTime'],
      description: json['description'],
      relatedNews: (json['relatedNews'] as List)
          .map((e) => RelatedNews.fromJson(e))
          .toList(),
    );
  }
}

import 'package:nortus/src/domain/entities/author.dart';
import 'package:nortus/src/domain/entities/category.dart';
import 'package:nortus/src/domain/entities/image.dart';

class News {
  final int id;
  final Image image;
  final String title;
  final String summary;
  final List<Category> categories;
  final List<Author> authors;
  final DateTime publishedAt;

  News({
    required this.id,
    required this.image,
    required this.title,
    required this.summary,
    required this.categories,
    required this.authors,
    required this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      summary: json['summary'],
      image: Image.fromJson(json['image']),

      categories: (json['categories'] as List)
          .map((e) => Category(name: e as String))
          .toList(),

      authors: (json['authors'] as List)
          .map((e) => Author.fromJson(e))
          .toList(),

      publishedAt: DateTime.parse(json['publishedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'image': image.toJson(),
      'categories': categories
          .map((e) => e.toJson())
          .toList(),
          
      'authors': authors
          .map((e) => e.toJson())
          .toList(),

      'publishedAt': publishedAt.toIso8601String(),
    };
  }
}

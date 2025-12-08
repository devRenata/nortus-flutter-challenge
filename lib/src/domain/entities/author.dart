import 'package:nortus/src/domain/entities/image.dart';

class Author {
  final String name;
  final Image image;
  final String description;

  Author({
    required this.name,
    required this.image,
    required this.description,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'],
      image: Image.fromJson(json['image']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image.toJson(),
      'description': description,
    };
  }
}

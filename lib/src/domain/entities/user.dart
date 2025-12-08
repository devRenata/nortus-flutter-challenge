import 'package:nortus/src/domain/entities/address.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String language;
  final String dateFormat;
  final String timezone;
  final Address address;
  final DateTime updateAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.language,
    required this.dateFormat,
    required this.timezone,
    required this.address,
    required this.updateAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      language: json['language'],
      dateFormat: json['dateFormat'],
      timezone: json['timezone'],
      address: Address.fromJson(json['address']),
      updateAt: DateTime.parse(json['updatedAt']),
    );
  }
}

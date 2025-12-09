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

  User copyWith({
    String? name,
    String? email,
    String? language,
    String? dateFormat,
    String? timezone,
    Address? address,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      language: language ?? this.language,
      dateFormat: dateFormat ?? this.dateFormat,
      timezone: timezone ?? this.timezone,
      address: address ?? this.address,
      updateAt: DateTime.now(),
    );
  }
}

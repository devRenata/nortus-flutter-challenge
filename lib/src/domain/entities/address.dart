class Address {
  final String zipCode;
  final String country;
  final String street;
  final String number;
  final String complement;
  final String neighborhood;
  final String city;
  final String state;

  Address({
    required this.zipCode,
    required this.country,
    required this.street,
    required this.number,
    required this.complement,
    required this.neighborhood,
    required this.city,
    required this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      zipCode: json['zipCode'],
      country: json['country'],
      street: json['street'],
      number: json['number'],
      complement: json['complement'],
      neighborhood: json['neighborhood'],
      city: json['city'],
      state: json['state'],
    );
  }

  Address copyWith({
    String? zipCode,
    String? country,
    String? street,
    String? number,
    String? complement,
    String? neighborhood,
    String? city,
    String? state,
  }) {
    return Address(
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
      street: street ?? this.street,
      number: number ?? this.number,
      complement: complement ?? this.complement,
      neighborhood: neighborhood ?? this.neighborhood,
      city: city ?? this.city,
      state: state ?? this.state,
    );
  }
}

class Image {
  final String src;
  final String alt;

  Image({
    required this.src,
    required this.alt,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      src: json['src'],
      alt: json['alt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'src': src,
      'alt': alt,
    };
  }
}

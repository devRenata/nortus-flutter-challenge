class Endpoints {
  static String get baseUrl => 'https://flutter-challenge.wiremockapi.cloud';

  static String get auth => '$baseUrl/auth';
  static String get user => '$baseUrl/user';

  static String newsList({required int page}) => '$baseUrl/news?page=$page';
  static String newsDetails({required int id}) => '$baseUrl/news/$id/details';
  static String get newsCategories => '$baseUrl/categories';
}

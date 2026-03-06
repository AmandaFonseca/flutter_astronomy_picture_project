import 'package:flutter_dotenv/flutter_dotenv.dart';

class UrlsConstantes {
  static String get _apiKey => dotenv.env['NASA_API_KEY'] ?? '';

  static String get _baseUrl => dotenv.env['BASE_URL'] ?? '';

  static String get apodUrl => "$_baseUrl?api_key=$_apiKey&thumbs=true";
}

import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConstants {
  static String get baseUrl => dotenv.env['BASE_URL']!;
  static String get authEndpoint => '${baseUrl}${dotenv.env['AUTH_ENDPOINT']}';
  static String get clientEndpoint => '${baseUrl}${dotenv.env['CLIENT_ENDPOINT']}';
  static String get distEndpoint => '${baseUrl}${dotenv.env['DIST_ENDPOINT']}';
}
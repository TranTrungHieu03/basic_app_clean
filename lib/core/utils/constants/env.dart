import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  AppEnv._();

  static String baseUrl = dotenv.get('BASE_URL');
  static String allKey = dotenv.get('ALL_KEY');
  static String limitPagination = dotenv.get('LIMIT_PAGINATION');
  static int ratingMax = (dotenv.get("RATING_MAX") ?? 5) as int;
}

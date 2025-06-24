abstract class BaseApiServices {
  Future get(String url, Map<String, dynamic>? query);

  Future post(String url, dynamic data);

  Future put(String url, dynamic data);

  Future delete(String url);
}

class AppRouter {
  static String login = '/login';
  static String loading = '/loading';
  static String product = '/products';
  static String productDetail = '/products/:productId';
  static String splash = '/';
  static String cart = '/cart';
  static String setting = '/setting';

  static List<String> privateUrl = [product, productDetail, cart];
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_demo/core/common/pages/layout_page.dart';
import 'package:store_demo/core/common/pages/setting_page.dart';
import 'package:store_demo/core/common/pages/splash_page.dart';
import 'package:store_demo/core/utils/constants/router.dart';
import 'package:store_demo/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:store_demo/features/auth/presentation/pages/login_page.dart';
import 'package:store_demo/features/cart/presentation/pages/cart_page.dart';
import 'package:store_demo/features/product/presentation/pages/list_product_page.dart';
import 'package:store_demo/features/product/presentation/pages/product_detail_page.dart';

class AppGoRouter {
  static final _rootNavigationKey = GlobalKey<NavigatorState>(
    debugLabel: 'root',
  );
  static final _homeNavigationKey = GlobalKey<NavigatorState>(
    debugLabel: 'home',
  );
  static final _cartNavigationKey = GlobalKey<NavigatorState>(
    debugLabel: 'cart',
  );
  static final _settingNavigationKey = GlobalKey<NavigatorState>(
    debugLabel: 'setting',
  );

  static GoRouter router = GoRouter(
    initialLocation: AppRouter.splash,
    navigatorKey: _rootNavigationKey,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Error Page'))),
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigationKey,
        builder: (context, state, navigationShell) {
          return LayoutPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigationKey,
            routes: [
              GoRoute(
                path: AppRouter.product,
                builder: (BuildContext context, GoRouterState state) {
                  return const ListProductPage();
                },
                routes: <RouteBase>[],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _cartNavigationKey,
            routes: [
              GoRoute(
                path: AppRouter.cart,
                builder: (BuildContext context, GoRouterState state) {
                  return CartPage();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingNavigationKey,
            routes: [
              GoRoute(
                path: AppRouter.setting,
                builder: (BuildContext context, GoRouterState state) {
                  return SettingPage();
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRouter.productDetail,
        name: AppRouter.productDetail,
        builder: (BuildContext context, GoRouterState state) {
          return ProductDetailPage(
            productId: state.pathParameters['productId']!,
          );
        },
      ),
      GoRoute(
        path: AppRouter.splash,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),

      GoRoute(
        path: AppRouter.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) async {
      final isAuth = context.read<AuthBloc>().state is AuthLoaded;

      if (AppRouter.privateUrl.any(
        (e) => e.startsWith(state.matchedLocation),
      )) {
        if (isAuth) {
          return state.matchedLocation;
        } else {
          return AppRouter.splash;
        }
      }

      return state.matchedLocation;
    },
  );
}

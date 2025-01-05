import 'package:auto_route/auto_route.dart';
import 'package:base_core/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  factory AppRouter() {
    return _instance;
  }

  AppRouter._init();

  static final AppRouter _instance = AppRouter._init();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        _Router(
          page: SplashRoute.page,
          initial: true,
          customRouteBuilder: <T>(context, child, page) {
            return _pageRouteBuilder<T>(page, child);
          },
        ),

        _Router(
          page: HomeRouteRoute.page,
          customRouteBuilder: <T>(context, child, page) {
            return _pageRouteBuilder<T>(page, child);
          },
        ),

        /// routes go here
      ];

  PageRouteBuilder<T> _pageRouteBuilder<T>(
    AutoRoutePage<T> page,
    Widget child,
  ) {
    return PageRouteBuilder<T>(
      settings: page,
      transitionsBuilder: (ctx, anim, secondaryAnim, child) {
        final tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        final offsetAnimation = anim.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      pageBuilder: (_, __, ___) => child,
    );
  }
}

class _Router extends CustomRoute implements AutoRouteGuard {
  _Router({
    required super.page,
    super.customRouteBuilder,
    super.initial,
    super.transitionsBuilder,
  });

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next();
  }

  @override
  List<AutoRouteGuard> get guards => [this];
}

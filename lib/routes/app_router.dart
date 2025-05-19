import 'package:auto_route/auto_route.dart';
import 'package:base_core/routes/app_router.gr.dart';
import 'package:base_core/securities/auth_guard_router.dart';
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
        CustomSlideRoute(
          page: SplashRoute.page,
          initial: true,
        ),

        CustomSlideRoute(
          page: HomePageRouter.page,
          guards: [AuthGuard()],
        ),

        CustomSlideRoute(
          page: PageNotFoundRouter.page,
        ),

        /// routes go here
      ];
}

class CustomSlideRoute extends CustomRoute {
  CustomSlideRoute({
    required super.page,
    super.initial,
    super.guards,
    super.path,
    super.transitionsBuilder = CustomSlideRoute._buildPageTransition,
  });

  static Widget _buildPageTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
    final offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}

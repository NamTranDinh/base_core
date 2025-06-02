import 'package:auto_route/auto_route.dart';
import 'package:base_core/routes/app_router.gr.dart';
import 'package:base_core/securities/auth_guard_router.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  factory AppRouter() {
    return _instance;
  }

  AppRouter._init();

  static final AppRouter _instance = AppRouter._init();

  @override
  RouterConfig<UrlState> config({
    DeepLinkTransformer? deepLinkTransformer,
    DeepLinkBuilder? deepLinkBuilder,
    String? navRestorationScopeId,
    WidgetBuilder? placeholder,
    NavigatorObserversBuilder? navigatorObservers,
    bool includePrefixMatches = !kIsWeb,
    bool Function(String? location)? neglectWhen,
    bool rebuildStackOnDeepLink = false,
    Listenable? reevaluateListenable,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return super.config(
      deepLinkTransformer: deepLinkTransformer,
      deepLinkBuilder: deepLinkBuilder,
      navRestorationScopeId: navRestorationScopeId,
      placeholder: placeholder,
      navigatorObservers:
          navigatorObservers ?? () => [ChuckerFlutter.navigatorObserver],
      includePrefixMatches: includePrefixMatches,
      neglectWhen: neglectWhen,
      rebuildStackOnDeepLink: rebuildStackOnDeepLink,
      reevaluateListenable: reevaluateListenable,
      clipBehavior: clipBehavior,
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => rootNavigatorKey;

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
          page: LoginPageRouter.page,
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

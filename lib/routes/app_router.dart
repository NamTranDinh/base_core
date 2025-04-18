import 'package:base_core/pages/splash/splash_screen.dart';
import 'package:base_core/routes/app_route_name.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  factory AppRouter() {
    return _instance;
  }

  AppRouter._init();

  static final AppRouter _instance = AppRouter._init();

  static final _appRouter = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRouteName.splash.path,
    observers: [
      BotToastNavigatorObserver(),
    ],
    routes: [
      GoRoute(
        path: AppRouteName.splash.path,
        name: AppRouteName.splash.path,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
    ],
    errorBuilder: (context, state) => Container(),
  );

  static GoRouter get getRouter => _appRouter;
}

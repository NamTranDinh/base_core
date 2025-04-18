import 'package:base_core/pages/home_page/home_page_screen.dart';
import 'package:base_core/pages/home_page/home_page_screen1.dart';
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
        pageBuilder: (context, state) {
          return _customTransitionPage(page: const SplashScreen());
        },
      ),
      GoRoute(
        path: AppRouteName.home.path,
        name: AppRouteName.home.path,
        pageBuilder: (context, state) {
          return _customTransitionPage(page: const HomePageScreen());
        },
      ),
      GoRoute(
        path: AppRouteName.home1.path,
        name: AppRouteName.home1.path,
        pageBuilder: (context, state) {
          return _customTransitionPage(page: const HomePageScreen1());
        },
      ),
    ],
    errorBuilder: (context, state) => Container(),
  );

  static CustomTransitionPage<dynamic> _customTransitionPage({
    required Widget page,
  }) {
    return CustomTransitionPage(
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.linear).animate(
            animation,
          ),
          child: child,
        );
      },
    );
  }

  static GoRouter get getRouter => _appRouter;
}

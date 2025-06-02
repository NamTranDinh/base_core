// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:base_core/commons/app_components/widgets/page_not_found.dart'
    as _i3;
import 'package:base_core/features/home_page/presentation/pages/home_page.dart'
    as _i1;
import 'package:base_core/features/login/presentation/pages/login_page.dart'
    as _i2;
import 'package:base_core/features/splash/presentation/pages/splash_page.dart' as _i4;

/// generated route for
/// [_i1.HomePage]
class HomePageRouter extends _i5.PageRouteInfo<void> {
  const HomePageRouter({List<_i5.PageRouteInfo>? children})
      : super(HomePageRouter.name, initialChildren: children);

  static const String name = 'HomePageRouter';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.LoginPage]
class LoginPageRouter extends _i5.PageRouteInfo<void> {
  const LoginPageRouter({List<_i5.PageRouteInfo>? children})
      : super(LoginPageRouter.name, initialChildren: children);

  static const String name = 'LoginPageRouter';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginPage();
    },
  );
}

/// generated route for
/// [_i3.PageNotFound]
class PageNotFoundRouter extends _i5.PageRouteInfo<void> {
  const PageNotFoundRouter({List<_i5.PageRouteInfo>? children})
      : super(PageNotFoundRouter.name, initialChildren: children);

  static const String name = 'PageNotFoundRouter';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.PageNotFound();
    },
  );
}

/// generated route for
/// [_i4.SplashPage]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
      : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashPage();
    },
  );
}

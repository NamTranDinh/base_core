// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:base_core/commons/app_components/widgets/page_not_found.dart'
    as _i2;
import 'package:base_core/features/home_page/home_page.dart' as _i1;
import 'package:base_core/features/splash/splash_page.dart' as _i3;

/// generated route for
/// [_i1.HomePage]
class HomePageRouter extends _i4.PageRouteInfo<void> {
  const HomePageRouter({List<_i4.PageRouteInfo>? children})
    : super(HomePageRouter.name, initialChildren: children);

  static const String name = 'HomePageRouter';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.PageNotFound]
class PageNotFoundRouter extends _i4.PageRouteInfo<void> {
  const PageNotFoundRouter({List<_i4.PageRouteInfo>? children})
    : super(PageNotFoundRouter.name, initialChildren: children);

  static const String name = 'PageNotFoundRouter';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.PageNotFound();
    },
  );
}

/// generated route for
/// [_i3.SplashPage]
class SplashRoute extends _i4.PageRouteInfo<void> {
  const SplashRoute({List<_i4.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SplashPage();
    },
  );
}

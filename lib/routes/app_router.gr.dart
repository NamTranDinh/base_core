// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:base_core/pages/home_page/home_page_screen.dart'
    deferred as _i1;
import 'package:base_core/pages/splash/splash_screen.dart' deferred as _i2;

/// generated route for
/// [_i1.HomePageScreen]
class HomeRouteRoute extends _i3.PageRouteInfo<void> {
  const HomeRouteRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HomeRouteRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouteRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return _i3.DeferredWidget(
        _i1.loadLibrary,
        () => _i1.HomePageScreen(),
      );
    },
  );
}

/// generated route for
/// [_i2.SplashScreen]
class SplashRoute extends _i3.PageRouteInfo<void> {
  const SplashRoute({List<_i3.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return _i3.DeferredWidget(
        _i2.loadLibrary,
        () => _i2.SplashScreen(),
      );
    },
  );
}

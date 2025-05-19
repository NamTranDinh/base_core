import 'package:auto_route/auto_route.dart';
import 'package:base_core/routes/app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_isUserAuthenticated()) {
      resolver.next();
    } else {
      router.replaceAll([const PageNotFoundRouter()]);
    }
  }

  bool _isUserAuthenticated() {
    return true;
  }
}

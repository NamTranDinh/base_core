class AppRouteName {
  static RouterModel splash = RouterModel(
    path: '/',
  );
  static RouterModel notFoundScreen = RouterModel(
    path: '/page-not-found',
  );
  static RouterModel notPermissionScreen = RouterModel(
    path: '/no-access',
  );
  static RouterModel underMaintenanceScreen = RouterModel(
    path: '/under-maintenance',
  );
  static RouterModel welcome = RouterModel(
    path: '/welcome',
  );
  static RouterModel home = RouterModel(
    path: '/home',
  );
  static RouterModel home1 = RouterModel(
    path: '/home1',
  );
}

class RouterModel {
  RouterModel({
    required this.path,
    this.breadCrumb,
    this.breadCrumbPathLevel,
  });

  final String path;
  final String? breadCrumb;
  final List<String>? breadCrumbPathLevel;

  @override
  String toString() {
    return 'RouterModel{path: $path, breadCrumb: $breadCrumb, breadCrumbPathLevel: $breadCrumbPathLevel}';
  }
}

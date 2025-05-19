enum Flavor {
  develop,
  uat,
  product,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.develop:
        return '[DEV] Base Core';
      case Flavor.uat:
        return '[UAT] Base Core';
      case Flavor.product:
        return 'Base Core';
    }
  }
}

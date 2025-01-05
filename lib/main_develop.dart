import 'package:base_core/flavors.dart';

import 'package:base_core/main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.develop;
  await runner.main();
}

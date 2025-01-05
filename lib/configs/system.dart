import 'dart:async';

import 'package:base_core/flavors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SystemConfiguration {
  static Future<void> initEnv() async {
    F.appFlavor = _getFlavor();
    await dotenv.load(fileName: 'environments/.env');
  }

  static Flavor _getFlavor() {
    const f = String.fromEnvironment('FLAVOR', defaultValue: 'UN_KNOW_FLAVOR');
    if (f == 'develop') {
      return Flavor.develop;
    } else if (f == 'uat') {
      return Flavor.uat;
    } else if (f == 'product') {
      return Flavor.product;
    }

    return Flavor.product;
  }

  static const header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}


class LanguageManager {
  factory LanguageManager() {
    return _instance;
  }

  LanguageManager._init();

  static final LanguageManager _instance = LanguageManager._init();

  final enLocale = const Locale('en', 'US');

  List<Locale> get supportedLocales => [enLocale];
}

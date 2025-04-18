import 'dart:async';

import 'package:base_core/flavors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SystemConfiguration {
  static Future<void> initEnv() async {
    await dotenv.load(fileName: 'environments/.env');
    F.appFlavor = _getFlavor();
  }

  static Flavor _getFlavor() {
    final f = dotenv.get('FLAVOR');
    if (f == 'DEVELOP') {
      return Flavor.develop;
    } else if (f == 'UAT') {
      return Flavor.uat;
    } else if (f == 'PRODUCT') {
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

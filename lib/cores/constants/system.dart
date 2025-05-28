import 'dart:async';
import 'dart:io';

import 'package:base_core/flavors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SystemConfiguration {
  SystemConfiguration._();

  static Future<void> initEnv({String? envFileName}) async {
    final String actualEnvFileName = envFileName ??
        _determineEnvFileNameFromDartEnv() ??
        'environments/develop.env';

    try {
      await dotenv.load(fileName: actualEnvFileName);
      F.appFlavor = _getFlavorFromEnv();
    } on FileSystemException {
      F.appFlavor = Flavor.develop;
    } on Exception {
      F.appFlavor = Flavor.develop;
    }
  }

  static String? _determineEnvFileNameFromDartEnv() {
    const String appFlavorEnvVar = String.fromEnvironment('APP_FLAVOR');
    if (appFlavorEnvVar.isNotEmpty) {
      return 'environments/$appFlavorEnvVar.env';
    }
    return null;
  }

  static Flavor _getFlavorFromEnv() {
    final flavorString = dotenv.env['FLAVOR'];
    switch (flavorString) {
      case 'develop':
        return Flavor.develop;
      case 'uat':
        return Flavor.uat;
      case 'product':
        return Flavor.product;
      default:
        return Flavor.product;
    }
  }

  static const Map<String, String> defaultJsonHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}

class LanguageManager {
  LanguageManager._init();

  static final LanguageManager instance = LanguageManager._init();

  static const Locale enLocale = Locale('en', 'US');

  static const List<Locale> supportedLocales = [enLocale];
}

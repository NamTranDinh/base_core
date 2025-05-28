import "dart:async";

import "package:base_core/cores/constants/system.dart";
import "package:base_core/cores/dependency_injection/di.dart";
import "package:base_core/features/app/app_page.dart";
import "package:bot_toast/bot_toast.dart";
import "package:chucker_flutter/chucker_flutter.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  ChuckerFlutter.showOnRelease = false;
  BotToastInit();

  await SystemConfiguration.initEnv();
  await initDI();

  runApp(
    EasyLocalization(
      path: "assets/i18n",
      fallbackLocale: LanguageManager.enLocale,
      supportedLocales: LanguageManager.supportedLocales,
      child: const AppPage(),
    ),
  );
}

import "dart:async";

import "package:base_core/commons/app_components/loadings/loading_overlay.dart";
import "package:base_core/commons/app_components/loadings/overlay_manager.dart";
import "package:base_core/configs/system.dart";
import "package:base_core/di/di.dart";
import "package:base_core/pages/app/app_page.dart";
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

  OverlayManager.addEntry("loading", loadingOverlay);

  runApp(
    EasyLocalization(
      path: "assets/i18n",
      fallbackLocale: LanguageManager.enLocale,
      supportedLocales: LanguageManager.supportedLocales,
      child: const AppPage(),
    ),
  );
}

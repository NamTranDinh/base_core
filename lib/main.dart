import "dart:async";

import "package:base_core/cores/constants/system.dart";
import "package:base_core/cores/dependency_injection/di.dart";
import "package:base_core/cores/exception/app_error_logger.dart";
import "package:base_core/features/app/presentation/pages/app_page.dart";
import "package:bot_toast/bot_toast.dart";
import "package:chucker_flutter/chucker_flutter.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  ChuckerFlutter.showOnRelease = false;
  BotToastInit();

  await SystemConfiguration.initEnv();
  await initDI();

  await AppErrorLogger.instance.initialize();

  setupErrorHandlingWithFileLogging();
  runApp(
    EasyLocalization(
      path: "assets/i18n",
      fallbackLocale: LanguageManager.enLocale,
      supportedLocales: LanguageManager.supportedLocales,
      child: const AppPage(),
    ),
  );
}

// Setup error handling với file logging
void setupErrorHandlingWithFileLogging() {
  // 1. Flutter Framework Errors
  FlutterError.onError = (FlutterErrorDetails details) async {
    // Log vào file
    await AppErrorLogger.instance.logError(
      source: 'FlutterError',
      error: details.exception,
      stackTrace: details.stack,
      additionalInfo: {
        'library': details.library,
        'context': details.context?.toString(),
        'informationCollector': details.informationCollector?.toString(),
      },
    );

    // Debug mode: show red screen
    if (kDebugMode) {
      FlutterError.presentError(details);
    }
  };

  // 2. Platform Dispatcher Errors
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    // Log vào file
    unawaited(
      AppErrorLogger.instance.logError(
        source: 'PlatformDispatcher',
        error: error,
        stackTrace: stack,
        additionalInfo: {
          'thread': 'main',
          'handled': true,
        },
      ),
    );

    return true;
  };
}

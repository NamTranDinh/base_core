import 'package:base_core/cores/app_color.dart';
import 'package:base_core/cores/app_text_style.dart';
import 'package:base_core/cores/app_theme.dart';
import 'package:base_core/di/di.dart';
import 'package:base_core/routes/app_router.dart';
import 'package:flutter/material.dart';

class AppData {
  AppData(this.context);

  AppData.of(this.context);

  final BuildContext context;

  AppRouter get router => getIt<AppRouter>();

  BuildContext get themeContext => router.navigatorKey.currentContext!;

  AppThemeData get appTheme => MyAppTheme.of(context);

  AppColorTheme get colorTheme => appTheme.colorTheme;

  AppTextTheme get textTheme => appTheme.textTheme;
}

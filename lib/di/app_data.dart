import 'package:base_core/cores/app_color.dart';
import 'package:base_core/cores/app_text_style.dart';
import 'package:base_core/cores/app_theme.dart';
import 'package:base_core/di/di.dart';
import 'package:base_core/routes/app_router.dart';
import 'package:flutter/material.dart';

class AppData {
  AppData(this.themeContext);

  AppData.of(this.themeContext);

  final BuildContext themeContext;

  AppRouter get router => getIt<AppRouter>();

  BuildContext get context => router.navigatorKey.currentContext!;

  AppThemeData get appTheme => MyAppTheme.of(themeContext);

  AppColorTheme get colorTheme => appTheme.colorTheme;

  AppTextTheme get textTheme => appTheme.textTheme;
}

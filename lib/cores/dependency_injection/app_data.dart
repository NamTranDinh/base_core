import 'package:base_core/blocs/app/app_cubit.dart';
import 'package:base_core/cores/dependency_injection/di.dart';
import 'package:base_core/cores/themes/app_color.dart';
import 'package:base_core/cores/themes/app_text_theme.dart';
import 'package:base_core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppData {
  AppData(this.context);

  AppData.of(this.context);

  final BuildContext context;

  AppRouter get router => getIt<AppRouter>();

  BuildContext get themeContext => router.navigatorKey.currentContext!;

  Brightness get appTheme => Theme.of(context).brightness;

  ThemeMode get themeMode => context.read<AppCubit>().state.themeMode;

  AppTextTheme get textStyle {
    return AppTextTheme.raw(context: context);
  }

  AppColor get color {
    switch (themeMode) {
      case ThemeMode.dark:
        return AppColor.dark();
      case ThemeMode.light:
        return AppColor.light();
      case ThemeMode.system:
        switch (appTheme) {
          case Brightness.dark:
            return AppColor.dark();
          case Brightness.light:
            return AppColor.light();
        }
    }
  }
}

import 'package:base_core/configs/themes/app_dark_color.dart';
import 'package:base_core/configs/themes/app_light_color.dart';
import 'package:flutter/material.dart';

class AppColors {
  AppColors(this.context);

  AppColors.of(this.context);

  BuildContext context;

  MaterialColor get error => _getMaterialColor(
        darkColor: AppDarkColors().error,
        lightColor: AppLightColors().error,
      );

  MaterialColor get primary => _getMaterialColor(
        darkColor: AppDarkColors().primary,
        lightColor: AppLightColors().primary,
      );

  MaterialColor get success => _getMaterialColor(
        darkColor: AppDarkColors().success,
        lightColor: AppLightColors().success,
      );

  MaterialColor get warning => _getMaterialColor(
        darkColor: AppDarkColors().warning,
        lightColor: AppLightColors().warning,
      );

  Color _getColor({required Color darkColor, required Color lightColor}) {
    final theme = _getTheme();
    if (theme == ThemeMode.dark) {
      return darkColor;
    } else {
      return lightColor;
    }
  }

  MaterialColor _getMaterialColor({
    required MaterialColor darkColor,
    required MaterialColor lightColor,
  }) {
    final theme = _getTheme();
    if (theme == ThemeMode.dark) {
      return darkColor;
    } else {
      return lightColor;
    }
  }

  ThemeMode _getTheme() {
    // check from state
    // final themeMode = _themeState();
    // if (themeMode == ThemeMode.dark) {
    //   return ThemeMode.dark;
    // }
    // if (themeMode == ThemeMode.light) {
    //   return ThemeMode.light;
    // }
    // check from brightness
    final brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.dark) {
      return ThemeMode.dark;
    } if(brightness == Brightness.light){
      return ThemeMode.light;

    } else {
      return ThemeMode.system;
    }
  }
}

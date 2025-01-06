import 'package:base_core/cores/app_color.dart';
import 'package:base_core/cores/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:helper_utils/helper_utils.dart';

class AppThemeData {
  factory AppThemeData({required AppColorTheme colorTheme}) => AppThemeData.raw(
        textTheme: AppTextTheme.create(colorTheme.primaryText),
        colorTheme: colorTheme,
      );

  factory AppThemeData.light() => AppThemeData(
        colorTheme: AppColorTheme.light(),
      );

  factory AppThemeData.dark() => AppThemeData(
        colorTheme: AppColorTheme.dark(),
      );

  factory AppThemeData.system(BuildContext context) {
    final brightness = context.brightness;
    if (brightness == Brightness.dark) {
      return AppThemeData.dark();
    } else if (brightness == Brightness.light) {
      return AppThemeData.light();
    }
    return AppThemeData.light();
  }

  const AppThemeData.raw({
    required this.textTheme,
    required this.colorTheme,
  });

  final AppTextTheme textTheme;
  final AppColorTheme colorTheme;
}

class MyAppTheme extends InheritedWidget {
  const MyAppTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final AppThemeData data;

  static AppThemeData of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<MyAppTheme>();
    assert(result != null, 'No AppTheme found in context');
    return result!.data;
  }

  @override
  bool updateShouldNotify(covariant MyAppTheme oldWidget) {
    return data != oldWidget.data;
  }
}

import 'package:base_core/cores/app_color.dart';
import 'package:base_core/cores/app_dimens.dart';
import 'package:base_core/cores/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:helper_utils/helper_utils.dart';

class AppThemeData {
  factory AppThemeData({
    required AppColorTheme colorTheme,
    required ThemeData themeData,
  }) {
    return AppThemeData.raw(
      textTheme: AppTextTheme.create(colorTheme.primaryText),
      colorTheme: colorTheme,
      themeData: themeData,
    );
  }

  factory AppThemeData.light() {
    final lightColor = AppColorTheme.light();
    return AppThemeData(
      colorTheme: lightColor,
      themeData: _baseTheme(lightColor),
    );
  }

  factory AppThemeData.dark() {
    final darkColor = AppColorTheme.dark();
    return AppThemeData(
      colorTheme: darkColor,
      themeData: _baseTheme(darkColor),
    );
  }

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
    required this.themeData,
  });

  final AppTextTheme textTheme;
  final AppColorTheme colorTheme;
  final ThemeData themeData;

  static ThemeData _baseTheme(
    AppColorTheme colorTheme, {
    Brightness? brightness,
  }) {
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: colorTheme.background,
      primaryColor: colorTheme.primary,
      indicatorColor: colorTheme.primary,
      hoverColor: colorTheme.originalWhite,
      highlightColor: colorTheme.originalWhite,
      splashColor: colorTheme.primary.withAlpha((255 / 5).round()),
      popupMenuTheme: PopupMenuThemeData(color: colorTheme.originalWhite),
      scrollbarTheme: ScrollbarThemeData(
        trackColor: WidgetStatePropertyAll(colorTheme.primary),
        thumbColor: WidgetStatePropertyAll(colorTheme.primary),
        radius: const Radius.circular(100),
        thickness: const WidgetStatePropertyAll(1.5),
      ),
      appBarTheme: AppBarTheme(
        color: colorTheme.originalWhite,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: colorTheme.primaryText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          // fontFamily: FontFamily.firaSansRegular,
        ),
        elevation: 0,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorTheme.originalWhite,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.appBorderRadius),
          ),
          elevation: 1,
          shadowColor: Colors.transparent,
          alignment: Alignment.center,
          overlayColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.white,
          backgroundColor: colorTheme.primary,
          disabledBackgroundColor: Colors.grey,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black54,
          overlayColor: colorTheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(3),
          ),
          textStyle: TextStyle(
            color: colorTheme.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            // fontFamily: FontFamily.firaSansRegular,
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.5),
        ),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorTheme.primary;
          } else {
            return colorTheme.originalWhite;
          }
        }),
        side: BorderSide(color: colorTheme.primary),
        checkColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorTheme.originalWhite;
          } else {
            return colorTheme.primary;
          }
        }),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: colorTheme.originalWhite,
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: TextStyle(
          color: colorTheme.error,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          // fontFamily: FontFamily.firaSansRegular,
        ),
        border: const OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(AppDimens.appBorderRadius)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(AppDimens.appBorderRadius)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(AppDimens.appBorderRadius)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(AppDimens.appBorderRadius)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimens.appBorderRadius),
          ),
          borderSide: BorderSide(color: colorTheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimens.appBorderRadius),
          ),
          borderSide: BorderSide(color: colorTheme.error),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorTheme.primary,
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStatePropertyAll(colorTheme.primary),
      ),
      sliderTheme: SliderThemeData(
        trackHeight: 3,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
        activeTrackColor: colorTheme.originalWhite,
        inactiveTrackColor: colorTheme.originalWhite.withAlpha(
          (255 / 3).round(),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return colorTheme.primary;
          } else {
            return colorTheme.originalWhite;
          }
        }),
        trackColor: WidgetStateProperty.all(
          colorTheme.primary.withAlpha((255 / 5).round()),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorTheme.primary,
      ),
    );
  }
}

class MyAppTheme extends InheritedWidget {
  const MyAppTheme({
    super.key,
    required this.appThemeData,
    required super.child,
  });

  final AppThemeData appThemeData;

  static AppThemeData of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<MyAppTheme>();
    assert(result != null, 'No AppTheme found in context');
    return result!.appThemeData;
  }

  @override
  bool updateShouldNotify(covariant MyAppTheme oldWidget) {
    return appThemeData != oldWidget.appThemeData;
  }
}

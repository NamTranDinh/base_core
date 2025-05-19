import 'package:base_core/cores/app_color.dart';
import 'package:base_core/cores/app_dimens.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData setTheme(AppColor colorTheme, {Brightness? brightness}) {
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: colorTheme.background,
      primaryColor: colorTheme.primary,
      indicatorColor: colorTheme.primary,
      hoverColor: Colors.white,
      highlightColor: Colors.white,
      splashColor: colorTheme.primary.withAlpha((255 / 5).round()),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
      scrollbarTheme: ScrollbarThemeData(
        trackColor: WidgetStatePropertyAll(colorTheme.primary),
        thumbColor: WidgetStatePropertyAll(colorTheme.primary),
        radius: const Radius.circular(100),
        thickness: const WidgetStatePropertyAll(1.5),
      ),
      appBarTheme: AppBarTheme(
        color: colorTheme.primary,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: colorTheme.primaryText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          // fontFamily: FontFamily.firaSansRegular,
        ),
        elevation: 0,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
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
          overlayColor: Colors.grey.shade200,
          surfaceTintColor: Colors.grey.shade200,
          foregroundColor: Colors.grey.shade200,
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
            return Colors.white;
          }
        }),
        side: BorderSide(color: colorTheme.primary),
        checkColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          } else {
            return colorTheme.primary;
          }
        }),
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: Colors.white,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
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
        activeTrackColor: Colors.white,
        inactiveTrackColor: Colors.white.withAlpha(
          (255 / 3).round(),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return colorTheme.primary;
          } else {
            return Colors.white;
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

import 'package:base_core/cores/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightAppTheme(BuildContext context) => ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors(context).primary,
        indicatorColor: AppColors(context).primary,
        hoverColor: AppColors(context).primary,
        highlightColor: AppColors(context).primary,
        splashColor: AppColors(context).primary.withAlpha((255 * .2).toInt()),
        scaffoldBackgroundColor: Colors.white,
        popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
        scrollbarTheme: ScrollbarThemeData(
          trackColor: WidgetStatePropertyAll(AppColors(context).primary),
          thumbColor: WidgetStatePropertyAll(AppColors(context).primary),
          radius: const Radius.circular(100),
          thickness: const WidgetStatePropertyAll(1.5),
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
        elevatedButtonTheme: const ElevatedButtonThemeData(),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors(context).primary,
          highlightElevation: 1,
          focusElevation: 1,
          hoverElevation: 1,
          elevation: 1,
          disabledElevation: 1,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black54,
            overlayColor: AppColors(context).primary,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(3),
            ),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.5),
          ),
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors(context).primary;
            } else {
              return Colors.white;
            }
          }),
          side: BorderSide(color: AppColors(context).primary),
          checkColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            } else {
              return AppColors(context).primary;
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
        dividerTheme: const DividerThemeData(),
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: TextStyle(
            color: AppColors(context).error,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColors(context).error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColors(context).error),
          ),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors(context).primary,
        ),
        radioTheme: RadioThemeData(
          fillColor: WidgetStatePropertyAll(AppColors(context).primary),
        ),
        sliderTheme: SliderThemeData(
          trackHeight: 3,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.white.withAlpha((255 * .3).toInt()),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors(context).primary;
            } else {
              return Colors.white;
            }
          }),
          trackColor: WidgetStateProperty.all(AppColors(context).primary),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors(context).primary,
        ),
      );

  static ThemeData darkAppTheme(BuildContext context) => ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors(context).primary,
        indicatorColor: AppColors(context).primary,
        hoverColor: AppColors(context).primary,
        highlightColor: AppColors(context).primary,
        splashColor: AppColors(context).primary.withAlpha((255 * .2).toInt()),
        scaffoldBackgroundColor: Colors.white,
        popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
        scrollbarTheme: ScrollbarThemeData(
          trackColor: WidgetStatePropertyAll(AppColors(context).primary),
          thumbColor: WidgetStatePropertyAll(AppColors(context).primary),
          radius: const Radius.circular(100),
          thickness: const WidgetStatePropertyAll(1.5),
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
        elevatedButtonTheme: const ElevatedButtonThemeData(),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors(context).primary,
          highlightElevation: 1,
          focusElevation: 1,
          hoverElevation: 1,
          elevation: 1,
          disabledElevation: 1,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black54,
            overlayColor: AppColors(context).primary,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(3),
            ),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.5),
          ),
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors(context).primary;
            } else {
              return Colors.white;
            }
          }),
          side: BorderSide(color: AppColors(context).primary),
          checkColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            } else {
              return AppColors(context).primary;
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
        dividerTheme: const DividerThemeData(),
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: TextStyle(
            color: AppColors(context).error,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColors(context).error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: AppColors(context).error),
          ),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors(context).primary,
        ),
        radioTheme: RadioThemeData(
          fillColor: WidgetStatePropertyAll(AppColors(context).primary),
        ),
        sliderTheme: SliderThemeData(
          trackHeight: 3,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
          activeTrackColor: Colors.white,
          inactiveTrackColor: Colors.white.withAlpha((255 * .3).toInt()),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors(context).primary;
            } else {
              return Colors.white;
            }
          }),
          trackColor: WidgetStateProperty.all(AppColors(context).primary),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors(context).primary,
        ),
      );
}

import 'package:base_core/cores/dependency_injection/app_data.dart';
import 'package:flutter/material.dart';

String? defaultFont;
String? googleLoginFont;

class AppTextTheme {
  const AppTextTheme({
    required this.s10,
    required this.s11,
    required this.s12,
    required this.s13,
    required this.s14,
    required this.s15,
    required this.s16,
    required this.s18,
    required this.s20,
    required this.s22,
    required this.s24,
    required this.s28,
    required this.s32,
  });

  factory AppTextTheme.raw({required BuildContext context}) {
    return AppTextTheme(
      s10: TextStyle(
        fontSize: 10,
        fontFamily: defaultFont,
        color: AppData(context).color.primaryTextButton,
      ),
      s11: TextStyle(
        fontSize: 11,
        fontFamily: defaultFont,
        color: AppData(context).color.primaryTextButton,
      ),
      s12: TextStyle(
        fontSize: 12,
        fontFamily: defaultFont,
        color: AppData(context).color.primaryTextButton,
      ),
      s13: TextStyle(
        fontSize: 13,
        fontFamily: defaultFont,
        color: AppData(context).color.primaryTextButton,
      ),
      s14: TextStyle(
        fontSize: 14,
        fontFamily: googleLoginFont,
        color: AppData(context).color.primaryTextButton,
      ),
      s15: TextStyle(
        fontSize: 15,
        fontFamily: defaultFont,
        color: AppData(context).color.primaryTextButton,
      ),
      s16: TextStyle(
        fontSize: 16,
        fontFamily: defaultFont,
        color: AppData(context).color.primaryTextButton,
      ),
      s18: TextStyle(
        fontSize: 18,
        fontFamily: defaultFont,
        color: AppData(context).color.primaryTextButton,
      ),
      s20: TextStyle(
        fontSize: 20,
        fontFamily: defaultFont,
        color: AppData(context).color.primaryTextButton,
      ),
      s22: TextStyle(
        fontSize: 22,
        fontFamily: defaultFont,
        color: AppData(context).color.primaryTextButton,
      ),
      s24: TextStyle(
        fontSize: 24,
        fontFamily: defaultFont,
        color: AppData(context).color.primaryTextButton,
      ),
      s28: TextStyle(
        fontSize: 28,
        fontFamily: defaultFont,
        color: AppData(context).color.primaryTextButton,
      ),
      s32: TextStyle(
        fontSize: 32,
        fontFamily: defaultFont,
        color: AppData(context).color.primaryTextButton,
      ),
    );
  }

  final TextStyle s10;
  final TextStyle s11;
  final TextStyle s12;
  final TextStyle s13;
  final TextStyle s14;
  final TextStyle s15;
  final TextStyle s16;
  final TextStyle s18;
  final TextStyle s20;
  final TextStyle s22;
  final TextStyle s24;
  final TextStyle s28;
  final TextStyle s32;
}

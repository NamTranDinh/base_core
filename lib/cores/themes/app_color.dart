import 'package:flutter/material.dart';

class AppColor {
  AppColor({
    required this.primary,
    required this.primaryText,
    required this.primaryTextButton,
    required this.background,
    required this.success,
    required this.warning,
    required this.error,
  });

  factory AppColor.light() => AppColor(
        primary: const MaterialColor(
          0xffd2a780,
          {100: Color(0xffd2a780)},
        ),
        primaryText: const MaterialColor(
          0xFF282523,
          {100: Color(0xFF282523)},
        ),
        primaryTextButton: const MaterialColor(
          0xFF282523,
          {100: Color(0xFF282523)},
        ),
        background: const MaterialColor(
          0xffeeeae7,
          {100: Color(0xffeeeae7)},
        ),
        success: const MaterialColor(
          0xFF2DBB69,
          {100: Color(0xFF2DBB69)},
        ),
        warning: const MaterialColor(
          0xFFF19228,
          {100: Color(0xFFF19228)},
        ),
        error: const MaterialColor(
          0xFFFF4444,
          {100: Color(0xFFFF4444)},
        ),
      );

  factory AppColor.dark() => AppColor(
        primary: const MaterialColor(
          0xff1d2439,
          {100: Color(0xff1d2439)},
        ),
        primaryText: const MaterialColor(
          0xfff2ddcc,
          {100: Color(0xfff2ddcc)},
        ),
        primaryTextButton: const MaterialColor(
          0xfff2ddcc,
          {100: Color(0xfff2ddcc)},
        ),
        background: const MaterialColor(
          0xff0c101c,
          {100: Color(0xff0c101c)},
        ),
        success: const MaterialColor(
          0xFF2DBB69,
          {100: Color(0xFF2DBB69)},
        ),
        warning: const MaterialColor(
          0xFFF19228,
          {100: Color(0xFFF19228)},
        ),
        error: const MaterialColor(
          0xFFFF4444,
          {100: Color(0xFFFF4444)},
        ),
      );

  final MaterialColor primary;
  final MaterialColor primaryText;
  final MaterialColor primaryTextButton;
  final MaterialColor background;
  final MaterialColor success;
  final MaterialColor warning;
  final MaterialColor error;
}

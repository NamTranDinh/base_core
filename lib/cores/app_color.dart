import 'package:flutter/material.dart';

class AppColorTheme {
  AppColorTheme({
    required this.primary,
    required this.primaryText,
    required this.background,
    required this.success,
    required this.warning,
    required this.error,
  });

  factory AppColorTheme.light() => AppColorTheme(
        primary: const MaterialColor(
          0xFF1A657A,
          {100: Color(0xFF1A657A)},
        ),
        primaryText: const MaterialColor(
          0xFF252629,
          {100: Color(0xFF252629)},
        ),
        background: const MaterialColor(
          0xFFFFFFFF,
          {100: Color(0xFFFFFFFF)},
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

  factory AppColorTheme.dark() => AppColorTheme(
        primary: const MaterialColor(
          0xFF1A657A,
          {100: Color(0xFF1A657A)},
        ),
        primaryText: const MaterialColor(
          0xFFFFFFFF,
          {100: Color(0xFFFFFFFF)},
        ),
        background: const MaterialColor(
          0xFF252629,
          {100: Color(0xFF252629)},
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
  final MaterialColor background;
  final MaterialColor success;
  final MaterialColor warning;
  final MaterialColor error;
}

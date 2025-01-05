import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

extension ContextExtension on BuildContext {

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  void get showLoading => loaderOverlay.show();

  void get hideLoading => loaderOverlay.hide();

  bool get visibleLoading => loaderOverlay.visible;

  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

extension StringExtension on String {
  String get name => replaceAll(RegExp('/'), '');

  bool get isNullOrEmpty => this == '' || isEmpty;
}

extension IntExtension on int? {
  bool get isNullOrEmpty => this == -1 || this == null;
}

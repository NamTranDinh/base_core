import 'package:base_core/commons/app_components/loadings/overlay_manager.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

extension ContextExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  bool get visibleLoading => loaderOverlay.visible;

  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }

  void showLoading() => OverlayManager.showEntry(this, 'loading');

  void hideLoading() => OverlayManager.removeEntry('loading');

  void showPopup() => OverlayManager.showEntry(this, 'popup');

  void hidePopup() => OverlayManager.removeEntry('popup');
}

extension StringExtension on String {
  String get name => replaceAll(RegExp('/'), '');

  bool get isNullOrEmpty => this == '' || isEmpty;
}

extension IntExtension on int? {
  bool get isNullOrEmpty => this == -1 || this == null;
}

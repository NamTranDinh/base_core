import 'package:base_core/commons/app_components/alerts/alert_overlay.dart';
import 'package:base_core/commons/app_components/loadings/loading_overlay.dart';
import 'package:base_core/cores/app_constant.dart';
import 'package:base_core/cores/app_overlay_manager.dart';
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

  void showLoading() => AppOverlayManager.showEntry(
        this,
        OverlayEntry(builder: (context) => const LoadingOverlay()),
      );

  void hideLoading() => AppOverlayManager.removeEntry(
        AppConstant.appLoadingKey,
      );

  void showAppAlert() => AppOverlayManager.showEntry(
        this,
        OverlayEntry(builder: (context) => const AlertOverlay()),
      );
}

extension StringExtension on String {
  String get name => replaceAll(RegExp('/'), '');

  bool get isNullOrEmpty => this == '' || isEmpty;
}

extension IntExtension on int? {
  bool get isNullOrEmpty => this == -1 || this == null;
}

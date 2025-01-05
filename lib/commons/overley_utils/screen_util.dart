import 'package:base_core/cores/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const mobileWidth = 480.0;
const tabletWidth = 1024.0;

class ScreenUtil extends StatelessWidget {
  const ScreenUtil({
    super.key,
    required this.mobile,
    required this.desktop,
  });

  final Widget mobile;
  final Widget desktop;

  static bool isMobile(BuildContext context) {
    return context.screenWidth <= mobileWidth;
  }

  static bool isTablet(BuildContext context) {
    return context.screenWidth <= tabletWidth &&
        context.screenWidth > mobileWidth;
  }

  static bool isDesktop(BuildContext context) {
    return context.screenWidth > tabletWidth;
  }

  static bool isScaling(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio > 1.0;
  }

  @override
  Widget build(BuildContext context) {
    if (ScreenUtil.isMobile(context)) {
      lockScreenOrientation();
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= mobileWidth) {
          return mobile;
        } else {
          return desktop;
        }
      },
    );
  }

  void lockScreenOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void unlockScreenOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static Orientation getOrientation(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Orientation.portrait;
    } else {
      return Orientation.landscape;
    }
  }
}

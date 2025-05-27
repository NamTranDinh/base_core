import 'package:base_core/cores/app_model.dart';
import 'package:flutter/material.dart';

class AppDarkColors extends BaseColors {
  factory AppDarkColors() {
    return _instance;
  }

  AppDarkColors._init();

  static final AppDarkColors _instance = AppDarkColors._init();

  @override
  MaterialColor get primary {
    return const MaterialColor(0xFF1A657A, {});
  }

  @override
  MaterialColor get success {
    return const MaterialColor(0xFF2DBB69, {});
  }

  @override
  MaterialColor get warning {
    return const MaterialColor(0xFFF19228, {});
  }

  @override
  MaterialColor get error {
    return const MaterialColor(0xFFFF4444, {});
  }
}

import 'package:base_core/configs/system.dart';
import 'package:base_core/cores/app_theme.dart';
import 'package:base_core/di/di.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState.init());

  void initAppTheme(BuildContext themeContent) {
    switch (state.themeMode) {
      case ThemeMode.system:
        emit(state.copyWith(appThemeData: AppThemeData.system(themeContent)));
      case ThemeMode.light:
        emit(state.copyWith(appThemeData: AppThemeData.light()));
      case ThemeMode.dark:
        emit(state.copyWith(appThemeData: AppThemeData.dark()));
    }
  }
}

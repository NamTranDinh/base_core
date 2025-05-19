import 'package:base_core/configs/system.dart';
import 'package:base_core/di/di.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState.init());

  void initAppTheme({ThemeMode? themeMode}) {
    emit(state.copyWith(themeMode: themeMode ?? ThemeMode.system));
  }
}

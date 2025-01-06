part of 'app_cubit.dart';

@immutable
class AppState extends Equatable {
  const AppState({
    required this.themeMode,
    required this.appThemeData,
    this.locale,
  });

  factory AppState.init() {
    return AppState(
      locale: getIt<LanguageManager>().enLocale,
      themeMode: ThemeMode.system,
      appThemeData: AppThemeData.light(),
    );
  }

  final ThemeMode themeMode;
  final AppThemeData appThemeData;
  final Locale? locale;

  AppState copyWith({
    ThemeMode? themeMode,
    AppThemeData? appThemeData,
    Locale? locale,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      appThemeData: appThemeData ?? this.appThemeData,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        locale,
      ];
}

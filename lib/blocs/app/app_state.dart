part of 'app_cubit.dart';

@immutable
class AppState extends Equatable {
  const AppState({
    required this.themeMode,
    this.locale,
  });

  factory AppState.init() {
    return const AppState(
      locale: LanguageManager.enLocale,
      themeMode: ThemeMode.system,
    );
  }

  final ThemeMode themeMode;
  final Locale? locale;

  AppState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        locale,
      ];
}

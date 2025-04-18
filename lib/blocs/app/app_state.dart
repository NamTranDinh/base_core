part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    required this.themeMode,
  });

  factory AppState.init() {
    return const AppState(themeMode: ThemeMode.system);
  }

  final ThemeMode themeMode;

  @override
  List<Object?> get props => [themeMode];
}

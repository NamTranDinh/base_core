import "package:base_core/commons/app_components/widgets/page_not_found.dart";
import "package:base_core/cores/dependency_injection/app_data.dart";
import "package:base_core/cores/dependency_injection/di.dart";
import "package:base_core/cores/themes/app_color.dart";
import "package:base_core/cores/themes/app_theme.dart";
import "package:base_core/features/app/presentation/bloc/app_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  late AppCubit _appCubit;

  @override
  void initState() {
    _appCubit = getIt<AppCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>.value(value: _appCubit..initAppTheme()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext context, AppState state) {
          return MaterialApp.router(
            locale: state.locale,
            theme: setTheme(
              AppColor.light(),
              brightness: Brightness.light,
            ),
            darkTheme: setTheme(
              AppColor.dark(),
              brightness: Brightness.dark,
            ),
            themeMode: state.themeMode,
            routerConfig: AppData.of(context).router.config(),
            debugShowCheckedModeBanner: false,
            builder: (BuildContext context, Widget? child) {
              return Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (context) => child ?? const PageNotFound(),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

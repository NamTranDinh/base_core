import 'package:base_core/blocs/app/app_cubit.dart';
import 'package:base_core/commons/app_components/loadings/loading_overlay.dart';
import 'package:base_core/commons/app_components/widgets/page_not_found.dart';
import 'package:base_core/cores/app_color.dart';
import 'package:base_core/cores/app_theme.dart';
import 'package:base_core/di/app_data.dart';
import 'package:base_core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

final navigatorKey = GlobalKey<NavigatorState>();

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
        BlocProvider.value(value: _appCubit..initAppTheme()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp.router(
            locale: state.locale,
            theme: AppThemeData.setTheme(
              AppColor.light(),
              brightness: Brightness.light,
            ),
            darkTheme: AppThemeData.setTheme(
              AppColor.dark(),
              brightness: Brightness.dark,
            ),
            themeMode: state.themeMode,
            routerConfig: AppData.of(context).router.config(),
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return LoaderOverlay(
                overlayWidgetBuilder: (_) {
                  return const Material(
                    color: Colors.transparent,
                    child: LoadingOverlay(),
                  );
                },
                child: Material(child: child ?? const PageNotFound()),
              );
            },
          );
        },
      ),
    );
  }
}

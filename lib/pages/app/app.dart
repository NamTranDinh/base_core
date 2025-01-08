import 'package:base_core/blocs/app/app_cubit.dart';
import 'package:base_core/commons/app_components/loadings/loading_overlay.dart';
import 'package:base_core/commons/app_components/widgets/page_not_found.dart';
import 'package:base_core/cores/app_theme.dart';
import 'package:base_core/di/app_data.dart';
import 'package:base_core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AppCubit>()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MyAppTheme(
            appThemeData: AppThemeData.light(),
            child: MaterialApp.router(
              locale: state.locale,
              theme: state.appThemeData.themeData,
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
            ),
          );
        },
      ),
    );
  }
}

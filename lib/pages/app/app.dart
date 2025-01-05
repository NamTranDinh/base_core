import 'package:base_core/blocs/app/app_cubit.dart';
import 'package:base_core/commons/app_components/loadings/loading_overlay.dart';
import 'package:base_core/commons/app_components/widgets/page_not_found.dart';
import 'package:base_core/configs/system.dart';
import 'package:base_core/cores/app_theme.dart';
import 'package:base_core/di.dart';
import 'package:base_core/routes/app_router.dart';
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
      child: MaterialApp.router(
        routerConfig: getIt<AppRouter>().config(),
        locale: LanguageManager().enLocale,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightAppTheme(context),
        darkTheme: AppTheme.darkAppTheme(context),
        themeMode: ThemeMode.light,
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
  }
}

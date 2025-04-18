import 'package:base_core/blocs/app/app_cubit.dart';
import 'package:base_core/commons/app_components/loadings/loading_overlay.dart';
import 'package:base_core/commons/app_components/widgets/page_not_found.dart';
import 'package:base_core/cores/app_theme.dart';
import 'package:base_core/di.dart';
import 'package:base_core/routes/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AppCubit>()),
      ],
      child: MaterialApp.router(
        title: 'Base Core',
        routerConfig: AppRouter.getRouter,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightAppTheme(context),
        darkTheme: AppTheme.darkAppTheme(context),
        builder: (context, child) {
          return LoaderOverlay(
            overlayWidgetBuilder: (_) {
              return const Material(
                color: Colors.transparent,
                child: LoadingOverlay(),
              );
            },
            child: child ?? const PageNotFound(),
          );
        },
      ),
    );
  }
}

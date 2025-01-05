import 'package:auto_route/auto_route.dart';
import 'package:base_core/di.dart';
import 'package:base_core/routes/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: getIt<AppRouter>().navigatorKey.currentContext!,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Dialog(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    Text('Loading'),
                  ],
                ),
              );
            },
          );
        },
        child: const Text('Back page'),
      ),
    );
  }
}

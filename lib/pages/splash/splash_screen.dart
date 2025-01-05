import 'package:auto_route/auto_route.dart';
import 'package:base_core/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          AutoRouter.of(context).push(const HomeRouteRoute());
        },
        child: const Text('Next page'),
      ),
    );
  }
}

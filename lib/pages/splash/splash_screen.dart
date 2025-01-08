import 'package:auto_route/auto_route.dart';
import 'package:base_core/di/app_data.dart';
import 'package:base_core/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () => context.pushRoute(const HomeRouteRoute()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppData(context).colorTheme.background,
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

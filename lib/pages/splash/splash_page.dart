import 'package:auto_route/auto_route.dart';
import 'package:base_core/di/app_data.dart';
import 'package:base_core/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'SplashRoute')
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentContext = context;
      Future.delayed(const Duration(seconds: 1), () {
        if (currentContext.mounted) {
          currentContext.router.replaceAll([const HomePageRouter()]);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppData(context).color.background,
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

import 'package:base_core/cores/app_color.dart';
import 'package:base_core/routes/app_route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            context.goNamed(AppRouteName.home.path);
          },
          child: Container(
            alignment: Alignment.center,
            width: 200,
            height: 200,
            color: AppColors.of(context).primary,
          ),
        ),
      ),
    );
  }
}

import 'package:base_core/cores/app_color.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 200,
        color: AppColors.of(context).primary,
      ),
    );
  }
}

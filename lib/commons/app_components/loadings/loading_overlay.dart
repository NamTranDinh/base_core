import 'package:base_core/commons/app_components/loadings/loading.dart';
import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Loading.medium());
  }
}

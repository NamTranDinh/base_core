import "package:base_core/commons/app_components/loadings/loading_stack.dart";
import "package:flutter/material.dart";

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: const Color(0x80000000)),
        Center(child: Center(child: Loading.medium())),
      ],
    );
  }
}

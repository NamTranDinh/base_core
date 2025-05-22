import "package:base_core/commons/app_components/loadings/loading.dart";
import "package:flutter/material.dart";

OverlayEntry loadingOverlay = OverlayEntry(
  builder: (context) => Stack(
    children: [
      Container(color: const Color(0x80000000)),
      Center(child: Center(child: Loading.medium())),
    ],
  ),
);

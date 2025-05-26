import 'package:flutter/material.dart';

class AppOverlayManager {
  static void showEntry(BuildContext context, OverlayEntry entry) {
    Overlay.of(context).insert(entry);
    debugPrint("👀 Displaying entry with key: ${entry.hashCode}");

    Future.delayed(const Duration(seconds: 3), () {
      entry.remove();
      debugPrint("🗑️ Removed entry with key: ${entry.hashCode}");
    });
  }

  static void removeEntry(String key) {}
}

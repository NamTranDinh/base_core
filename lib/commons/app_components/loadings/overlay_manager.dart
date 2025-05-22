import 'package:flutter/material.dart';

class OverlayManager {
  static final Map<String, OverlayEntry> _entries = {};

  static void addEntry(String key, OverlayEntry entry) {
    _entries[key] = entry;
  }

  static void showEntry(BuildContext context, String key) {
    if (_entries.containsKey(key)) {
      Overlay.of(context).insert(_entries[key]!);
    }
  }

  static void removeEntry(String key) {
    _entries[key]?.remove();
  }
}

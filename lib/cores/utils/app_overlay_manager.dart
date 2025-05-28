import 'dart:collection';
import 'package:flutter/material.dart';

class AppOverlayManager {
  // Singleton Instance
  AppOverlayManager._privateConstructor();

  static final AppOverlayManager instance =
      AppOverlayManager._privateConstructor();

  final Queue<OverlayEntry> _overlayQueue = Queue<OverlayEntry>();

  /// Show a temporary [OverlayEntry] and remove it after [duration].
  void showTemporaryEntry(
    BuildContext context,
    OverlayEntry entry, {
    Duration duration = const Duration(seconds: 3),
  }) {
    _insertEntry(context, entry);
    debugPrint("👀 Displaying temporary overlay entry: ${entry.hashCode}");

    Future.delayed(duration, () => removeEntry(entry));
  }

  /// Show a persistent overlay and store it in the queue.
  void showPersistentEntry(BuildContext context, OverlayEntry entry) {
    _overlayQueue.addLast(entry);
    _insertEntry(context, entry);
  }

  /// Hide the most recent persistent overlay.
  void hidePersistentEntry() {
    if (_overlayQueue.isNotEmpty) {
      final OverlayEntry entry = _overlayQueue.removeLast();
      removeEntry(entry);
    } else {
      debugPrint("⚠️ No active overlays to hide.");
    }
  }

  /// Remove an overlay entry if it is still mounted.
  void removeEntry(OverlayEntry entry) {
    if (entry.mounted) {
      entry.remove();
      debugPrint("🗑️ Removed overlay entry: ${entry.hashCode}");
    } else {
      debugPrint("⚠️ Overlay entry was already removed.");
    }
  }

  /// Insert an overlay entry safely.
  void _insertEntry(BuildContext context, OverlayEntry entry) {
    try {
      Overlay.of(context).insert(entry);
    } on Exception catch (e) {
      debugPrint("❌ Error inserting overlay: $e");
    }
  }

  /// Remove all overlay entries (useful for cleanup).
  void clearAllEntries() {
    while (_overlayQueue.isNotEmpty) {
      hidePersistentEntry();
    }
    debugPrint("✅ All overlay entries cleared.");
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

class UserActivityDetector extends StatefulWidget {
  const UserActivityDetector({
    super.key,
    required this.child,
    this.durationNotInteraction,
    required this.onTimeout,
  });

  final Widget child;
  final Duration? durationNotInteraction;
  final VoidCallback onTimeout;

  @override
  State<UserActivityDetector> createState() => _UserActivityDetectorState();
}

class _UserActivityDetectorState extends State<UserActivityDetector> {
  Timer? _timer;
  late Duration duration;

  @override
  void initState() {
    super.initState();
    duration = widget.durationNotInteraction ?? const Duration(seconds: 5);
    _resetTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer(duration, widget.onTimeout);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _resetTimer,
      onPanDown: (details) => _resetTimer(),
      onHorizontalDragEnd: (details) => _resetTimer(),
      onVerticalDragEnd: (details) => _resetTimer(),
      child: widget.child,
    );
  }
}

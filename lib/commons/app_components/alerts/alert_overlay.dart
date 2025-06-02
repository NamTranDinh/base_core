import "package:flutter/material.dart";

enum AlertType { success, warning, failure }

class AppAlertOverlay extends StatelessWidget {
  const AppAlertOverlay({required this.type, super.key, this.message});

  factory AppAlertOverlay.success({String? message}) {
    return AppAlertOverlay(message: message, type: AlertType.success);
  }

  factory AppAlertOverlay.warning({String? message}) {
    return AppAlertOverlay(message: message, type: AlertType.warning);
  }

  factory AppAlertOverlay.failure({String? message}) {
    return AppAlertOverlay(message: message, type: AlertType.failure);
  }

  final String? message;
  final AlertType type;

  @override
  Widget build(BuildContext context) {
    return _AlertOverlay(
      type: type,
      message: message,
    );
  }
}

class _AlertOverlay extends StatefulWidget {
  const _AlertOverlay({required this.type, this.message});

  final String? message;
  final AlertType type;

  @override
  State<_AlertOverlay> createState() => _AlertOverlayState();
}

class _AlertOverlayState extends State<_AlertOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Material(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                width: MediaQuery.of(context).size.width,
                color: _getBackgroundColor(widget.type),
                child: SafeArea(
                  bottom: false,
                  child: Text(
                    widget.message ?? 'This is a message from the app',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getBackgroundColor(AlertType type) {
    return switch (type) {
      AlertType.success => Colors.green,
      AlertType.warning => Colors.yellow,
      AlertType.failure => Colors.red,
    };
  }
}

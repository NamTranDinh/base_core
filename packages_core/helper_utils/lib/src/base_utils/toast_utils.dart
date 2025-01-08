import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef ToastPositionMapping = Widget? Function(
  Widget child,
  ToastGravity? gravity,
);

enum Toast { LENGTH_SHORT, LENGTH_LONG }

enum ToastGravity {
  TOP,
  BOTTOM,
  CENTER,
  TOP_LEFT,
  TOP_RIGHT,
  BOTTOM_LEFT,
  BOTTOM_RIGHT,
  CENTER_LEFT,
  CENTER_RIGHT,
  SNACKBAR,
  NONE
}

class FlutterToast {
  static const MethodChannel _channel =
      MethodChannel('PonnamKarthik/fluttertoast');

  static Future<bool?> cancel() async {
    final res = await _channel.invokeMethod('cancel');
    return res;
  }

  static Future<bool?> showToast({
    required String msg,
    Toast? toastLength,
    int timeInSecForIosWeb = 1,
    double? fontSize,
    String? fontAsset,
    ToastGravity? gravity,
    Color? backgroundColor,
    Color? textColor,
    bool webShowClose = false,
    webBgColor = 'linear-gradient(to right, #00b09b, #96c93d)',
    webPosition = 'right',
  }) async {
    var toast = 'short';
    if (toastLength == Toast.LENGTH_LONG) {
      toast = 'long';
    }

    var gravityToast = 'bottom';
    if (gravity == ToastGravity.TOP) {
      gravityToast = 'top';
    } else if (gravity == ToastGravity.CENTER) {
      gravityToast = 'center';
    } else {
      gravityToast = 'bottom';
    }

    if (backgroundColor == null && Platform.isIOS) {
      backgroundColor = Colors.black;
    }
    if (textColor == null && Platform.isIOS) {
      textColor = Colors.white;
    }
    final params = <String, dynamic>{
      'msg': msg,
      'length': toast,
      'time': timeInSecForIosWeb,
      'gravity': gravityToast,
      'bgcolor': backgroundColor?.value,
      'iosBgcolor': backgroundColor?.value,
      'textcolor': textColor?.value,
      'iosTextcolor': textColor?.value,
      'fontSize': fontSize,
      'fontAsset': fontAsset,
      'webShowClose': webShowClose,
      'webBgColor': webBgColor,
      'webPosition': webPosition,
    };

    final res = await _channel.invokeMethod('showToast', params);
    return res;
  }
}

typedef PositionedToastBuilder = Widget Function(
  BuildContext context,
  Widget child,
  ToastGravity? gravity,
);

class FToast {
  factory FToast() {
    return _instance;
  }

  FToast._internal();

  BuildContext? context;

  static final FToast _instance = FToast._internal();

  FToast init(BuildContext context) {
    _instance.context = context;
    return _instance;
  }

  OverlayEntry? _entry;
  final List<_ToastEntry> _overlayQueue = [];
  Timer? _timer;
  Timer? _fadeTimer;

  void _showOverlay() {
    if (_overlayQueue.isEmpty) {
      _entry = null;
      return;
    }
    if (context == null) {
      removeQueuedCustomToasts();
      throw Exception(
          'Error: Context is null, Please call init(context) before showing toast.');
    }

    OverlayState? overlay;
    try {
      overlay = Overlay.of(context!);
    } on Exception {
      removeQueuedCustomToasts();
      throw Exception("""Error: Overlay is null. 
      Please don't use top of the widget tree context (such as Navigator or MaterialApp) or 
      create overlay manually in MaterialApp builder.
      More information 
        - https://github.com/ponnamkarthik/FlutterToast/issues/393
        - https://github.com/ponnamkarthik/FlutterToast/issues/234""");
    }

    final toastEntry = _overlayQueue.removeAt(0);
    _entry = toastEntry.entry;
    overlay.insert(_entry!);

    _timer = Timer(toastEntry.duration, () {
      _fadeTimer = Timer(toastEntry.fadeDuration, removeCustomToast);
    });
  }

  void removeCustomToast() {
    _timer?.cancel();
    _fadeTimer?.cancel();
    _timer = null;
    _fadeTimer = null;
    _entry?.remove();
    _entry = null;
    _showOverlay();
  }

  void removeQueuedCustomToasts() {
    _timer?.cancel();
    _fadeTimer?.cancel();
    _timer = null;
    _fadeTimer = null;
    _overlayQueue.clear();
    _entry?.remove();
    _entry = null;
  }

  void showToast({
    required Widget child,
    PositionedToastBuilder? positionedToastBuilder,
    Duration toastDuration = const Duration(seconds: 2),
    ToastGravity? gravity,
    Duration fadeDuration = const Duration(milliseconds: 350),
    bool ignorePointer = false,
    bool isDismissible = false,
  }) {
    if (context == null) {
      throw Exception(
          'Error: Context is null, Please call init(context) before showing toast.');
    }
    final Widget newChild = _ToastStateFul(
      child,
      toastDuration,
      fadeDuration,
      ignorePointer,
      !isDismissible ? null : removeCustomToast,
    );

    if (gravity == ToastGravity.BOTTOM) {
      if (MediaQuery.of(context!).viewInsets.bottom != 0) {
        gravity = ToastGravity.CENTER;
      }
    }

    final newEntry = OverlayEntry(
      builder: (context) {
        if (positionedToastBuilder != null) {
          return positionedToastBuilder(context, newChild, gravity);
        }

        return _getPositionWidgetBasedOnGravity(newChild, gravity);
      },
    );
    _overlayQueue.add(
      _ToastEntry(
        entry: newEntry,
        duration: toastDuration,
        fadeDuration: fadeDuration,
      ),
    );
    if (_timer == null) _showOverlay();
  }

  Positioned _getPositionWidgetBasedOnGravity(
    Widget child,
    ToastGravity? gravity,
  ) {
    switch (gravity) {
      case ToastGravity.TOP:
        return Positioned(top: 0, left: 0, right: 0, child: child);
      case ToastGravity.TOP_LEFT:
        return Positioned(top: 0, left: 0, child: child);
      case ToastGravity.TOP_RIGHT:
        return Positioned(top: 0, right: 0, child: child);
      case ToastGravity.CENTER:
        return Positioned(top: 0, bottom: 0, left: 0, right: 0, child: child);
      case ToastGravity.CENTER_LEFT:
        return Positioned(top: 0, bottom: 0, left: 0, child: child);
      case ToastGravity.CENTER_RIGHT:
        return Positioned(top: 0, bottom: 0, right: 0, child: child);
      case ToastGravity.BOTTOM_LEFT:
        return Positioned(bottom: 0, left: 0, child: child);
      case ToastGravity.BOTTOM_RIGHT:
        return Positioned(bottom: 0, right: 0, child: child);
      case ToastGravity.SNACKBAR:
        return Positioned(bottom: 0, left: 0, right: 0, child: child);
      case ToastGravity.NONE:
        return Positioned.fill(child: child);
      case ToastGravity.BOTTOM:
      default:
        return Positioned(bottom: 0, left: 16, right: 16, child: child);
    }
  }
}

// ignore: non_constant_identifier_names
TransitionBuilder FToastBuilder() {
  return (context, child) {
    return _FToastHolder(
      child: child!,
    );
  };
}

class _FToastHolder extends StatelessWidget {
  const _FToastHolder({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: <OverlayEntry>[
        OverlayEntry(builder: (BuildContext ctx) => child),
      ],
    );
  }
}

class _ToastEntry {
  _ToastEntry({
    required this.entry,
    required this.duration,
    required this.fadeDuration,
  });

  final OverlayEntry entry;
  final Duration duration;
  final Duration fadeDuration;
}

class _ToastStateFul extends StatefulWidget {
  const _ToastStateFul(
    this.child,
    this.duration,
    this.fadeDuration,
    this.ignorePointer,
    this.onDismiss, {
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Duration fadeDuration;
  final bool ignorePointer;
  final VoidCallback? onDismiss;

  @override
  ToastStateFulState createState() => ToastStateFulState();
}

class ToastStateFulState extends State<_ToastStateFul>
    with SingleTickerProviderStateMixin {
  void showIt() {
    _animationController!.forward();
  }

  void hideIt() {
    _animationController!.reverse();
    _timer?.cancel();
  }

  AnimationController? _animationController;
  late Animation _fadeAnimation;

  Timer? _timer;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.fadeDuration,
    );
    _fadeAnimation =
        CurvedAnimation(parent: _animationController!, curve: Curves.easeIn);
    super.initState();

    showIt();
    _timer = Timer(widget.duration, hideIt);
  }

  @override
  void deactivate() {
    _timer?.cancel();
    _animationController!.stop();
    super.deactivate();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onDismiss == null ? null : () => widget.onDismiss!(),
      behavior: HitTestBehavior.translucent,
      child: SafeArea(
        child: IgnorePointer(
          ignoring: widget.ignorePointer,
          child: FadeTransition(
            opacity: _fadeAnimation as Animation<double>,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

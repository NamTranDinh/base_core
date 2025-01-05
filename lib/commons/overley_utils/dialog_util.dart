import 'package:flutter/material.dart';

class DialogUtil {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool? barrierDismissible,
  }) async {
    return showDialog<T?>(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          contentPadding: EdgeInsets.zero,
          scrollable: true,
          content: child,
        );
      },
    );
  }
}

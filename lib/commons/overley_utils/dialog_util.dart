import "package:base_core/cores/app_dimens.dart";
import "package:flutter/material.dart";

class DialogUtil {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool? barrierDismissible,
  }) {
    return showDialog<T?>(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimens.appBorderRadius),
            ),
          ),
          contentPadding: EdgeInsets.zero,
          scrollable: true,
          content: Padding(
            padding: const EdgeInsets.all(AppDimens.appPadding),
            child: child,
          ),
        );
      },
    );
  }
}

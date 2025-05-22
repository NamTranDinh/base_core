import "package:core_utils/core_utils.dart";
import "package:flutter/material.dart";
import "package:toastification/toastification.dart";

class ToastUtil {
  static void showSnackBar({
    required BuildContext context,
    required Widget title,
    required void Function(ToastificationItem item) onTap,
    Color? backgroundColor,
    Alignment? alignment,
  }) {
    toastification.show(
      context: context,
      title: title,
      showIcon: false,
      dragToClose: true,
      closeOnClick: true,
      showProgressBar: false,
      alignment: alignment,
      borderSide: BorderSide.none,
      backgroundColor: backgroundColor?.withAlpha(235),
      style: ToastificationStyle.flat,
      callbacks: ToastificationCallbacks(onTap: onTap),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      animationDuration: const Duration(milliseconds: 250),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  static void showToast({
    required BuildContext context,
    Widget? title,
    Color? backgroundColor,
    ToastGravity? gravity,
  }) {
    final toast = FToast().init(context);
    toast.showToast(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: title ?? const SizedBox.shrink()),
            InkWell(
              onTap: toast.removeCustomToast,
              child: const Icon(Icons.close),
            ),
          ],
        ),
      ),
      gravity: gravity ?? ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3),
    );
  }
}

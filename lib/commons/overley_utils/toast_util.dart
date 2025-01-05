import 'package:flutter/material.dart';
import 'package:helper_utils/helper_utils.dart';
import 'package:toastification/toastification.dart';

class ToastUtil {
  static void showToast({
    required BuildContext context,
    Widget? title,
    Color? backgroundColor,
    Alignment? alignment,
    required void Function(ToastificationItem) onTap,
  }) {
    toastification.show(
      callbacks: ToastificationCallbacks(onTap: onTap),
      showIcon: false,
      context: context,
      title: title,
      closeOnClick: true,
      margin: const EdgeInsets.only(right: 16, bottom: 8),
      animationDuration: const Duration(milliseconds: 350),
      autoCloseDuration: const Duration(seconds: 5),
      showProgressBar: false,
      backgroundColor: backgroundColor,
      borderSide: BorderSide.none,
      alignment: alignment,
    );
  }

  static void show({
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
        width: 350,
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
      gravity: gravity ?? ToastGravity.TOP_RIGHT,
      toastDuration: const Duration(seconds: 5),
    );
  }
}

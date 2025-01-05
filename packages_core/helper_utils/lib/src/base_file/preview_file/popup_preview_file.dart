import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helper_utils/src/base_file/preview_file/widgets/_overlay_header_close.dart';
import 'package:helper_utils/src/base_file/preview_file/widgets/_preview_image.dart';
import 'package:helper_utils/src/base_file/preview_file/widgets/_preview_video.dart';
import 'package:url_launcher/url_launcher.dart';

class PopupPreviewFile {
  static Future<void> previewImage({
    required BuildContext context,
    required File? file,
  }) {
    return showGeneralDialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(.8),
      context: context,
      pageBuilder: (_, __, ___) => OverlayHeaderClose(
        child: PreviewImage(file: file ?? File('')),
      ),
    );
  }

  static Future<void> previewVideo({
    required BuildContext context,
    required File? file,
  }) {
    return showGeneralDialog(
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(.8),
      context: context,
      pageBuilder: (_, __, ___) => PreviewVideo(
        file: file ?? File(''),
      ),
    );
  }

  static Future<void> launchURL(String url) async {
    bool success = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!success) {}
  }
}

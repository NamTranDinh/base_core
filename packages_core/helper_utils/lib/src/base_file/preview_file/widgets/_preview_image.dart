import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helper_utils/src/base_helper.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

class PreviewImage extends StatelessWidget {
  const PreviewImage({super.key, required this.file});

  final File file;

  @override
  Widget build(BuildContext context) {
    return AppHelper.isLocalPath(file.path).name == DataSourceType.file.name
        ? _local(context)
        : _network(context);
  }

  Widget _network(BuildContext context) {
    PhotoViewScaleStateController scaleStateController;
    scaleStateController = PhotoViewScaleStateController();
    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PhotoView(
          scaleStateController: scaleStateController,
          imageProvider: NetworkImage(file.path),
          initialScale: PhotoViewComputedScale.contained,
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2.0,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }

  Widget _local(BuildContext context) => Material(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: PhotoView(
            imageProvider: FileImage(file),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2.0,
            filterQuality: FilterQuality.high,
          ),
        ),
      );
}

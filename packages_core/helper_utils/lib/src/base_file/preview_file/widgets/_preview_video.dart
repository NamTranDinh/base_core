import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper_utils/src/base_file/preview_file/cubit/video_cubit/video_cubit.dart';
import 'package:helper_utils/src/base_file/preview_file/widgets/_overlay_control_video.dart';
import 'package:helper_utils/src/base_file/preview_file/widgets/_overlay_header_close.dart';
import 'package:video_player/video_player.dart';

class PreviewVideo extends StatelessWidget {
  const PreviewVideo({super.key, required this.file});

  final File file;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          VideoCubit(videoUrl: file.path, autoPlay: true, autoReplay: true),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<VideoCubit, VideoState>(
          buildWhen: (previous, current) {
            return previous.videoStatus != current.videoStatus &&
                current.videoStatus == VideoStatus.initialized;
          },
          builder: (context, videoState) {
            if (videoState.videoStatus == VideoStatus.initializing) {
              return const Center(child: CircularProgressIndicator());
            }
            if (videoState.videoStatus == VideoStatus.initialized) {
              return BlocBuilder<VideoCubit, VideoState>(
                buildWhen: (previous, current) =>
                    previous.isFullScreen != current.isFullScreen,
                builder: (context, state) {
                  return OverlayHeaderClose(
                    isShowIconBack: !state.isFullScreen,
                    child: OverlayControlVideo(
                      videoPlayer:
                          VideoPlayer(videoState.videoPlayerController),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text(
                'Lỗi tải dữ liệu !',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}

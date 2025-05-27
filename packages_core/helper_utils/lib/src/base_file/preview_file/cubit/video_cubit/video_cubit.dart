import 'dart:developer';
import 'dart:io';

import 'package:helper_utils/helper_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit({
    required String videoUrl,
    bool autoPlay = false,
    bool autoReplay = false,
  }) : super(
          VideoState.init(videoUrl: videoUrl),
        ) {
    // init video controller
    state.videoPlayerController.initialize().then(
      (_) {
        emit(
          state.copyWith(
            videoStatus: VideoStatus.initialized,
            isInteraction: true,
            duration: state.videoPlayerController.value.duration,
            isAutoPlay: autoPlay,
            isAutoReplay: autoReplay,
            isFullScreen: state.isFullScreen,
          ),
        );
        state.videoPlayerController.setLooping(autoReplay);
        if (autoPlay) playVideo();
      },
    ).onError((error, stackTrace) {
      emit(state.copyWith(videoStatus: VideoStatus.error));
      log('[Video Player] $error');
      log('[Video Player] $stackTrace');
    });

    // add video listener
    state.videoPlayerController.addListener(_listener);
  }

  void initPlay() {
    _playVideo();
    emit(
      state.copyWith(
        videoStatus: VideoStatus.playing,
      ),
    );
  }

  /// ////////////////////////////////////////////////////////////////////////////////////////////////
  /// control video
  /// ////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> playVideo() async {
    _playVideo();
    emit(
      state.copyWith(isPlaying: true, videoStatus: VideoStatus.playing),
    );
  }

  Future<void> pauseVideo() async {
    _pauseVideo();
    emit(
      state.copyWith(isPlaying: false, videoStatus: VideoStatus.paused),
    );
  }

  void togglePlay() => state.isPlaying ? pauseVideo() : playVideo();

  /// ////////////////////////////////////////////////////////////////////////////////////////////////
  /// seek video
  /// ////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> seekForward({int? second}) async {
    final position = _position();
    final newPosition = position + Duration(seconds: second ?? 10);
    _seekTo(position: newPosition);
    emit(
      state.copyWith(
        position: newPosition,
        videoStatus: VideoStatus.playing,
      ),
    );
  }

  Future<void> seekBackward({int? second}) async {
    final position = _position();
    final newPosition = position - Duration(seconds: second ?? 10);
    _seekTo(position: newPosition);
    emit(
      state.copyWith(
        position: newPosition,
        videoStatus: VideoStatus.playing,
      ),
    );
  }

  Future<void> seekToDuration(Duration position) async =>
      _seekTo(position: position);

  Future<void> seekToDurationNotifier(Duration position) async {
    emit(
      state.copyWith(isPlaying: true, position: position),
    );
  }

  void toggleFullScreen() =>
      state.isFullScreen ? exitFullScreen() : fullScreen();

  Future<void> fullScreen() async {
    Size size = state.videoPlayerController.value.size;
    if (size.width > size.height) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: []);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
    emit(state.copyWith(isFullScreen: true));
  }

  Future<void> exitFullScreen() async {
    emit(state.copyWith(isFullScreen: false));
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// ////////////////////////////////////////////////////////////////////////////////////////////////
  /// helper func
  /// ////////////////////////////////////////////////////////////////////////////////////////////////
  void _listener() {
    emit(
      state.copyWith(
        isPlaying: state.videoPlayerController.value.isPlaying,
        position: state.videoPlayerController.value.position,
        duration: state.videoPlayerController.value.duration,
        videoStatus: state.videoStatus,
        isFullScreen: state.isFullScreen,
      ),
    );

    if (state.position.inMilliseconds == state.duration.inMilliseconds) {
      _seekTo(position: Duration.zero);
      emit(
        state.copyWith(
          position: Duration.zero,
          videoStatus: VideoStatus.completed,
        ),
      );
      state.isAutoPlay ? _playVideo() : _pauseVideo();
    }
  }

  void _playVideo() => state.videoPlayerController.play();

  void _pauseVideo() => state.videoPlayerController.pause();

  void _seekTo({required Duration position}) =>
      state.videoPlayerController.seekTo(position);

  Duration _position() => state.videoPlayerController.value.position;

  bool _isPlaying() => state.videoPlayerController.value.isPlaying;

  @override
  Future<void> close() {
    exitFullScreen();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    state.videoPlayerController.dispose();
    state.videoPlayerController.removeListener(_listener);
    return super.close();
  }
}

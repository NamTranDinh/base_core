part of 'video_cubit.dart';

enum VideoStatus {
  initializing, // The video is initializing
  initialized, // The video was initially successful
  playing, // The video is playing
  paused, // The video paused
  completed, // The video play to end of its duration
  error, // Some error
}

class VideoState extends Equatable {
  const VideoState({
    required this.videoPlayerController,
    required this.videoUrl,
    required this.videoStatus,
    required this.duration,
    required this.position,
    required this.isPlaying,
    required this.isInteraction,
    required this.isAutoPlay,
    required this.isAutoReplay,
    required this.isFullScreen,
    this.errorMessage,
  });

  factory VideoState.init({
    required String videoUrl,
  }) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    final controller =
        AppHelper.isLocalPath(videoUrl).name == DataSourceType.file.name
            ? VideoPlayerController.file(File(videoUrl))
            : VideoPlayerController.networkUrl(Uri.parse(videoUrl));

    return VideoState(
      videoPlayerController: controller,
      videoUrl: videoUrl,
      videoStatus: VideoStatus.initializing,
      duration: Duration.zero,
      position: Duration.zero,
      isInteraction: false,
      isPlaying: false,
      isAutoPlay: false,
      isAutoReplay: false,
      isFullScreen: false,
    );
  }

  final VideoPlayerController videoPlayerController;
  final String videoUrl;
  final bool isInteraction;
  final bool isAutoPlay;
  final bool isAutoReplay;
  final VideoStatus videoStatus;
  final Duration duration;
  final Duration position;
  final String? errorMessage;
  final bool isPlaying;
  final bool isFullScreen;

  VideoState copyWith({
    VideoPlayerController? videoPlayerController,
    String? videoUrl,
    bool? isInteraction,
    VideoStatus? videoStatus,
    Duration? duration,
    Duration? position,
    String? errorMessage,
    bool? isPlaying,
    bool? isAutoPlay,
    bool? isAutoReplay,
    bool? isFullScreen,
  }) =>
      VideoState(
        videoPlayerController:
            videoPlayerController ?? this.videoPlayerController,
        videoUrl: videoUrl ?? this.videoUrl,
        videoStatus: videoStatus ?? this.videoStatus,
        duration: duration ?? this.duration,
        position: position ?? this.position,
        isInteraction: isInteraction ?? this.isInteraction,
        isPlaying: isPlaying ?? this.isPlaying,
        isAutoPlay: isAutoPlay ?? this.isAutoPlay,
        isAutoReplay: isAutoReplay ?? this.isAutoReplay,
        isFullScreen: isFullScreen ?? this.isFullScreen,
      );

  Future<void> dispose() async {
    await videoPlayerController.dispose();
  }

  static bool _isValidUrl(String url) {
    Uri? uri = Uri.tryParse(url);
    return uri != null &&
        uri.isAbsolute &&
        (uri.scheme == 'http' || uri.scheme == 'https');
  }

  @override
  List<Object?> get props => [
        videoPlayerController,
        videoUrl,
        videoStatus,
        errorMessage,
        duration,
        position,
        isInteraction,
        isPlaying,
        isAutoPlay,
        isAutoReplay,
        isFullScreen,
      ];
}

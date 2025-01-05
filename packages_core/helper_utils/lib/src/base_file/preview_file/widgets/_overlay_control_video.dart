import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper_utils/src/base_file/preview_file/cubit/video_cubit/video_cubit.dart';
import 'package:helper_utils/src/base_file/preview_file/widgets/_action_control_button.dart';
import 'package:helper_utils/src/base_file/preview_file/widgets/_action_timer_slider.dart';
import 'package:video_player/video_player.dart';

class OverlayControlVideo extends StatefulWidget {
  const OverlayControlVideo({super.key, required this.videoPlayer});

  final VideoPlayer videoPlayer;

  @override
  State<OverlayControlVideo> createState() => _OverlayControlVideoState();
}

class _OverlayControlVideoState extends State<OverlayControlVideo> {
  final isShowingAction = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoCubit, VideoState>(
      buildWhen: (previous, current) =>
          previous.videoPlayerController != current.videoPlayerController &&
          current.videoStatus == VideoStatus.initialized,
      builder: (context, videoState) {
        return Center(
          child: AspectRatio(
            aspectRatio: videoState.videoPlayerController.value.aspectRatio,
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => isShowingAction.value = !isShowingAction.value,
                    child: widget.videoPlayer,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: isShowingAction,
                  builder: (context, value, child) => Visibility(
                    visible: isShowingAction.value,
                    child: InkWell(
                      onTap: () =>
                          isShowingAction.value = !isShowingAction.value,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.black.withOpacity(.3),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 34),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ActionControlButton(
                                      onTap: () => context
                                          .read<VideoCubit>()
                                          .seekBackward(),
                                      iconData: Icons.replay_10_rounded,
                                    ),
                                    BlocBuilder<VideoCubit, VideoState>(
                                      buildWhen: (previous, current) =>
                                          previous.isPlaying !=
                                          current.isPlaying,
                                      builder: (context, videoState) {
                                        return ActionControlButton(
                                          onTap: () => context
                                              .read<VideoCubit>()
                                              .togglePlay(),
                                          iconData: videoState.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow_sharp,
                                          size: 55,
                                        );
                                      },
                                    ),
                                    ActionControlButton(
                                      onTap: () => context
                                          .read<VideoCubit>()
                                          .seekForward(),
                                      iconData: Icons.forward_10_rounded,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.bottomCenter,
                              child: ActionTimerSlider(),
                            ),
                          ],
                        ),
                      )
                          .animate()
                          .fadeIn(duration: const Duration(milliseconds: 150)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    isShowingAction.dispose();
  }
}

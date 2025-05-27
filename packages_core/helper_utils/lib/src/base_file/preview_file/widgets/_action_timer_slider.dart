import 'package:helper_utils/helper_utils.dart';
import 'package:helper_utils/src/base_file/preview_file/cubit/video_cubit/video_cubit.dart';
import 'package:helper_utils/src/base_file/preview_file/widgets/_action_control_button.dart';
import 'package:helper_utils/src/base_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionTimerSlider extends StatelessWidget {
  const ActionTimerSlider({super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: 25.0,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<VideoCubit, VideoState>(
              buildWhen: (previous, current) =>
                  previous.position.inMilliseconds !=
                  current.position.inMilliseconds,
              builder: (context, positionState) {
                return Text(
                  AppHelper.formatMilliseconds(
                    positionState.position.inMilliseconds,
                  ),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<VideoCubit, VideoState>(
                buildWhen: (previous, current) =>
                    previous.position.inMilliseconds !=
                    current.position.inMilliseconds,
                builder: (context, positionState) {
                  final cubit = context.read<VideoCubit>();
                  return Slider(
                    activeColor: Colors.white,
                    inactiveColor: Colors.white.withOpacity(.3),
                    value: positionState.position.inMilliseconds.toDouble(),
                    min: .0,
                    max: positionState.duration.inMilliseconds.toDouble(),
                    onChangeStart: (val) {
                      cubit.pauseVideo();
                    },
                    onChanged: (val) {
                      final newPosition = double.parse(val.toString()).toInt();
                      cubit.seekToDurationNotifier(
                          Duration(milliseconds: newPosition));
                    },
                    onChangeEnd: (val) async {
                      final newPosition = double.parse(val.toString()).toInt();
                      await cubit
                          .seekToDuration(Duration(milliseconds: newPosition));
                      await cubit.playVideo();
                    },
                  );
                },
              ),
            ),
            BlocBuilder<VideoCubit, VideoState>(
              buildWhen: (previous, current) =>
                  previous.duration.inMilliseconds !=
                  current.duration.inMilliseconds,
              builder: (context, durationState) {
                return Text(
                  AppHelper.formatMilliseconds(
                    durationState.duration.inMilliseconds,
                  ),
                );
              },
            ),
            BlocBuilder<VideoCubit, VideoState>(
              buildWhen: (previous, current) {
                return previous.isFullScreen != current.isFullScreen;
              },
              builder: (context, fullScreenState) {
                return ActionControlButton(
                  onTap: () => context.read<VideoCubit>().toggleFullScreen(),
                  iconData: fullScreenState.isFullScreen
                      ? Icons.fullscreen_exit
                      : Icons.fullscreen,
                  size: 22,
                  padding: const EdgeInsets.only(left: 8),
                );
              },
            ),
          ],
        ),
      );
}

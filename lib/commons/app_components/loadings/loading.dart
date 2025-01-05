import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, required this.size});

  factory Loading.small() => const Loading(size: 18);

  factory Loading.medium() => const Loading(size: 36);

  factory Loading.large() => const Loading(size: 50);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: const CircularProgressIndicator(strokeWidth: 2),
    );
  }
}

class StackLoading extends StatelessWidget {
  const StackLoading({
    super.key,
    required this.loading,
    required this.child,
    required this.processing,
    this.emptyWidget,
  });

  factory StackLoading.small({
    required Widget child,
    required bool processing,
    Widget? emptyWidget,
  }) =>
      StackLoading(
        loading: Loading.small(),
        processing: processing,
        emptyWidget: emptyWidget,
        child: child,
      );

  factory StackLoading.medium({
    required Widget child,
    required bool processing,
    Widget? emptyWidget,
  }) =>
      StackLoading(
        loading: Loading.medium(),
        processing: processing,
        emptyWidget: emptyWidget,
        child: child,
      );

  factory StackLoading.large({
    required Widget child,
    required bool processing,
    Widget? emptyWidget,
  }) =>
      StackLoading(
        loading: Loading.large(),
        processing: processing,
        emptyWidget: emptyWidget,
        child: child,
      );

  final Loading loading;
  final Widget child;
  final Widget? emptyWidget;
  final bool processing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (emptyWidget != null && !processing) Center(child: emptyWidget),
        if (processing)
          ColoredBox(
            color: Colors.transparent,
            child: Center(child: loading),
          )
        else
          const SizedBox(),
      ],
    );
  }
}

import "package:flutter/material.dart";

class LoadingStack extends StatelessWidget {
  const LoadingStack({
    required this.loading,
    required this.child,
    required this.processing,
    super.key,
    this.emptyWidget,
  });

  factory LoadingStack.small({
    required Widget child,
    required bool processing,
    Widget? emptyWidget,
  }) =>
      LoadingStack(
        loading: Loading.small(),
        processing: processing,
        emptyWidget: emptyWidget,
        child: child,
      );

  factory LoadingStack.medium({
    required Widget child,
    required bool processing,
    Widget? emptyWidget,
  }) =>
      LoadingStack(
        loading: Loading.medium(),
        processing: processing,
        emptyWidget: emptyWidget,
        child: child,
      );

  factory LoadingStack.large({
    required Widget child,
    required bool processing,
    Widget? emptyWidget,
  }) =>
      LoadingStack(
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

class Loading extends StatelessWidget {
  const Loading({required this.size, super.key});

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

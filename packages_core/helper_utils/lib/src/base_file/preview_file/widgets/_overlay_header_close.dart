import 'package:flutter/material.dart';

class OverlayHeaderClose extends StatelessWidget {
  const OverlayHeaderClose({super.key, required this.child, this.isShowIconBack = true});

  final Widget child;
  final bool isShowIconBack;

  @override
  Widget build(BuildContext context) {
    final isShowAction = ValueNotifier<bool>(true);
    return Stack(
      children: [
        GestureDetector(
          onTap: () => isShowAction.value = !isShowAction.value,
          child: child,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ValueListenableBuilder(
            valueListenable: isShowAction,
            builder: (context, value, child) => Visibility(
              visible: isShowAction.value,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(color: isShowIconBack ? Colors.black54 : Colors.transparent),
                  child: isShowIconBack
                      ? const SafeArea(child: Icon(Icons.arrow_back, color: Colors.white))
                      : const SizedBox(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

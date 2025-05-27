import 'package:flutter/material.dart';

class ActionControlButton extends StatelessWidget {
  const ActionControlButton({super.key, required this.iconData, this.size, this.onTap, this.padding});

  final IconData iconData;
  final double? size;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Icon(iconData, color: Colors.white, size: size ?? 34),
      ),
    );
  }
}

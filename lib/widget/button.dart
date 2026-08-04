import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final Widget? label;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final Color? backgroundColor;

  const TagChip({
    super.key,
    required this.label,
    this.onTap,
    this.onLongPress,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Material(
        color: backgroundColor,
        shape: const StadiumBorder(),
        child: InkWell(
          customBorder: const StadiumBorder(),
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: label,
          ),
          onTap: onTap,
          onLongPress: onLongPress,
        ),
      ),
    );
  }
}
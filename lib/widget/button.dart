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
      margin: const EdgeInsets.only(top: 2, bottom: 2),
      child: Material(
        color: backgroundColor ?? const Color(0xFFEEF1FF),
        shape: StadiumBorder(
          side: const BorderSide(color: Color(0xFFCDD6F0), width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
            child: DefaultTextStyle.merge(
              style: const TextStyle(
                color: Color(0xFF3E4C8A),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              child: label ?? const SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:yande/widget/progress.dart';

class LazyLoadGridView extends StatelessWidget {
  final ScrollController? controller;
  final List<Widget> children;
  final int crossAxisCount;
  final Widget footer;
  final String? heroPrefix;

  LazyLoadGridView({
    super.key,
    this.crossAxisCount = 2,
    this.controller,
    required this.children,
    this.heroPrefix,
    this.footer = const FootProgress(),
  }) : assert(children.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      children: <Widget>[
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: crossAxisCount,
          children: children,
        ),
        footer,
      ],
    );
  }
}
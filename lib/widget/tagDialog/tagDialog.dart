import 'package:flutter/material.dart';

class TagDialog extends StatelessWidget {
  const TagDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        ListTile(
          title: const Text('加入快捷搜索'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('过滤'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class ImageStatusButton extends StatelessWidget {
  final VoidCallback? showStatus;

  const ImageStatusButton({super.key, this.showStatus});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info_outline),
      tooltip: '图片详情',
      onPressed: showStatus,
    );
  }
}

class ImageShareButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ImageShareButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      tooltip: '分享',
      onPressed: onTap,
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yande/widget/progress.dart';

class MyCachedImage extends StatelessWidget {
  final String? url;

  const MyCachedImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (_, __) => const ImageCardCircularProgressIndicator(),
      imageUrl: url ?? '',
      fit: BoxFit.cover,
    );
  }
}
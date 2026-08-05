import 'package:yande/widget/retryableCachedImage.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:yande/model/image_model.dart';

class ImageGalleryView extends StatefulWidget {
  final ImageModel image;
  final String? heroPrefix;

  const ImageGalleryView({
    super.key,
    required this.image,
    this.heroPrefix,
  });

  @override
  State<StatefulWidget> createState() => _ImageGalleryViewState();
}

class _ImageGalleryViewState extends State<ImageGalleryView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // 长按预留。
      },
      child: Hero(
        tag: '${widget.heroPrefix}${widget.image.id}',
        child: RetryableCachedImage(
          imageUrl: widget.image.sampleUrl ?? '',
          fit: BoxFit.contain,
          placeholder: const Center(child: CircularProgressIndicator()),
          builder: (context, file) => PhotoView(
            imageProvider: FileImage(file),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
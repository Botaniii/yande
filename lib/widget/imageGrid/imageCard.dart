import 'package:yande/widget/retryableCachedImage.dart';
import 'package:flutter/material.dart';
import 'package:yande/model/image_model.dart';

typedef ImageTapCallBack = void Function(ImageModel);

const cardTopBorderDecoration = BoxDecoration(
  borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
);

const cardBottomBorderDecoration = BoxDecoration(
  borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
);

class MainImageCard extends StatelessWidget {
  final ImageModel imageModel;
  final GestureTapCallback? collectEvent;
  final GestureTapCallback? downloadEvent;
  final ImageTapCallBack? imageTap;
  final GestureLongPressCallback? onLongPress;
  final String? heroPrefix;

  /// 测试注入用：替换图片展示 widget，避免测试里触发网络图片加载。
  final Widget Function(ImageModel image)? imageBuilder;

  MainImageCard(
    this.imageModel, {
    this.collectEvent,
    this.downloadEvent,
    this.onLongPress,
    this.imageTap,
    this.heroPrefix,
    this.imageBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  _buildImageBlockWidget(imageModel),
                  _buildImageSizeText(imageModel),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: cardBottomBorderDecoration,
              child: Row(
                children: <Widget>[
                  _CollectButton(
                    status: imageModel.isCollect(),
                    onTap: collectEvent,
                  ),
                  _DownloadButton(
                    status: imageModel.downloadStatus,
                    onTap: downloadEvent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSizeText(ImageModel imageModel) {
    return Container(
      height: 20,
      decoration: const BoxDecoration(
        color: Color(0x1a000000),
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
      ),
      child: Center(
        child: Text(
          '${imageModel.width} x ${imageModel.height}',
          style: const TextStyle(color: Color(0xffffffff)),
        ),
      ),
    );
  }

  Widget _buildImageBlockWidget(ImageModel imageModel) {
    return Center(
      child: Container(
        decoration: cardTopBorderDecoration,
        child: GestureDetector(
          onTap: () => imageTap?.call(imageModel),
          child: Hero(
            tag: '$heroPrefix${imageModel.id}',
            child: imageBuilder != null
                ? imageBuilder!(imageModel)
                : RetryableCachedImage(
                    imageUrl: imageModel.previewUrl ?? '',
                    fit: BoxFit.fill,
                  ),
          ),
        ),
      ),
    );
  }
}

class _CollectButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final bool status;

  const _CollectButton({required this.onTap, required this.status});

  @override
  Widget build(BuildContext context) {
    return _CardMaterialButton(
      onTap: onTap,
      child: Icon(
        status ? Icons.star : Icons.star_border,
        color: status ? Colors.amberAccent : null,
      ),
    );
  }
}

class _DownloadButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final ImageDownloadStatus? status;

  const _DownloadButton({required this.onTap, required this.status});

  @override
  Widget build(BuildContext context) {
    return _CardMaterialButton(
      onTap: onTap,
      child: Icon(Icons.file_download, color: getColor()),
    );
  }

  Color getColor() {
    switch (status) {
      case ImageDownloadStatus.success:
        return Colors.amberAccent;
      case ImageDownloadStatus.pending:
        return Colors.blueGrey;
      case ImageDownloadStatus.error:
        return Colors.redAccent;
      case ImageDownloadStatus.none:
      case null:
        return Colors.black;
    }
  }
}

class _CardMaterialButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Widget child;

  const _CardMaterialButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 85,
            height: 30,
            child: child,
          ),
        ),
      ),
    );
  }
}

class ImageGalleryCard extends StatelessWidget {
  final ImageModel image;
  final ImageTapCallBack? imageTap;
  final GestureLongPressCallback? onLongPress;
  final String? heroPrefix;

  ImageGalleryCard(
    this.image, {
    this.onLongPress,
    this.imageTap,
    this.heroPrefix,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: SizedBox(
          height: 140,
          width: 200,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
            ),
            child: GestureDetector(
              onTap: () => imageTap?.call(image),
              child: Hero(
                tag: '$heroPrefix${image.id}',
                child: RetryableCachedImage(
                  imageUrl: image.previewUrl ?? '',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
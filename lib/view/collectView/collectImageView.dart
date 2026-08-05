import 'package:flutter/material.dart';
import 'package:yande/utils/storageAccess.dart';
import 'package:yande/dao/init_dao.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/service/downloadService.dart';
import 'package:yande/service/imageServive.dart';
import 'package:yande/view/imageStatus/imageStatusView.dart';
import 'package:yande/widget/imageGrid/imageCard.dart';
import 'package:yande/widget/imageGrid/myImageLazyLoadGrid.dart';

class CollectImageView extends StatefulWidget {
  static const title = '收藏';
  static const route = '/collect';

  const CollectImageView({super.key});

  @override
  State<StatefulWidget> createState() => _CollectImageViewState();
}

class _CollectImageViewState extends State<CollectImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('收藏'),
      ),
      body: MyImageLazyLoadGrid(
        sourceName: DaoDataSource.name,
        cardBuilder: (image) => MainImageCard(
          image,
          imageTap: (ImageModel image) => _goImageStatus(image),
          collectEvent: () => collectAction(image),
          downloadEvent: () => downloadAction(image),
          heroPrefix: '${image.pages}collect',
        ),
      ),
    );
  }

  _goImageStatus(ImageModel image) {
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) {
              return ImageStatusView(
                image: image,
              );
            }));
  }

  Future<void> collectAction(ImageModel image) async {
    image = await ImageService.collectImage(image);
    if (mounted) {
      setState(() {});
    }
  }

  void downloadAction(ImageModel image) async {
    if (image.downloadStatus != ImageDownloadStatus.pending) {
      _showMessageBySnackbar('开始下载');
      if (mounted) {
        setState(() {});
      }
              try {
          await DownloadService.downloadImage(image);
        } on StoragePermissionException {
          _showMessageBySnackbar('需要开启“所有文件访问”才能保存到该目录');
          await StorageAccess.openSettings();
        }
      if (mounted) {
        setState(() {});
      }
    }
  }

  _showMessageBySnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}
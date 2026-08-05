import 'package:flutter/material.dart';
import 'package:yande/utils/storageAccess.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/service/downloadService.dart';
import 'package:yande/service/imageServive.dart';
import 'package:yande/service/updateService.dart';
import 'package:yande/view/imageStatus/imageStatusView.dart';
import 'package:yande/view/index/components/drawer.dart';
import 'package:yande/view/search/searchView.dart';
import 'package:yande/widget/dialog.dart';
import 'package:yande/widget/imageGrid/imageCard.dart';
import 'package:yande/widget/imageGrid/myImageLazyLoadGrid.dart';

class IndexView extends StatefulWidget {
  static final String route = '/';
  static final String title = 'yande';

  const IndexView({super.key});

  @override
  State<IndexView> createState() => _IndexView();
}

class _IndexView extends State<IndexView> {
  @override
  void initState() {
    super.initState();
    checkUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(IndexView.title),
        actions: <Widget>[
          _buildSearchButton(),
        ],
      ),
      drawer: const LeftDrawer(),
      endDrawer: const RightDrawer(),
      body: Container(
        child: _buildImageContent(),
      ),
    );
  }

  _buildImageContent() {
    return MyImageLazyLoadGrid(
      cardBuilder: (image) => _buildImageCard(image),
    );
  }

  MainImageCard _buildImageCard(ImageModel image) =>
      MainImageCard(
        image,
        heroPrefix: '${image.pages}index',
        imageTap: (ImageModel image) => _goImageStatus(image, '${image.pages}index'),
        collectEvent: () => collectAction(image),
        downloadEvent: () => downloadAction(image),
      );

  _goImageStatus(ImageModel image, String heroPrefix) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageStatusView(image: image, heroPrefix: heroPrefix),
        ));
  }

  Widget _buildSearchButton() {
    return IconButton(
      tooltip: 'Search',
      icon: const Icon(Icons.search),
      onPressed: () async {
        Navigator.pushNamed(context, TagSearchView.route);
      },
    );
  }

  void checkUpdate() {
    UpdateService.getVersion(
      shouldUpdate: (githubRelease) {
        showDialog(
            context: context,
            builder: (context) => UpdateDialog(
                  version: githubRelease.tagName,
                  text: githubRelease.body,
                  url: githubRelease.htmlUrl,
                ));
      },
    ).catchError((_) {
      // 更新检查失败时静默。
    });
  }

  Future<void> collectAction(ImageModel image) async {
    image = await ImageService.collectImage(image);
    if (mounted) {
      setState(() {});
    }
  }

  void downloadAction(ImageModel image) async {
    if (image.downloadStatus != ImageDownloadStatus.pending &&
        image.downloadStatus != ImageDownloadStatus.success) {
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
import 'package:flutter/material.dart';
import 'package:yande/utils/storageAccess.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/model/tag_model.dart';
import 'package:yande/service/downloadService.dart';
import 'package:yande/service/imageServive.dart';
import 'package:yande/store/store.dart';
import 'package:yande/view/imageStatus/imageStatusView.dart';
import 'package:yande/widget/imageGrid/imageCard.dart';
import 'package:yande/widget/imageGrid/myImageLazyLoadGrid.dart';

class ResultView extends StatefulWidget {
  final String? tags;

  const ResultView({super.key, this.tags});

  @override
  State<StatefulWidget> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  bool? isShortcut;

  bool updateTagListLock = false;
  bool noImageLoad = false;

  String? filterRank;

  Key get fabKey => const ValueKey<String>('resultViewFabkey');

  @override
  void initState() {
    super.initState();
    getShortcutStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('搜索：${widget.tags ?? ''}',
            overflow: TextOverflow.ellipsis),
      ),
      body: Container(
        child: MyImageLazyLoadGrid(
          searchTag: widget.tags,
          cardBuilder: (image) => _buildImageCard(image),
        ),
      ),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  MainImageCard _buildImageCard(ImageModel image) {
    return MainImageCard(
      image,
      imageTap: (ImageModel image) => _goImageStatus(image),
      collectEvent: () => collectAction(image),
      downloadEvent: () => downloadAction(image),
      heroPrefix: '${image.pages}result',
    );
  }

  _goImageStatus(ImageModel image) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
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

  _buildFloatingButton() {
    if (isShortcut == false) {
      return _buildAddShortcutFloatingButton();
    } else if (isShortcut == true) {
      return _buildDeleteShortcutFloatingButton();
    } else {
      return Container();
    }
  }

  FloatingActionButton _buildDeleteShortcutFloatingButton() {
    return FloatingActionButton(
      key: fabKey,
      child: const Icon(
        Icons.delete,
      ),
      backgroundColor: Colors.red,
      onPressed: () {
        _deleteShortcut(widget.tags ?? '');
      });
  }

  FloatingActionButton _buildAddShortcutFloatingButton() {
    return FloatingActionButton(
      key: fabKey,
      child: const Icon(
        Icons.add,
      ),
      onPressed: () {
        _addShortcut(widget.tags ?? '');
      });
  }

  void _deleteShortcut(String tag) async {
    TagStore.unCollectTag(TagModel.fromTagString(tag));
    isShortcut = false;
    if (mounted) {
      setState(() {});
    }
  }

  void _addShortcut(String tag) async {
    TagStore.collectTag(TagModel.fromTagString(tag));
    isShortcut = true;
    if (mounted) {
      setState(() {});
    }
  }

  void getShortcutStatus() {
    isShortcut = TagStore.isCollectByName(widget.tags ?? '');
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
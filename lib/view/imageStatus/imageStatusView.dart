import 'package:flutter/material.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/model/tag_model.dart';
import 'package:yande/service/downloadService.dart';
import 'package:yande/service/imageServive.dart';
import 'package:yande/view/imageGallery/imageGalleryView.dart';
import 'package:yande/view/search/resultView.dart';
import 'package:yande/widget/button.dart';
import 'components/imageStatusAppBar.dart';
import 'components/status_dialog.dart';

class ImageStatusView extends StatefulWidget {
  static final String route = '/status';
  static final String title = 'imageStatus';

  final ImageModel image;
  final String? heroPrefix;

  const ImageStatusView({super.key, required this.image, this.heroPrefix});

  @override
  State<StatefulWidget> createState() => _ImageStatusView();
}

class _ImageStatusView extends State<ImageStatusView> {
  Key get fabKey => const ValueKey<String>('imageStatusFabkey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _buildMaterialButton(),
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            ImageStatusSliverAppBar(
              image: widget.image,
              heroPrefix: widget.heroPrefix,
              showDialog: () => _showImageStatus(),
            ),
            SliverList(
                delegate: SliverChildListDelegate(<Widget>[
              ImageActionButtonFiled(
                children: <Widget>[
                  _buildLargeButton(
                    '查看',
                    onPressed: () => viewImage(),
                  ),
                  _buildDownloadButton(
                    widget.image,
                    onPressed: () => downloadAction(widget.image),
                  ),
                ],
              ),
              TagChipFiled(
                children: (widget.image.tagTagModelList ?? <TagModel>[])
                    .map((tag) => _buildSearchChip(tag))
                    .toList(),
              ),
            ])),
          ],
        ),
      ),
    );
  }

  FloatingActionButton _buildMaterialButton() {
    if (widget.image.collectStatus == ImageCollectStatus.star) {
      return _buildAddCollectFloatingButton();
    } else {
      return _buildDeleteCollectFloatingButton();
    }
  }

  FloatingActionButton _buildDeleteCollectFloatingButton() {
    return FloatingActionButton(
      key: fabKey,
      child: const Icon(
        Icons.star_border,
        size: 30,
      ),
      onPressed: () => collectEvent(),
    );
  }

  void collectEvent() async {
    final image = await ImageService.collectImage(widget.image);
    widget.image.collectStatus = image.collectStatus;
    if (mounted) {
      setState(() {});
    }
  }

  FloatingActionButton _buildAddCollectFloatingButton() {
    return FloatingActionButton(
      key: fabKey,
      child: const Icon(
        Icons.star,
        size: 30,
        color: Colors.amberAccent,
      ),
      onPressed: () => collectEvent(),
    );
  }

  Widget _buildSearchChip(TagModel tag) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: TagChip(
        backgroundColor: const Color(0x44eeeeee),
        label: Text(tag.name ?? ''),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultView(tags: tag.name ?? ''))),
        onLongPress: () {
          // 长按 tag 预留。
        },
      ),
    );
  }

  void viewImage() {
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) {
              return ImageGalleryView(
                image: widget.image,
                heroPrefix: widget.heroPrefix,
              );
            }));
  }

  Widget _buildLargeButton(String name, {VoidCallback? onPressed}) {
    return Expanded(
      child: FilledButton(
        onPressed: onPressed,
        child: SizedBox(
          height: 50,
          child: Center(
            child: Text(
              name,
            ),
          ),
        ),
      ),
    );
  }

  void downloadAction(ImageModel image) async {
    if (image.downloadStatus != ImageDownloadStatus.pending &&
        image.downloadStatus != ImageDownloadStatus.success) {
      _showMessageBySnackbar('开始下载');
      if (mounted) {
        setState(() {});
      }
      await DownloadService.downloadImage(image);
      if (mounted) {
        setState(() {});
      }
    }
  }

  Widget _buildDownloadButton(ImageModel image, {VoidCallback? onPressed}) {
    if (image.downloadStatus == ImageDownloadStatus.pending) {
      return _buildLargeButton('正在下载');
    } else if (image.downloadStatus == ImageDownloadStatus.success) {
      return _buildLargeButton('已经下载');
    } else {
      return _buildLargeButton(
        '下载',
        onPressed: () => downloadAction(image),
      );
    }
  }

  _showMessageBySnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  _showImageStatus() {
    showDialog(
        context: context,
        builder: (context) => ImageStatusDialog(widget.image));
  }
}

class TagChipFiled extends StatelessWidget {
  final List<Widget> children;

  const TagChipFiled({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 40),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xffeaeaea),
            width: 1,
          ),
          bottom: BorderSide(
            color: Color(0xffeaeaea),
            width: 1,
          ),
        ),
      ),
      child: Wrap(
        children: children,
      ),
    );
  }
}
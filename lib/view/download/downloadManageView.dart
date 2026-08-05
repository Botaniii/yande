import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yande/appliction.dart';
import 'package:yande/dao/init_dao.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/view/imageStatus/imageStatusView.dart';
import 'package:yande/widget/retryableCachedImage.dart';

class DownloadManageView extends StatefulWidget {
  static const title = '下载管理';
  static const route = '/downloads';

  const DownloadManageView({super.key});

  @override
  State<StatefulWidget> createState() => _DownloadManageViewState();
}

class _DownloadManageViewState extends State<DownloadManageView> {
  bool _loading = true;
  List<ImageModel> _images = <ImageModel>[];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final source = Application.getInstance().dataPool
        .getSource(DaoDataSource.name) as AppDaoDataSource;
    var list = await source.getAllDownloadedImage();

    // 同步文件存在性：本地已删除的图片从列表中移除并重置状态。
    final alive = <ImageModel>[];
    for (final image in list) {
      final path = image.downloadPath;
      if (path == null || path.isEmpty || !await File(path).exists()) {
        await source.resetDownloadStatus(image.id ?? -1);
      } else {
        alive.add(image);
      }
    }
    list = alive;

    if (mounted) {
      setState(() {
        _images = list;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(DownloadManageView.title),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_images.isEmpty) {
      return const Center(
        child: Text(
          '暂无下载的图片',
          style: TextStyle(color: Colors.black38, fontSize: 15),
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.72,
      ),
      itemCount: _images.length,
      itemBuilder: (context, index) => _buildCard(_images[index]),
    );
  }

  Widget _buildCard(ImageModel image) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () => _goImageStatus(image),
              child: RetryableCachedImage(
                imageUrl: image.previewUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${image.width} x ${image.height}',
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20),
                  tooltip: '删除文件',
                  onPressed: () => _confirmDelete(image),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _goImageStatus(ImageModel image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageStatusView(image: image),
      ),
    );
  }

  Future<void> _confirmDelete(ImageModel image) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除已下载文件'),
        content: const Text('将从本地删除该图片文件，且状态重置为未下载。'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await _deleteImage(image);
    }
  }

  Future<void> _deleteImage(ImageModel image) async {
    final path = image.downloadPath;
    if (path != null && path.isNotEmpty) {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    }
    final source = Application.getInstance().dataPool
        .getSource(DaoDataSource.name) as AppDaoDataSource;
    await source.resetDownloadStatus(image.id ?? -1);
    if (mounted) {
      setState(() {
        _images.removeWhere((item) => item.id == image.id);
      });
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('已删除'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }
}
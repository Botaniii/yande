import 'package:flutter/material.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/service/imageServive.dart';
import 'package:yande/widget/imageGrid/lazyloadView.dart';
import 'package:yande/widget/progress.dart';

typedef ImageCardBuilder = Widget Function(ImageModel image);

class MyImageLazyLoadGrid extends StatefulWidget {
  final int crossAxisCount;
  final Widget footer;
  final String? heroPrefix;
  final ImageCardBuilder? cardBuilder;
  final String? searchTag;
  final int pages;
  final int limit;
  final String? sourceName;

  const MyImageLazyLoadGrid({
    super.key,
    this.crossAxisCount = 2,
    this.cardBuilder,
    this.heroPrefix,
    this.pages = 1,
    this.searchTag,
    this.limit = 20,
    this.sourceName,
    this.footer = const FootProgress(),
  });

  @override
  State<MyImageLazyLoadGrid> createState() => _MyImageLazyLoadGridState();
}

class _MyImageLazyLoadGridState extends State<MyImageLazyLoadGrid> {
  final ScrollController controller = ScrollController();
  List<ImageModel> imageList = <ImageModel>[];
  GridViewLoadingStatus loadingStatus = GridViewLoadingStatus.pending;
  bool isInitError = false;
  String? filterRank;
  bool noImageLoad = false;
  late int pages;
  late int limit;

  @override
  void initState() {
    super.initState();
    pages = widget.pages;
    limit = widget.limit;
    controller.addListener(scrollListener);
    reloadGallery();
  }

  @override
  Widget build(BuildContext context) {
    Widget footer = const FootProgress();
    if (noImageLoad) {
      footer = Center(
        child: const Text('没有更多图片了'),
      );
    }
    if (imageList.isNotEmpty) {
      return RefreshIndicator(
        child: LazyLoadGridView(
          controller: controller,
          heroPrefix: widget.heroPrefix,
          children: imageList.map(widget.cardBuilder!).toList(),
          footer: footer,
        ),
        onRefresh: reloadGallery,
      );
    } else if (isInitError) {
      return buildErrorContent();
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget buildErrorContent() {
    return GestureDetector(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: const Center(
          child: Text(
            '加载失败了呢~\n点击重试',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xffcccccc)),
          ),
        ),
      ),
      behavior: HitTestBehavior.translucent,
      onTap: () => reloadGallery(),
    );
  }

  void scrollListener() {
    if (controller.position.extentAfter < 50 &&
        loadingStatus != GridViewLoadingStatus.pending) {
      _loadPage(pages, limit);
    }
  }

  Future<void> _loadPage(int pages, int limit) async {
    try {
      final imageList = await _getImageList();
      _updateImageList(imageList);
    } catch (e) {
      debugPrint('load page error: $e');
    }
  }

  Future<void> reloadGallery() async {
    pages = 1;
    isInitError = false;
    if (mounted) {
      setState(() {});
    }
    try {
      imageList = await _getImageList();
    } catch (e) {
      if (loadingStatus == GridViewLoadingStatus.error) {
        isInitError = true;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  /// @Param pages 页码
  /// @Param limit 每页显示条数
  Future<List<ImageModel>> _getImageList() async {
    loadingStatus = GridViewLoadingStatus.pending;

    try {
      final imageList = <ImageModel>[];
      var loadedPages = 0;
      while (imageList.length < 10 && loadedPages < 5) {
        try {
          if (widget.searchTag != null) {
            imageList.addAll(await ImageService.getImageByTag(
                widget.searchTag!, pages, limit,
                sourceName: widget.sourceName));
          } else {
            imageList.addAll(await ImageService.getIndexListByPage(
              pages,
              limit,
              sourceName: widget.sourceName,
            ));
          }
          pages++;
          loadedPages++;
        } catch (e) {
          if (e is NoImageError) {
            noImageLoad = true;
            break;
          } else {
            rethrow;
          }
        }
      }

      loadingStatus = GridViewLoadingStatus.success;
      return imageList;
    } catch (e) {
      loadingStatus = GridViewLoadingStatus.error;
      rethrow;
    }
  }

  /// @Param imageList 新的图片
  void _updateImageList(List<ImageModel> imageList) {
    this.imageList.addAll(imageList);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

enum GridViewLoadingStatus { pending, success, error }
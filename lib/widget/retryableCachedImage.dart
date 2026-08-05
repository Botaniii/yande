import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yande/service/cacheService.dart';
import 'package:yande/widget/progress.dart';

/// 加载失败可自动重试的网络图片组件。
///
/// yande.re 的图片节点不稳定且 DNS 会轮换，一次失败不代表永久失败：
/// 失败时先清理缓存条目，间隔重试数次，若仍失败则显示“点击重试”。
typedef RetryableImageBuilder = Widget Function(BuildContext context, File file);

class RetryableCachedImage extends StatefulWidget {
  final String imageUrl;
  final BoxFit fit;
  final Widget placeholder;
  final int maxRetries;
  final Duration retryDelay;

  /// 自定义成功后的展示方式（例如 PhotoView 全屏查看）。
  final RetryableImageBuilder? builder;

  const RetryableCachedImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.placeholder = const ImageCardCircularProgressIndicator(),
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 3),
    this.builder,
  });

  @override
  State<RetryableCachedImage> createState() => _RetryableCachedImageState();
}

class _RetryableCachedImageState extends State<RetryableCachedImage> {
  File? _file;
  int _attempt = 0;
  bool _failed = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant RetryableCachedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _timer?.cancel();
      _file = null;
      _failed = false;
      _attempt = 0;
      _load();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    if (widget.imageUrl.isEmpty) {
      if (mounted) {
        setState(() => _failed = true);
      }
      return;
    }
    try {
      final file = await CacheService.getFile(widget.imageUrl);
      if (!mounted) {
        return;
      }
      setState(() {
        _file = file;
        _failed = false;
      });
    } catch (_) {
      // 清掉可能残留的失败/半截缓存，确保下次请求全新下载。
      await CacheService.removeFile(widget.imageUrl);
      if (!mounted) {
        return;
      }
      if (_attempt < widget.maxRetries) {
        _attempt++;
        _timer = Timer(widget.retryDelay, _load);
      } else {
        setState(() => _failed = true);
      }
    }
  }

  void _retryManually() {
    setState(() {
      _file = null;
      _failed = false;
      _attempt = 0;
    });
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final file = _file;
    if (file != null && file.existsSync()) {
      if (widget.builder != null) {
        return widget.builder!(context, file);
      }
      return Image.file(file, fit: widget.fit);
    }
    if (_failed) {
      return GestureDetector(
        onTap: _retryManually,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Icon(Icons.refresh, color: Colors.black38, size: 26),
              SizedBox(height: 4),
              Text(
                '加载失败，点击重试',
                style: TextStyle(color: Colors.black45, fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }
    return widget.placeholder;
  }
}
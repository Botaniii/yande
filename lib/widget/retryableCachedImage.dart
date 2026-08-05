import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:yande/widget/progress.dart';

/// 网络图片加载组件（直接下载字节流渲染，不做缓存管理）。
///
/// yande.re 的图片节点不稳定，一次失败不代表永久失败：
/// 请求失败后显示“点击重试”，每次点击都是一次全新请求。
typedef RetryableImageBuilder = Widget Function(BuildContext context, Uint8List bytes);

class RetryableCachedImage extends StatefulWidget {
  final String imageUrl;
  final BoxFit fit;
  final Widget placeholder;

  /// 自定义成功后的展示方式（例如 PhotoView 全屏查看）。
  final RetryableImageBuilder? builder;

  const RetryableCachedImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.placeholder = const ImageCardCircularProgressIndicator(),
    this.builder,
  });

  @override
  State<RetryableCachedImage> createState() => _RetryableCachedImageState();
}

class _RetryableCachedImageState extends State<RetryableCachedImage> {
  /// 组件级共享 dio：带超时，避免重复创建。
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  /// ???????????????????????????????
  /// ????????DNS ??/??????????
  static const int _maxConcurrent = 5;
  static int _activeDownloads = 0;
  static final Queue<Completer<void>> _waiters = Queue<Completer<void>>();

  Uint8List? _bytes;
  bool _failed = false;
  int _requestSeq = 0;
  Timer? _retryTimer;
  bool _autoRetried = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant RetryableCachedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _requestSeq++;
      _bytes = null;
      _failed = false;
      _load();
    }
  }

  @override
  void dispose() {
    _requestSeq++;
    _retryTimer?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    if (widget.imageUrl.isEmpty) {
      if (mounted) {
        setState(() => _failed = true);
      }
      return;
    }
    _autoRetried = false;
    _retryTimer?.cancel();
    await _acquireSlot();
    final seq = ++_requestSeq;
    if (mounted) {
      setState(() {
        _failed = false;
      });
    }
    try {
      final response = await _dio.get<List<int>>(
        widget.imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      final data = response.data;
      if (data == null || data.isEmpty) {
        throw StateError('empty image bytes: ${widget.imageUrl}');
      }
      final bytes = Uint8List.fromList(data);
      if (!mounted || seq != _requestSeq) {
        return;
      }
      setState(() {
        _bytes = Uint8List.fromList(bytes);
        _failed = false;
      });
    } catch (e) {
      debugPrint('RetryableCachedImage load failed: $e url=${widget.imageUrl}');
      if (!mounted || seq != _requestSeq) {
        return;
      }
      setState(() {
        _failed = true;
      });
      // ??????? Clash ?????????? 3 ????????
      // ???????????????????????????
      if (!_autoRetried) {
        _autoRetried = true;
        _retryTimer = Timer(const Duration(seconds: 3), _load);
      }
    } finally {
      _releaseSlot();
    }
  }

  Future<void> _acquireSlot() async {
    if (_activeDownloads < _maxConcurrent) {
      _activeDownloads++;
      return;
    }
    final completer = Completer<void>();
    _waiters.add(completer);
    await completer.future;
  }

  void _releaseSlot() {
    if (_waiters.isNotEmpty) {
      _waiters.removeFirst().complete();
    } else {
      _activeDownloads--;
    }
  }

  void _retryManually() {
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final bytes = _bytes;
    if (bytes != null) {
      if (widget.builder != null) {
        return widget.builder!(context, bytes);
      }
      return Image.memory(bytes, fit: widget.fit, gaplessPlayback: true);
    }
    if (_failed) {
      // 失败时不拦截点击：点击卡片会落到外层 GestureDetector 进入详情页
      //（大图 sample 是好的），小刷新按钮用于单独重试缩略图。
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          const ColoredBox(color: Color(0x11000000)),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                onPressed: _retryManually,
                icon: const Icon(Icons.refresh, color: Colors.black45, size: 22),
tooltip: '重试缩略图',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
              const Text(
                '缩略图加载失败',
                style: TextStyle(color: Colors.black45, fontSize: 11),
              ),
              const Text(
                '点击查看大图',
                style: TextStyle(color: Colors.black38, fontSize: 10),
              ),
            ],
          ),
        ],
      );
    }
    return widget.placeholder;
  }
}
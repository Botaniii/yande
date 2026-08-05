import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheService {
  static final DefaultCacheManager _cache = DefaultCacheManager();

  static Future<File> getFile(String url) => _cache.getSingleFile(url);

  /// 删除指定 URL 的缓存条目与文件（失败重试前清理用）。
  static Future<void> removeFile(String url) => _cache.removeFile(url);
}
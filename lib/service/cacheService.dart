import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheService {
  static final DefaultCacheManager _cache = DefaultCacheManager();

  static Future<File> getFile(String url) => _cache.getSingleFile(url);
}
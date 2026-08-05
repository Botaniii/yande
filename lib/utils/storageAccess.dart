import 'package:flutter/services.dart';

/// 公共存储写入权限（Android 11+ 需要“所有文件访问”）。
class StorageAccess {
  static const MethodChannel _channel = MethodChannel('yande_storage_access');

  static Future<bool> hasAllFilesAccess() async {
    try {
      final result = await _channel.invokeMethod<bool>('hasAllFilesAccess');
      return result ?? true;
    } catch (_) {
      // 低版本系统或通道异常时按已有权限处理。
      return true;
    }
  }

  static Future<void> openSettings() async {
    try {
      await _channel.invokeMethod('openAllFilesAccessSettings');
    } catch (_) {
      // 忽略打开失败。
    }
  }
}

/// 下载目标位于公共存储但缺少写入权限时抛出。
class StoragePermissionException implements Exception {
  const StoragePermissionException();
}
import 'package:flutter/services.dart';

/// 应用内 APK 安装（Android）。
class ApkInstaller {
  static const MethodChannel _channel = MethodChannel('yande_apk_install');

  /// 是否已允许“安装未知应用”。
  static Future<bool> canRequestInstall() async {
    try {
      final result = await _channel.invokeMethod<bool>('canRequestInstall');
      return result ?? true;
    } catch (_) {
      return true;
    }
  }

  /// 打开系统“安装未知应用”设置页。
  static Future<void> openInstallSettings() async {
    try {
      await _channel.invokeMethod('openInstallSettings');
    } catch (_) {}
  }

  /// 通过 FileProvider 调起系统安装界面。
  static Future<void> install(String apkPath) async {
    await _channel.invokeMethod('installApk', <String, dynamic>{'path': apkPath});
  }
}
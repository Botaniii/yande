import 'package:flutter/services.dart';

class ScanImagePlugins {
  static const MethodChannel _channel =
      MethodChannel('scan_image_file_broad_cast');

  static Future<void> broadcast(String path) async {
    final params = <String, dynamic>{
      'path': path,
    };
    await _channel.invokeMethod('broadcast', params);
  }
}
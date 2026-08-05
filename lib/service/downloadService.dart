import 'package:dio/dio.dart';
import 'package:yande/appliction.dart';
import 'package:yande/dao/init_dao.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/service/settingService.dart';
import 'package:yande/utils/storageAccess.dart';
import 'package:yande/utils/utils.dart';

class DownloadService {
  static Future<void> downloadImage(
    ImageModel image, {
    ProgressCallback? onProcess,
  }) async {
    final source = Application.getInstance().dataPool
        .getSource(DaoDataSource.name) as AppDaoDataSource;

    image.downloadStatus = ImageDownloadStatus.pending;
    await source.updateDownloadImageStatus(image);

    try {
      if (image.fileUrl == null || image.fileExt == null) {
        throw StateError('image has no fileUrl/fileExt');
      }
      final filePath = await _getDownloadPath(image);
      await _ensureWritable(filePath);
      await _doDownload(Dio(), image, filePath, onProcess);

      image.downloadStatus = ImageDownloadStatus.success;
      image.downloadPath = filePath;
      await source.updateDownloadImageStatus(image);

      await ScanImagePlugins.broadcast(filePath);
    } on StoragePermissionException {
      image.downloadStatus = ImageDownloadStatus.error;
      await source.updateDownloadImageStatus(image);
      rethrow;
    } catch (e) {
      image.downloadStatus = ImageDownloadStatus.error;
      await source.updateDownloadImageStatus(image);
    }
  }

  /// 目标目录在公共存储时，需要“所有文件访问”权限，否则抛异常让 UI 引导授权。
  static Future<void> _ensureWritable(String filePath) async {
    final isPublic = filePath.startsWith('/storage/emulated/0/') &&
        !filePath.startsWith('/storage/emulated/0/Android/');
    if (isPublic && !await StorageAccess.hasAllFilesAccess()) {
      throw const StoragePermissionException();
    }
  }

  static Future<void> _doDownload(
    Dio dio,
    ImageModel image,
    String filePath,
    ProgressCallback? onProcess,
  ) {
    return dio.download(
      image.fileUrl!,
      filePath,
      onReceiveProgress: onProcess,
    );
  }

  static Future<String> _getDownloadPath(ImageModel image) async {
    final dirPath = (await SettingService.getSetting(
      SETTING_TYPE.IMAGE_DOWNLOAD_PATH,
    ))
        .value;
    await FileUtils.getDirAndCreate(dirPath);
    return '$dirPath/${image.id}.${image.fileExt}';
  }
}
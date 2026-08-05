import 'package:sqflite/sqflite.dart';
import 'package:yande/model/image_model.dart';
import 'init_dao.dart';

class ImageDao {
  final DaoDataSource source;

  ImageDao(this.source);

  Future<ImageModel?> getImageById(int id, [Database? database]) async {
    final db = database ?? await source.getDatabase();
    try {
      final list = await db.query(
        MyDateBaseValue.Image,
        where: '${ImageTableColumn.id} = ?',
        whereArgs: <Object?>[id],
        limit: 1,
      );
      return list.isEmpty
          ? null
          : ImageModel.fromJson(Map<String, dynamic>.from(list.first));
    } catch (e) {
      return null;
    }
  }

  Future<bool> isImageExistById(int id, [Database? database]) async {
    final db = database ?? await source.getDatabase();
    try {
      final list = await db.query(
        MyDateBaseValue.Image,
        columns: <String>[ImageTableColumn.id],
        where: '${ImageTableColumn.id} = ?',
        whereArgs: <Object?>[id],
        limit: 1,
      );
      return list.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> collectImage(ImageModel image) async {
    final db = await source.getDatabase();
    try {
      final exists = await isImageExistById(image.id ?? -1, db);
      if (!exists) {
        await db.insert(
          MyDateBaseValue.Image,
          _ImageDaoUtils.toDbMap(image),
        );
      } else {
        await db.update(
          MyDateBaseValue.Image,
          <String, Object?>{
            ImageTableColumn.collectStatus: image.collectStatus?.index,
          },
          where: '${ImageTableColumn.id} = ?',
          whereArgs: <Object?>[image.id],
        );
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateDownloadImageStatus(ImageModel image) async {
    final db = await source.getDatabase();
    try {
      final exists = await isImageExistById(image.id ?? -1, db);
      if (!exists) {
        await db.insert(
          MyDateBaseValue.Image,
          _ImageDaoUtils.toDbMap(image),
        );
      } else {
        final values = <String, Object?>{
          ImageTableColumn.downloadStatus: image.downloadStatus?.index,
        };
        if (image.downloadStatus == ImageDownloadStatus.success) {
          values[ImageTableColumn.downloadPath] = image.downloadPath;
        }
        await db.update(
          MyDateBaseValue.Image,
          values,
          where: '${ImageTableColumn.id} = ?',
          whereArgs: <Object?>[image.id],
        );
      }
    } catch (e) {
      // 下载状态更新失败不影响调用方继续（保持幂等）。
    }
  }

  Future<List<ImageModel>> getAllCollectedImage(int page, int limit) async {
    final db = await source.getDatabase();
    try {
      final list = await db.query(
        MyDateBaseValue.Image,
        where: '${ImageTableColumn.collectStatus} = ?',
        whereArgs: <Object?>[ImageCollectStatus.star.index],
        offset: (page - 1) * limit,
        limit: limit,
      );
      return list
          .map((item) => ImageModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e) {
      return <ImageModel>[];
    }
  }

  Future<List<ImageModel>> getAllDownloadedImage() async {
    final db = await source.getDatabase();
    try {
      final list = await db.query(
        MyDateBaseValue.Image,
        where: '${ImageTableColumn.downloadStatus} = ?',
        whereArgs: <Object?>[ImageDownloadStatus.success.index],
      );
      return list
          .map((item) => ImageModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e) {
      return <ImageModel>[];
    }
  }

  Future<void> resetDownloadStatus(int id) async {
    final db = await source.getDatabase();
    try {
      await db.update(
        MyDateBaseValue.Image,
        <String, Object?>{
          ImageTableColumn.downloadStatus: ImageDownloadStatus.none.index,
          ImageTableColumn.downloadPath: null,
        },
        where: '${ImageTableColumn.id} = ?',
        whereArgs: <Object?>[id],
      );
    } catch (e) {
      // ???????
    }
  }

  Future<void> updateCollectStatus(
    ImageModel image, [
    Database? database,
  ]) async {
    final db = database ?? await source.getDatabase();
    try {
      await db.update(
        MyDateBaseValue.Image,
        <String, Object?>{
          ImageTableColumn.collectStatus: image.collectStatus?.index,
        },
        where: '${ImageTableColumn.id} = ?',
        whereArgs: <Object?>[image.id],
      );
    } catch (e) {
      // 忽略更新失败。
    }
  }
}

class _ImageDaoUtils {
  static Map<String, Object?> toDbMap(ImageModel image) {
    return <String, Object?>{
      ImageTableColumn.id: image.id,
      ImageTableColumn.tags: image.tags,
      ImageTableColumn.author: image.author,
      ImageTableColumn.fileUrl: image.fileUrl,
      ImageTableColumn.source: image.source,
      ImageTableColumn.fileSize: image.fileSize,
      ImageTableColumn.fileExt: image.fileExt,
      ImageTableColumn.previewUrl: image.previewUrl,
      ImageTableColumn.previewWidth: image.previewWidth,
      ImageTableColumn.previewHeight: image.previewHeight,
      ImageTableColumn.rating: image.rating,
      ImageTableColumn.width: image.width,
      ImageTableColumn.height: image.height,
      ImageTableColumn.sampleUrl: image.sampleUrl,
      ImageTableColumn.jpegUrl: image.jpegUrl,
      ImageTableColumn.jpegWidth: image.jpegWidth,
      ImageTableColumn.jpegHeight: image.jpegHeight,
      ImageTableColumn.jpegFileSize: image.jpegFileSize,
      ImageTableColumn.dataSourceName: image.dataSourceName,
      ImageTableColumn.collectStatus: image.collectStatus?.index,
      ImageTableColumn.downloadStatus: image.downloadStatus?.index,
      ImageTableColumn.downloadPath: image.downloadPath,
    };
  }
}
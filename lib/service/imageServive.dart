import 'package:flutter/foundation.dart';
import 'package:yande/appliction.dart';
import 'package:yande/dao/init_dao.dart';
import 'package:yande/model/image_model.dart';
import 'package:yande/model/tag_model.dart';
import 'package:yande/service/settingService.dart';
import 'package:yande/store/store.dart';

class ImageService {
  static Future<List<ImageModel>> getIndexListByPage(
    int pages,
    int limit, {
    String? sourceName,
  }) async {
    final source = _getAppDataSource(sourceName);
    final list = await source.fetchImageByPage(pages, limit);
    if (list.isEmpty) {
      throw NoImageError();
    }
    list.removeWhere(_imageFilter);
    list.removeWhere((image) => TagStore.isBlockedByName(image.tags));
    return list;
  }

  static Future<List<ImageModel>> getImageByTag(
    String tags,
    int pages,
    int limit, {
    String? sourceName,
  }) async {
    final source = _getAppDataSource(sourceName);
    final list = await source.fetchImageByTag(tags, pages, limit);
    if (list.isEmpty) {
      throw NoImageError();
    }
    list.removeWhere(_imageFilter);
    list.removeWhere((image) => TagStore.isBlockedByName(image.tags));
    return list;
  }

  static Future<ImageModel> collectImage(ImageModel image) async {
    final source = _getAppDataSource(DaoDataSource.name) as AppDaoDataSource;
    image.collectStatus =
        (image.collectStatus == ImageCollectStatus.unStar ||
                image.collectStatus == null)
            ? ImageCollectStatus.star
            : ImageCollectStatus.unStar;
    await source.collectImage(image);
    return image;
  }

  static Future<List<ImageModel>> getAllCollectedImage(
    int page,
    int limit,
  ) async {
    final source = _getAppDataSource(DaoDataSource.name) as AppDaoDataSource;
    final imageList = await source.getAllCollectedImage();
    if (imageList.isNotEmpty) {
      for (final imageModel in imageList) {
        imageModel.pages = page;
        imageModel.tagTagModelList = imageModel.tags
            ?.split(' ')
            .map(TagModel.fromTagString)
            .toList();
      }
    }
    return imageList;
  }

  static bool _imageFilter(ImageModel image) =>
      applyFilterRank(image, Application.getInstance().filterRank);

  static AppDataSource _getAppDataSource(String? sourceName) {
    return Application.getInstance().dataPool.getSource(sourceName);
  }
}

/// true 表示该图片应被过滤掉（与旧 `_imageFilter` 语义一致）。
@visibleForTesting
bool applyFilterRank(ImageModel image, String? filterRank) {
  if (filterRank == FILTER_RANK.RESTRICTED) {
    return false;
  } else if (filterRank == FILTER_RANK.NOT_RESTRICTED) {
    return image.rating == FILTER_RANK.RESTRICTED;
  } else {
    return image.rating == FILTER_RANK.RESTRICTED ||
        image.rating == FILTER_RANK.NOT_RESTRICTED;
  }
}

class NoImageError extends Error {}
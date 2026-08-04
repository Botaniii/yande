import 'package:yande/appliction.dart';
import 'package:yande/dao/init_dao.dart';
import 'package:yande/model/tag_model.dart';

class TagService {
  static Future<List<TagModel>> getTagByNameOrderAESC(
    String name, {
    String? sourceName,
  }) async {
    final source = _getAppDataSource(sourceName) as AppHttpDataSource;
    return source.searchTag(name);
  }

  static Future<void> saveTag(TagModel tag) async {
    final source = _getAppDataSource(DaoDataSource.name) as AppDaoDataSource;
    await source.saveTag(tag);
  }

  static Future<List<TagModel>> getAllCollectTag() async {
    final source = _getAppDataSource(DaoDataSource.name) as AppDaoDataSource;
    return source.getAllCollectTag();
  }

  static Future<List<TagModel>> getAllBlockTag() async {
    final source = _getAppDataSource(DaoDataSource.name) as AppDaoDataSource;
    return source.getAllBlockTag();
  }

  static Future<void> setCollectStatus(TagModel tag) async {
    tag.collectStatus = TagCollectStatus.collected;
    await TagService.saveTag(tag);
  }

  static AppDataSource _getAppDataSource(String? sourceName) {
    return Application.getInstance().dataPool.getSource(sourceName);
  }
}

const BLOCK_TAG = 'blockTag';